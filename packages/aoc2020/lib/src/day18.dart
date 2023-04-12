// https://adventofcode.com/2020/day/18

import 'package:aoc/aoc.dart';
import 'package:aoc/util/string.dart';
import 'package:collection/collection.dart';

main() => Day18().solve();

class Day18 extends AdventDay {
  Day18() : super(2020, 18, name: 'Operation Order');

  @override
  dynamic part1(String input) =>
    input
      .lines
      .map((exp) => evaluate(exp, samePrecedence))
      .sum;

  @override
  dynamic part2(String input) =>
    input
      .lines
      .map((exp) => evaluate(exp, additionHigherPrecedence))
      .sum;

  Iterable<Token> tokenize(String text) sync* {
    final tokenPatterns = <TokenType, RegExp>{
      TokenType.number: RegExp(r'\s*?(\d+)'),
      TokenType.plus: RegExp(r'\s*?\+\s*?'),
      TokenType.times: RegExp(r'\s*?\*\s*?'),
      TokenType.openParen: RegExp(r'\s*?\('),
      TokenType.closeParen: RegExp(r'\s*?\)'),
    };

    while (text.isNotEmpty) {
      for (final pattern in tokenPatterns.entries) {
        final match = pattern.value.matchAsPrefix(text);
        if (match != null) {
          if (pattern.key == TokenType.number) {
            yield Token(pattern.key, int.parse(match.group(0)!));
          } else {
            yield Token(pattern.key);
          }
          text = text.substring(match.end);
          break;
        }
      }
    }
  }

  Iterable<Token> parse(String expressionText, Comparator<TokenType> operatorPrecedence) sync* {
    final tokens = tokenize(expressionText).iterator;
    final opStack = <Token>[];
    while (tokens.moveNext()) {
      final current = tokens.current;
      switch (current.type) {
        case TokenType.number:
          yield current;
          break;
        case TokenType.plus:
        case TokenType.times:
          while (opStack.isNotEmpty &&
                 opStack.last.type != TokenType.openParen &&
                 operatorPrecedence(opStack.last.type, current.type) <= 0) {
            yield opStack.removeLast();
          }
          opStack.add(current);
          break;
        case TokenType.openParen:
          opStack.add(current);
          break;
        case TokenType.closeParen:
          while (opStack.last.type != TokenType.openParen) {
            yield opStack.removeLast();
          }
          opStack.removeLast();
          break;
      }
    }
    yield* opStack.reversed;
  }

  int evaluate(String expressionText, Comparator<TokenType> operatorPrecedence) {
    final tokens = parse(expressionText, operatorPrecedence).iterator;
    final stack = <int>[];

    while (tokens.moveNext()) {
      switch (tokens.current.type) {
        case TokenType.number:
          stack.add(tokens.current.value!);
          break;
        case TokenType.plus:
          stack.add(stack.removeLast() + stack.removeLast());
          break;
        case TokenType.times:
          stack.add(stack.removeLast() * stack.removeLast());
          break;
        case TokenType.openParen:
        case TokenType.closeParen:
          throw Exception('Parenthesis should not be in parsed token stream');
      }
    }
    assert(stack.length == 1);
    return stack.last;
  }
}

enum TokenType { number, plus, times, openParen, closeParen }

class Token {
  Token(this.type, [this.value]);

  final TokenType type;
  final int? value;
}

int samePrecedence(TokenType a, TokenType b) => 0;

int additionHigherPrecedence(TokenType a, TokenType b) {
  if (a == TokenType.times && b == TokenType.plus) {
    return 1;
  }
  if (a == TokenType.plus && b == TokenType.times) {
    return -1;
  }
  return 0;
}
