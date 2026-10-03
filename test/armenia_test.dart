import 'package:core_plate/core_plate.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iranshahr_plate/iranshahr.dart';

/// The Armenian rules this package claims to enforce, one test each.
///
/// The validators are advisory by design — they check the shapes and the
/// tables the Wikipedia article gives, not a live registry — so these pin what
/// they *do* decide and nothing about the mission codes or vanity allocations
/// they decline to know about.
void main() {
  /// Judges [values] against [spec]'s validator, as a filled-in plate.
  PlateValidation judge(
    PlateSpec spec,
    List<String?> values, {
    PlateValidator? validator,
  }) => (validator ?? ArmeniaPlates.validatorFor(spec)).validate(
    PlateEntry(spec: spec, values: values),
  );

  group('the specs', () {
    test('every design is internally consistent', () {
      for (final spec in ArmeniaPlates.all) {
        expect(debugValidateSpec(spec), isTrue, reason: spec.id);
      }
    });

    test('ten designs, each with its own id', () {
      expect(ArmeniaPlates.all, hasLength(10));
      expect(ArmeniaPlates.all.map((s) => s.id).toSet(), hasLength(10));
    });

    test('the private number is seven characters in three groups', () {
      expect(ArmeniaPlates.car.slotCount, 7);
      expect(ArmeniaPlates.car.indicesOfGroup('region'), hasLength(2));
      expect(ArmeniaPlates.car.indicesOfGroup('letters'), hasLength(2));
      expect(ArmeniaPlates.car.indicesOfGroup('serial'), hasLength(3));
    });

    test('the state number is the same seven characters regrouped', () {
      expect(ArmeniaPlates.public.slotCount, 7);
      expect(ArmeniaPlates.public.indicesOfGroup('serial'), hasLength(3));
      expect(ArmeniaPlates.public.indicesOfGroup('tail'), hasLength(2));
    });

    test('only the 2014 designs carry the identifier band', () {
      for (final spec in [
        ArmeniaPlates.car,
        ArmeniaPlates.carTwoRow,
        ArmeniaPlates.public,
      ]) {
        expect(spec.rules, isNotEmpty, reason: spec.id);
      }
      for (final spec in [ArmeniaPlates.trailer, ArmeniaPlates.bus]) {
        expect(spec.rules, isEmpty, reason: spec.id);
      }
    });

    test('the three designs with their own wording carry no country block', () {
      for (final spec in [
        ArmeniaPlates.diplomatic,
        ArmeniaPlates.un,
        ArmeniaPlates.military,
      ]) {
        expect(spec.noPanel, isTrue, reason: spec.id);
      }
      expect(ArmeniaPlates.car.noPanel, isFalse);
    });

    test('the two diplomatic specs differ only in the code they print', () {
      expect(ArmeniaPlates.diplomatic.labels.single.text, 'AM');
      expect(ArmeniaPlates.diplomaticArm.labels.single.text, 'ARM');
      expect(
        ArmeniaPlates.diplomatic.slotCount,
        ArmeniaPlates.diplomaticArm.slotCount,
      );
    });

    test(
      'the military plate prints its ministry and renders its class in Armenian',
      () {
        expect(ArmeniaPlates.military.labels.single.text, 'ՊՆ');
        expect(ArmeniaAlphabets.militaryClass.render('M'), 'Մ');
        expect(ArmeniaAlphabets.militaryClass.render('T'), 'Տ');
      },
    );
  });

  group('region codes', () {
    test('every code from 01 to 99 is allocated exactly once', () {
      for (var n = 1; n <= 99; n++) {
        final code = n.toString().padLeft(2, '0');
        final province = ArmeniaRegions.provinceFor(code);
        final individual = ArmeniaRegions.individualCodes.contains(code);
        expect(province != null || individual, isTrue, reason: code);
        expect(province != null && individual, isFalse, reason: code);
      }
    });

    test('00 is not a code', () {
      expect(ArmeniaRegions.isIssued('00'), isFalse);
      expect(ArmeniaRegions.provinceFor('00'), isNull);
    });

    test('the capital holds twenty-one codes', () {
      expect(ArmeniaProvince.yerevan.codes, hasLength(21));
      expect(ArmeniaRegions.provinceFor('01'), ArmeniaProvince.yerevan);
      expect(ArmeniaRegions.provinceFor('68'), ArmeniaProvince.yerevan);
    });

    test('the reallocated Artsakh codes sit with their current holders', () {
      expect(ArmeniaRegions.provinceFor('22'), ArmeniaProvince.aragatsotn);
      expect(ArmeniaRegions.provinceFor('90'), isNull);
      expect(ArmeniaRegions.individualCodes, contains('90'));
    });
  });

  group('the letters', () {
    test('all twenty-six are accepted and all twenty-six are dated', () {
      expect(ArmeniaAlphabets.letters.characters, hasLength(26));
      for (final letter in ArmeniaAlphabets.letters.characters) {
        expect(
          ArmeniaAlphabets.introduced.containsKey(letter),
          isTrue,
          reason: letter,
        );
      }
    });

    test('the four the system opened with were in use from the start', () {
      for (final letter in ['L', 'U', 'S', 'O']) {
        expect(
          ArmeniaAlphabets.inUseOn(letter, 1996, month: 1),
          isTrue,
          reason: letter,
        );
      }
    });

    test('a letter is not in use before its month', () {
      expect(ArmeniaAlphabets.inUseOn('P', 2008, month: 11), isFalse);
      expect(ArmeniaAlphabets.inUseOn('P', 2008, month: 12), isTrue);
      expect(ArmeniaAlphabets.inUseOn('D', 2012, month: 6), isFalse);
      expect(ArmeniaAlphabets.inUseOn('D', 2012, month: 7), isTrue);
      expect(ArmeniaAlphabets.inUseOn('J', 2017), isFalse);
      expect(ArmeniaAlphabets.inUseOn('J', 2018), isTrue);
    });

    test('anything that is not a plate letter is never in use', () {
      expect(ArmeniaAlphabets.inUseOn('Ø', 2026), isFalse);
      expect(ArmeniaAlphabets.inUseOn('4', 2026), isFalse);
    });
  });

  group('the private number', () {
    List<String?> plate(String region, String letters, String serial) => [
      ...region.split(''),
      ...letters.split(''),
      ...serial.split(''),
    ];

    test('accepts the plate in the article photographs', () {
      expect(
        judge(ArmeniaPlates.car, plate('01', 'AD', '234')).isValid,
        isTrue,
      );
      expect(
        judge(ArmeniaPlates.car, plate('77', 'LU', '555')).isValid,
        isTrue,
      );
      expect(
        judge(ArmeniaPlates.car, plate('31', 'OU', '192')).isValid,
        isTrue,
      );
    });

    test('stays quiet on an empty plate and on one with no serial yet', () {
      expect(
        judge(ArmeniaPlates.car, List<String?>.filled(7, null)).isValid,
        isTrue,
      );
      expect(judge(ArmeniaPlates.car, plate('00', 'GG', '')).isValid, isTrue);
    });

    test('rejects a region code no province or pool holds', () {
      expect(
        judge(ArmeniaPlates.car, plate('00', 'AD', '234')).isValid,
        isFalse,
      );
    });

    test('rejects the letters reserved to the Police and the Prosecutor', () {
      expect(
        judge(ArmeniaPlates.car, plate('01', 'GG', '234')).isValid,
        isFalse,
      );
      expect(
        judge(ArmeniaPlates.car, plate('01', 'II', '234')).isValid,
        isFalse,
      );
      // Singly, too: no private plate carries either character at all.
      expect(
        judge(ArmeniaPlates.car, plate('01', 'AG', '234')).isValid,
        isFalse,
      );
    });

    test('accepts a serial with a leading zero', () {
      expect(
        judge(ArmeniaPlates.car, plate('01', 'AD', '001')).isValid,
        isTrue,
      );
    });

    test('checks the letter timeline only when the year is given', () {
      const dated = ArmeniaPlateValidator(issuedYear: 2015);
      expect(
        judge(ArmeniaPlates.car, plate('01', 'JW', '234')).isValid,
        isTrue,
      );
      expect(
        judge(
          ArmeniaPlates.car,
          plate('01', 'JW', '234'),
          validator: dated,
        ).isValid,
        isFalse,
      );
      expect(
        judge(
          ArmeniaPlates.car,
          plate('01', 'LU', '234'),
          validator: dated,
        ).isValid,
        isTrue,
      );
    });

    test('the two-row and motorcycle plates are judged by the same rules', () {
      for (final spec in [ArmeniaPlates.carTwoRow, ArmeniaPlates.motorcycle]) {
        expect(
          ArmeniaPlates.validatorFor(spec),
          isA<ArmeniaPlateValidator>(),
          reason: spec.id,
        );
        expect(
          judge(spec, plate('01', 'AD', '234')).isValid,
          isTrue,
          reason: spec.id,
        );
        expect(
          judge(spec, plate('01', 'GG', '234')).isValid,
          isFalse,
          reason: spec.id,
        );
      }
    });
  });

  group('the state number', () {
    List<String?> plate(String serial, String letters, String tail) => [
      ...serial.split(''),
      ...letters.split(''),
      ...tail.split(''),
    ];

    test('accepts a combination from the table', () {
      expect(
        judge(ArmeniaPlates.public, plate('001', 'NN', '01')).isValid,
        isTrue,
      ); // Security Council
      expect(
        judge(ArmeniaPlates.public, plate('123', 'GG', '01')).isValid,
        isTrue,
      ); // Prosecutor
      expect(
        judge(ArmeniaPlates.public, plate('007', 'OO', '11')).isValid,
        isTrue,
      ); // National Assembly
      expect(
        judge(ArmeniaPlates.public, plate('007', 'SL', '33')).isValid,
        isTrue,
      ); // a bank
    });

    test('rejects a tail the institution is not issued', () {
      expect(
        judge(ArmeniaPlates.public, plate('001', 'NN', '02')).isValid,
        isFalse,
      );
      expect(
        judge(ArmeniaPlates.public, plate('007', 'OO', '12')).isValid,
        isFalse,
      );
      expect(
        judge(ArmeniaPlates.public, plate('007', 'SL', '34')).isValid,
        isFalse,
      );
    });

    test('rejects a pair no institution holds', () {
      expect(
        judge(ArmeniaPlates.public, plate('001', 'AD', '01')).isValid,
        isFalse,
      );
    });

    test('stays quiet until both halves of the combination are there', () {
      expect(
        judge(ArmeniaPlates.public, [
          '0',
          '0',
          '1',
          'N',
          null,
          '0',
          null,
        ]).isValid,
        isTrue,
      );
    });

    test('three bodies share SS, told apart by the tail', () {
      expect(
        ArmeniaSpecialPlates.lookup('SS', '01')?.institution,
        'Court of Cassation',
      );
      expect(
        ArmeniaSpecialPlates.lookup('SS', '02')?.institution,
        'National Security Service',
      );
      expect(
        ArmeniaSpecialPlates.lookup('SS', '03')?.institution,
        'Government',
      );
    });

    test('the Police II number leaves its digits open', () {
      expect(ArmeniaSpecialPlates.lookup('II', '07')?.institution, 'Police');
      expect(ArmeniaSpecialPlates.lookup('II', '99')?.institution, 'Police');
    });

    test('the Police ՈՍ number is listed but cannot be typed', () {
      final os = ArmeniaSpecialPlates.all.firstWhere(
        (c) => c.armenianLetters == 'ՈՍ',
      );
      expect(os.letters, isNull);
      expect(os.matches('OS', '01'), isFalse);
      // "OS 01" is the Constitutional Court's, and nothing else claims it.
      expect(
        ArmeniaSpecialPlates.lookup('OS', '01')?.institution,
        'Constitutional Court',
      );
    });
  });

  group('the other formats', () {
    test('each gets its own validator, not the private plate\'s', () {
      expect(
        ArmeniaPlates.validatorFor(ArmeniaPlates.public),
        isA<ArmeniaPublicPlateValidator>(),
      );
      expect(
        ArmeniaPlates.validatorFor(ArmeniaPlates.trailer),
        isA<ArmeniaTrailerPlateValidator>(),
      );
      expect(
        ArmeniaPlates.validatorFor(ArmeniaPlates.bus),
        isA<ArmeniaBusPlateValidator>(),
      );
      expect(
        ArmeniaPlates.validatorFor(ArmeniaPlates.diplomatic),
        isA<ArmeniaDiplomaticPlateValidator>(),
      );
      expect(
        ArmeniaPlates.validatorFor(ArmeniaPlates.diplomaticArm),
        isA<ArmeniaDiplomaticPlateValidator>(),
      );
      expect(
        ArmeniaPlates.validatorFor(ArmeniaPlates.un),
        isA<ArmeniaSerialPlateValidator>(),
      );
      expect(
        ArmeniaPlates.validatorFor(ArmeniaPlates.military),
        isA<ArmeniaMilitaryPlateValidator>(),
      );
    });

    test('the trailer plate takes one letter and two digits under it', () {
      expect(
        judge(ArmeniaPlates.trailer, ['2', '9', '0', 'L', '0', '1']).isValid,
        isTrue,
      );
      expect(
        judge(ArmeniaPlates.trailer, ['2', '9', '0', 'G', '0', '1']).isValid,
        isFalse,
      );
    });

    test('a bus is S or L', () {
      expect(
        judge(ArmeniaPlates.bus, ['1', '2', '3', '4', 'S']).isValid,
        isTrue,
      );
      expect(
        judge(ArmeniaPlates.bus, ['1', '2', '3', '4', 'L']).isValid,
        isTrue,
      );
      // Four digits, not three: the class is set, so the number is finished
      // and a short serial is a wrong one rather than an unfinished one.
      expect(
        judge(ArmeniaPlates.bus, ['1', '2', '3', null, 'L']).isValid,
        isFalse,
      );
    });

    test('a diplomatic plate is D or T', () {
      expect(
        judge(ArmeniaPlates.diplomatic, ['0', '4', 'D', '0', '5', '7']).isValid,
        isTrue,
      );
      expect(
        judge(ArmeniaPlates.diplomatic, ['0', '4', 'T', '0', '5', '7']).isValid,
        isTrue,
      );
      expect(
        judge(ArmeniaPlates.diplomatic, [
          '0',
          '4',
          null,
          '0',
          '5',
          '7',
        ]).isValid,
        isFalse,
      );
    });

    test('a military plate is four digits and a class', () {
      expect(
        judge(ArmeniaPlates.military, ['1', '0', '0', '7', 'M']).isValid,
        isTrue,
      );
      expect(
        judge(ArmeniaPlates.military, ['1', '0', '7', null, 'M']).isValid,
        isFalse,
      );
    });

    test('the UN plate has nothing left to judge but its three digits', () {
      expect(judge(ArmeniaPlates.un, ['0', '8', '0']).isValid, isTrue);
      expect(judge(ArmeniaPlates.un, [null, null, null]).isValid, isTrue);
    });
  });
}
