import 'package:collection/collection.dart';

Iterable<L>? aStarPath<L>({
  required L start,
  required L goal,
  required double Function(L) estimatedDistance,
  required double Function(L, L) costTo,
  required Iterable<L> Function(L) neighborsOf,
}) {

  final cameFrom = <L, L>{};
  final gScore = <L, double>{start: 0};
  final fScore = <L, double>{start: estimatedDistance(start)};
  int compareByScore(L a, L b) =>
    (fScore[a] ?? double.infinity).compareTo(fScore[b] ?? double.infinity);
  final openHeap = PriorityQueue<L>(compareByScore)..add(start);
  final openSet = {start};

  while (openSet.isNotEmpty) {
    var current = openHeap.removeFirst();
    openSet.remove(current);
    if (current == goal) {
      final path = [current];
      while (cameFrom.keys.contains(current)) {
        current = cameFrom[current]!;
        path.insert(0, current);
      }
      return path;
    }
    for (final neighbor in neighborsOf(current)) {
      final tentativeScore = (gScore[current] ?? double.infinity) + costTo(current, neighbor);
      if (tentativeScore < (gScore[neighbor] ?? double.infinity)) {
        cameFrom[neighbor] = current;
        gScore[neighbor] = tentativeScore;
        fScore[neighbor] = tentativeScore + estimatedDistance(neighbor);
        if (!openSet.contains(neighbor)) {
          openSet.add(neighbor);
          openHeap.add(neighbor);
        }
      }
    }
  }
}

double? aStarLowestCost<L>({
  required L start,
  required L goal,
  required double Function(L) estimatedDistance,
  required double Function(L, L) costTo,
  required Iterable<L> Function(L) neighborsOf,
}) {

  final cameFrom = <L, L>{};
  final gScore = <L, double>{start: 0};
  final fScore = <L, double>{start: estimatedDistance(start)};
  int compareByScore(L a, L b) =>
    (fScore[a] ?? double.infinity).compareTo(fScore[b] ?? double.infinity);
  final openHeap = PriorityQueue<L>(compareByScore)..add(start);
  final openSet = {start};

  while (openSet.isNotEmpty) {
    var current = openHeap.removeFirst();
    openSet.remove(current);
    if (current == goal) {
      return gScore[current];
    }
    for (final neighbor in neighborsOf(current)) {
      final tentativeScore = (gScore[current] ?? double.infinity) + costTo(current, neighbor);
      if (tentativeScore < (gScore[neighbor] ?? double.infinity)) {
        cameFrom[neighbor] = current;
        gScore[neighbor] = tentativeScore;
        fScore[neighbor] = tentativeScore + estimatedDistance(neighbor);
        if (!openSet.contains(neighbor)) {
          openSet.add(neighbor);
          openHeap.add(neighbor);
        }
      }
    }
  }
}

Iterable<L>? dijkstraPath<L>({
  required L start,
  required L goal,
  required double Function(L, L) costTo,
  required Iterable<L> Function(L) neighborsOf,
}) {
  final dist = <L, double>{start: 0};
  final prev = <L, L>{};
  int compareByDist(L a, L b) =>
      (dist[a] ?? double.infinity).compareTo(dist[b] ?? double.infinity);
  final queue = PriorityQueue<L>(compareByDist)..add(start);

  while (queue.isNotEmpty) {
    var current = queue.removeFirst();
    if (current == goal) {
      // Reconstruct the path in reverse.
      final path = [current];
      while (prev.keys.contains(current)) {
        current = prev[current]!;
        path.insert(0, current);
      }
      return path;
    }
    for (final neighbor in neighborsOf(current)) {
      final score = dist[current]! + costTo(current, neighbor);
      if (score < (dist[neighbor] ?? double.infinity)) {
        dist[neighbor] = score;
        prev[neighbor] = current;
        queue.add(neighbor);
      }
    }
  }
}

double? dijkstraLowestCost<L>({
  required L start,
  required L goal,
  required double Function(L, L) costTo,
  required Iterable<L> Function(L) neighborsOf,
}) {
  final dist = <L, double>{start: 0};
  final prev = <L, L>{};
  int compareByDist(L a, L b) =>
      (dist[a] ?? double.infinity).compareTo(dist[b] ?? double.infinity);
  final queue = PriorityQueue<L>(compareByDist)..add(start);

  while (queue.isNotEmpty) {
    var current = queue.removeFirst();
    if (current == goal) {
      return dist[goal];
    }
    for (final neighbor in neighborsOf(current)) {
      final score = dist[current]! + costTo(current, neighbor);
      if (score < (dist[neighbor] ?? double.infinity)) {
        dist[neighbor] = score;
        prev[neighbor] = current;
        queue.add(neighbor);
      }
    }
  }
}
