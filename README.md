# advent-of-code-dart

My solutions to the [Advent of Code][1] puzzles written in the
[Dart][2] programming language. I love solving programming puzzles, and
I wanted to get more familiar with the base library features of Dart as I
use it in my [day job][3], which is mostly UI related and less general CS.

Given that, these are just my solutions to the problems. There are likely
cleaner, faster or more idiomatic ways to do this in Dart (if so, please
drop me a line and let me know).

## Input files

The input files needed for these solutions come from the [Advent of Code][1]
site and are customized for each user. They have [requested][4] that these
input files are not made publicly available. Therefore I have put my input
files in a private repo named `advent_of_code_input` and check it out as a
sibling of this repo. However, you can specify the location of this repo with
the `-DINPUT_REPO=<some path>` command line option to dart below.


## Usage

To run the all of the solutions you can use the `aoc` program:

```shell
dart bin/aoc.dart
```

Which as noted above requires the input files to be in a sibling repo.

To run just a specific year's solutions:

```shell
dart bin/aoc.dart -y 2020
```

To run only specific days you can use:

```shell
dart bin/aoc.dart -y 2020 10 11 12
```

## Tests

In  addition to the solutions there are also unit tests for each of the problems
as well as the common code in `packages/aoc`. To run the tests for a given package use:

```shell
cd packages/aoc2021
dart test
```

## Code layout

- The main program to run everything is `bin/aoc.dart`.
- Each yearly event's code is located in its own package in `packages/aoc20XX`. Each day's solution is in the package's src directory under `lib/src/dayXX.dart`.
- Useful supporting utilities live in `packages/aoc/lib/src/util`.

## Support the cause if you can

The Advent of Code is an awesome event that we can all look forward to each
year. If you can, please support Eric's efforts at:

https://adventofcode.com/support

[1]: https://adventofcode.com
[2]: https://dart.dev
[3]: https://flutter.dev
[4]: https://www.reddit.com/r/adventofcode/wiki/faqs/copyright/inputs
