import 'package:flutter_test/flutter_test.dart';
import 'package:iranshahr_plate/iranshahr_plate.dart';
import 'package:plate_core/plate_core.dart';

/// Code 007 must be refused in every layer, always with "COUNTRY NOT FOUND".
void main() {
  const String notFound = 'COUNTRY NOT FOUND';
  final PlateSpec spec = KazakhstanPlates.diplomatic;
  List<String?> values(String s) => <String?>[
    s[0],
    s.substring(1, 4),
    s.substring(4),
  ];

  test('registry: name() throws, all omits it', () {
    expect(
      () => KazakhstanMissions.name('007'),
      throwsA(isA<PlateRestrictionException>()),
    );
    expect(KazakhstanMissions.all.containsKey('007'), isFalse);
    expect(KazakhstanMissions.name('001'), 'United States');
  });

  test('spec: restriction is declared', () {
    expect(spec.restrictions, contains(KazakhstanMissions.restriction));
    expect(spec.restrictionViolatedBy(values('D007618'))?.reason, notFound);
  });

  test('controller refuses 007', () {
    final PlateController c = PlateController.fromValues(spec, <String?>[
      'D',
      '00',
      '618',
    ]);
    expect(c.setAt(1, '007'), isFalse);
    expect(c.rejection.value?.reason, notFound);
    expect(c.setGroup('mission', '007'), isFalse);
    expect(c.setAt(1, '008'), isTrue);
    c.dispose();
  });

  test('validator reports it', () {
    final PlateEntry entry = PlateEntry(spec: spec, values: values('D007618'));
    expect(
      const KazakhstanDiplomaticValidator().validate(entry).reason,
      notFound,
    );
  });

  test('a listed mission validates', () {
    final PlateEntry entry = PlateEntry(spec: spec, values: values('D001618'));
    expect(
      const KazakhstanDiplomaticValidator().validate(entry).isValid,
      isTrue,
    );
  });
}
