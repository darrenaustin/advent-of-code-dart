// https://adventofcode.com/2022/day/16

import 'dart:math';

import '../../day.dart';
import '../util/collection.dart';
import '../util/math.dart';

// My original solution for this worked, but took minutes to find the answer
// for the second part. After looking at r/adventofcode posts and other people's
// solutions, I managed to get this under a 200ms for both. Specifically,
// I based this solution on:
//
// Collapsing the distance map to remove 0 pressure valves:
//   https://github.com/hyper-neutrino/advent-of-code/blob/main/2022/day16p1.py
//
// Upper bound and priority queue search:
//   https://github.com/orlp/aoc2022/blob/master/src/bin/day16.rs
//
// Very smart folks, thx!

class Day16 extends AdventDay {
  Day16() : super(2022, 16, solution1: 1716, solution2: 2504);

  @override
  dynamic part1() => Volcano(inputDataLines(), 'AA', 30).maxPressure();

  @override
  dynamic part2() => Volcano(inputDataLines(), 'AA', 26, 2).maxPressure();
}

class Volcano {
  Volcano(List<String> input, String startValve, int time, [int numAgents = 1]) {
    _time = time;
    _numAgents = numAgents;

    // Parse the input into flow and tunnel maps
    final valvePattern = RegExp(r'Valve ([A-Z]+).*rate=(\d+).*valves? (.+)');
    input.forEachIndexed((id, line) {
      final match = valvePattern.firstMatch(line)!;
      final valve = match.group(1)!;
      _ids[valve] = id;
      _flow.add(int.parse(match.group(2)!));
      _tunnels.add(match.group(3)!.split(', ').toSet());
    });

    _startValve = _ids[startValve]!;

    // Compute distance from a valve to all the others (including one extra
    // to account for opening the valve when you get there). Don't
    // add entries for valves with 0 flow as they aren't worth
    // visiting directly.
    for (final valve in range(_ids.length)) {
      if (_flow[valve] == 0 && valve != _startValve) continue;

      _distance[valve] = { valve: 0, _startValve: 0 };
      final Set<int> visited = {};

      // Until we have records with destructuring: [valve, currentDistance]
      final List<List<int>> toVisit = [[valve, 0]];

      while (toVisit.isNotEmpty) {
        final current = toVisit.removeAt(0);
        for (final neighbor in _tunnels[current[0]].map((v) => _ids[v]!)) {
          if (visited.contains(neighbor)) continue;
          visited.add(neighbor);
          if (_flow[neighbor] > 0) {
            _distance[valve]![neighbor] = current[1] + 2;
          }
          toVisit.add([neighbor, current[1] + 1]);
        }
      }
      _distance[valve]!.remove(valve);
      _distance[valve]!.remove(_startValve);
    }

    // Sort the valves by biggest payoff for a given time left.
    for (final t in range(_time + 1)) {
      // Until we have records with destructuring: [valve, minDistance, flow]
      List<List<int>> valveData = [];
      for (final valve in _distance.keys) {
        final minDist = _distance[valve]!.values.min;
        if (t > minDist) {
          valveData.add([valve, minDist, _flow[valve]]);
        }
      }
      _bestValvesForTime.add(valveData
        .sorted((a, b) => (b[2] * (t - b[1])).compareTo(a[2] * (t - a[1])))
        .map((data) => data[0])
        .toList()
      );
    }
  }

  late final int _startValve;
  late final int _time;
  late final int _numAgents;
  final Map<String, int> _ids = {};
  final List<Set<String>> _tunnels = [];
  final List<int> _flow = [];
  final Map<int, Map<int, int>> _distance = {};
  final List<List<int>> _bestValvesForTime = [];

  int maxPressure() {
    final Set<_CacheState> searched = {};

    int maxPressure = 0;
    final initialState = _CacheState(List<_Agent>.generate(_numAgents, (_) => _Agent(_startValve, _time)), 0, 0);
    final searchPaths = PriorityQueue<_BoundEstimateState>(_BoundEstimateState.compare)
      ..add(_BoundEstimateState(initialState, maxInt));

    while (searchPaths.isNotEmpty) {
      final path = searchPaths.removeFirst();
      if (path.upperBound <= maxPressure) {
        return maxPressure;
      }
      if (!searched.add(path.state)) {
        continue;
      }

      final agent = path.state.agents.first;
      final opened = path.state.opened;
      for (final nextValve in _distance[agent.position]!.keys) {
        final distance = _distance[agent.position]![nextValve]!;
        final nextValveBit = 1 << nextValve;
        if (agent.time > distance && opened & nextValveBit == 0) {
          // We have time and the next valve is not yet opened.
          final nextTime = agent.time - distance;
          final nextState = _CacheState(
            [_Agent(nextValve, nextTime), ...path.state.agents.skip(1)].sorted(Comparable.compare),
            path.state.pressure + _flow[nextValve] * nextTime,
            opened | nextValveBit,
          );
          maxPressure = max(maxPressure, nextState.pressure);
          final upperBound = _estimateUpperBound(nextState);
          if (upperBound > maxPressure) {
            searchPaths.add(_BoundEstimateState(nextState, upperBound));
          }
        }
      }
    }
    throw('No solution found');
  }

  int _estimateUpperBound(_CacheState state) {
    final agentTimes = state.agents.map((a) => a.time).toList();
    int opened = state.opened;
    int upperBound = state.pressure;
    int maxTime = agentTimes.max;
    bool finished = false;
    while (!finished) {
      finished = true;
      for (final valve in _bestValvesForTime[maxTime]) {
        final valveBit = 1 << valve;
        if (opened & valveBit == 0) {
          final updatedTime = maxTime - _distance[valve]!.values.min;
          agentTimes.remove(maxTime);
          agentTimes.add(updatedTime);
          upperBound += _flow[valve] * updatedTime;
          maxTime = agentTimes.max;
          opened |= 1 << 1;
          finished = false;
          break;
        }
      }
    }
    return upperBound;
  }
}

class _CacheState {
  _CacheState(List<_Agent> agents, this.pressure, this.opened)
    : agents = agents.sorted(Comparable.compare);

  final List<_Agent> agents;
  final int pressure;
  final int opened;

  static final _agentsEquality = ListEquality<_Agent>();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is _CacheState &&
      _agentsEquality.equals(other.agents, agents) &&
      other.pressure == pressure &&
      other.opened == opened;
  }

  @override
  int get hashCode => Object.hash(agents, pressure, opened);
}

class _BoundEstimateState {
  _BoundEstimateState(this.state, this.upperBound);
  final int upperBound;
  final _CacheState state;

  static int compare(_BoundEstimateState a, _BoundEstimateState b) =>
    b.upperBound.compareTo(a.upperBound);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is _BoundEstimateState &&
      other.upperBound == upperBound &&
      other.state == state;
  }

  @override
  int get hashCode => Object.hash(upperBound, state);
}

class _Agent implements Comparable<_Agent> {
  _Agent(this.position, this.time);
  final int position;
  final int time;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is _Agent &&
      other.position == position &&
      other.time == time;
  }

  @override
  int get hashCode => Object.hash(position, time);

  @override
  int compareTo(_Agent other) => other.time.compareTo(time);
}
