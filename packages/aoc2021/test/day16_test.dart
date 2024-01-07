import 'package:aoc2021/src/day16.dart';
import 'package:test/test.dart';

main() {
  group('2021 Day 16', () {
    group('BitStream', () {
      test('basics', () {
        expect(BitStream('').isEmpty, true);
        expect(BitStream('d2fe28').isEmpty, false);
        expect(BitStream('D2FE28').length, 24);
      });

      test('next bits', () {
        final bits = BitStream('D2FE28');
        expect(bits.next(3), 6);
        expect(bits.next(3), 4);
        expect(bits.next(5), int.parse('10111', radix: 2));
        expect(bits.next(5), int.parse('11110', radix: 2));
        expect(bits.next(5), int.parse('00101', radix: 2));
      });
    });

    group('Packet', () {
      group('parse', () {
        test('literal value', () {
          final packet = Packet.parse(BitStream('D2FE28'));
          expect(packet.version, 6);
          expect(packet.type, 4);
          expect(packet.value, 2021);
        });

        test('operator fixed length', () {
          final packet = Packet.parse(BitStream('38006F45291200'));
          expect(packet.version, 1);
          expect(packet.type, 6);
          expect(packet.children?.length, 2);
          expect(packet.children?[0].value, 10);
          expect(packet.children?[1].value, 20);
        });

        test('operator fixed num children', () {
          final packet = Packet.parse(BitStream('EE00D40C823060'));
          expect(packet.version, 7);
          expect(packet.type, 3);
          expect(packet.children?.length, 3);
          expect(packet.children?[0].value, 1);
          expect(packet.children?[1].value, 2);
          expect(packet.children?[2].value, 3);
        });
      });

      group('eval', () {
        test('sum', () {
          expect(Packet.parse(BitStream('C200B40A82')).eval(), 3);
        });

        test('product', () {
          expect(Packet.parse(BitStream('04005AC33890')).eval(), 54);
        });

        test('minimum', () {
          expect(Packet.parse(BitStream('880086C3E88112')).eval(), 7);
        });

        test('maximum', () {
          expect(Packet.parse(BitStream('CE00C43D881120')).eval(), 9);
        });

        test('greater than', () {
          expect(Packet.parse(BitStream('F600BC2D8F')).eval(), 0);
        });

        test('less than', () {
          expect(Packet.parse(BitStream('D8005AC2A8F0')).eval(), 1);
        });

        test('equal to', () {
          expect(Packet.parse(BitStream('9C005AC2F8F0')).eval(), 0);
        });

        test('expression', () {
          // 1 + 3 = 2 * 2
          expect(
              Packet.parse(BitStream('9C0141080250320F1802104A08')).eval(), 1);
        });
      });
    });

    group('part 1', () {
      test('examples', () {
        expect(Day16().part1('8A004A801A8002F478'), 16);
        expect(Day16().part1('620080001611562C8802118E34'), 12);
        expect(Day16().part1('C0015000016115A2E0802F182340'), 23);
        expect(Day16().part1('A0016C880162017C3686B18A3D4780'), 31);
      });

      test('solution', () => Day16().testPart1());
    });

    group('part 2', () {
      test('solution', () => Day16().testPart2());
    });
  });
}
