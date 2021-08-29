# advent-of-code-dart

My solutions to the [Advent of Code][1] puzzles written in the
[Dart][2] programming language. I love solving programming puzzles, and
I wanted to get more familiar with the base library features of Dart as I 
use it in my [day job][3], which is mostly UI related and less general CS.

Given that, these are just my solutions to the problems. There are likely
cleaner, faster or more idiomatic ways to do this in Dart (if so, please
drop me a line and let me know).

## Usage

This project was developed with Dart 2.15. To run the solutions, you 
can run the following from the top level directory of the repo:

```shell
dart bin/main.dart
```

Which should print out the solutions for each day. You can also just run them
as tests with: 

```shell
dart test
```

Each of the days has the expected solution encoded in it, so the test just
runs the day's code and checks it against the expected solution.

## Code layout

- The main program to run everything is `bin/main.dart`.
- Each yearly event's code is located in `src/20XX/dayXX.dart`.
- Useful supporting utilities live in `src/util`.

## Support the cause if you can

The Advent of Code is an awesome event that we can all look forward to each
year. If you can, please support Eric's efforts at:

https://adventofcode.com/support

[1]: https://adventofcode.com/
[2]: https://dart.dev
[3]: https://flutter.dev
