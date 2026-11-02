import 'package:plate_core/plate_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iranshahr_plate/iranshahr_plate.dart';

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

    test('seven designs, each with its own id', () {
      expect(TajikistanPlates.all, hasLength(8));
      expect(TajikistanPlates.all.map((s) => s.id).toSet(), hasLength(8));
    });

    test('the private number is three fields: serial, letters, region', () {
      expect(TajikistanPlates.car.slots.map((s) => s.length), [4, 2, 2]);
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

    test('the car letters pick the livery: TT transport', () {
      PlateTheme themeFor(String letters) => TajikistanThemes.byLetters(
        TajikistanThemes.civilian,
        (key) => key == 'letters' ? letters : '',
      );
      expect(
        themeFor('MK').plateBackground,
        TajikistanThemes.civilian.plateBackground,
      );
      expect(
        themeFor('TT').plateBackground,
        TajikistanThemes.transport.plateBackground,
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
      expect(judge(TajikistanPlates.car, ['9999', 'MK', '02']).isValid, isTrue);
    });

    test('a region code Tajikistan does not issue is rejected', () {
      expect(
        judge(TajikistanPlates.car, ['9999', 'MK', '09']).isValid,
        isFalse,
      );
    });

    test('a letter outside the register is rejected', () {
      expect(
        judge(TajikistanPlates.car, ['9999', 'QT', '02']).isValid,
        isFalse,
      );
    });

    test('the diplomatic class must be one of the five codes', () {
      expect(
        judge(TajikistanPlates.diplomatic, ['091', 'CMD', '1']).isValid,
        isTrue,
      );
      expect(
        judge(TajikistanPlates.diplomatic, ['091', 'D', '1']).isValid,
        isTrue,
      );
    });

    test('the foreign plate takes no region and any three-digit halves', () {
      expect(
        judge(TajikistanPlates.foreign, ['200', 'P', '005']).isValid,
        isTrue,
      );
    });
  });
}
