import 'package:plate_core/core_plate.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iranshahr_plate/iranshahr.dart';

/// The Tajik rules this package claims to enforce, one test each.
///
/// The validators are advisory by design — they check the shapes and the region
/// table the Wikipedia article gives, not a live registry — so these pin what
/// they *do* decide.
void main() {
  PlateValidation judge(PlateSpec spec, List<String?> values) =>
      TajikistanPlates.validatorFor(
        spec,
      ).validate(PlateEntry(spec: spec, values: values));

  group('the specs', () {
    test('every design is internally consistent', () {
      for (final spec in TajikistanPlates.all) {
        expect(debugValidateSpec(spec), isTrue, reason: spec.id);
      }
    });

    test('nine designs, each with its own id', () {
      expect(TajikistanPlates.all, hasLength(9));
      expect(TajikistanPlates.all.map((s) => s.id).toSet(), hasLength(9));
    });

    test('the private number is eight characters in three groups', () {
      expect(TajikistanPlates.car.slotCount, 8);
      expect(TajikistanPlates.car.indicesOfGroup('serial'), hasLength(4));
      expect(TajikistanPlates.car.indicesOfGroup('letters'), hasLength(2));
      expect(TajikistanPlates.car.indicesOfGroup('region'), hasLength(2));
    });

    test('the flagless coloured classes carry no country block', () {
      for (final spec in [
        TajikistanPlates.foreign,
        TajikistanPlates.diplomatic,
        TajikistanPlates.governmental,
      ]) {
        expect(spec.noPanel, isTrue, reason: spec.id);
      }
      expect(TajikistanPlates.car.noPanel, isFalse);
    });

    test(
      'the flag classes each take the country block matching their field',
      () {
        expect(TajikistanPlates.car.country, TajikistanCountry.civilian);
        expect(
          TajikistanPlates.publicTransport.country,
          TajikistanCountry.transport,
        );
        expect(TajikistanPlates.police.country, TajikistanCountry.police);
      },
    );

    test('public transport prints its fixed TT and has no letter slots', () {
      expect(TajikistanPlates.publicTransport.labels.single.text, 'TT');
      expect(
        TajikistanPlates.publicTransport.indicesOfGroup('serial'),
        hasLength(4),
      );
    });

    test('the governmental plate boxes off its region with a divider', () {
      expect(TajikistanPlates.governmental.rules, isNotEmpty);
      expect(TajikistanPlates.governmental.labels.single.text, 'RT');
    });
  });

  group('region codes', () {
    test('the eight issued codes map to a region and nothing else does', () {
      for (final code in ['01', '02', '03', '04', '05', '06', '07', '08']) {
        expect(TajikistanRegions.isIssued(code), isTrue, reason: code);
      }
      expect(TajikistanRegions.isIssued('09'), isFalse);
      expect(TajikistanRegions.isIssued('00'), isFalse);
    });

    test('the capital and the republican districts hold two codes each', () {
      expect(TajikistanRegions.regionFor('01'), TajikistanRegion.dushanbe);
      expect(TajikistanRegions.regionFor('05'), TajikistanRegion.dushanbe);
      expect(
        TajikistanRegions.regionFor('04'),
        TajikistanRegion.gornoBadakhshan,
      );
    });
  });

  group('validation', () {
    test('a well-formed private plate is accepted', () {
      expect(
        judge(TajikistanPlates.car, [
          '9',
          '9',
          '9',
          '9',
          'M',
          'K',
          '0',
          '2',
        ]).isValid,
        isTrue,
      );
    });

    test('a region code Tajikistan does not issue is rejected', () {
      expect(
        judge(TajikistanPlates.car, [
          '9',
          '9',
          '9',
          '9',
          'M',
          'K',
          '0',
          '9',
        ]).isValid,
        isFalse,
      );
    });

    test('a letter outside the register is rejected', () {
      expect(
        judge(TajikistanPlates.car, [
          '9',
          '9',
          '9',
          '9',
          'Q',
          'T',
          '0',
          '2',
        ]).isValid,
        isFalse,
      );
    });

    test('the diplomatic class must be one of the five codes', () {
      expect(
        judge(TajikistanPlates.diplomatic, ['0', '9', '1', 'CMD', '1']).isValid,
        isTrue,
      );
      expect(
        judge(TajikistanPlates.diplomatic, ['0', '9', '1', 'D', '1']).isValid,
        isTrue,
      );
    });

    test('the foreign plate takes no region and any three-digit halves', () {
      expect(
        judge(TajikistanPlates.foreign, [
          '2',
          '0',
          '0',
          'P',
          '0',
          '0',
          '5',
        ]).isValid,
        isTrue,
      );
    });
  });
}
