import 'package:core_plate/core_plate.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iranshahr_plate/iranshahr.dart';

/// What Qatar claims, one test each.
///
/// Most of it is the same spec-consistency check every country here gets. The
/// part worth pinning is [QatarFlagEdgeClipper], because its geometry is a
/// transcription of the official flag construction and a silent drift in it
/// would still paint *a* zigzag — just not Qatar's.
void main() {
  group('the specs', () {
    test('every design is internally consistent', () {
      for (final spec in QatarPlates.all) {
        expect(debugValidateSpec(spec), isTrue, reason: spec.id);
      }
    });

    test('five designs, each with its own id', () {
      expect(QatarPlates.all, hasLength(5));
      expect(QatarPlates.all.map((s) => s.id).toSet(), hasLength(5));
    });

    test('the civilian plate runs three to five digits', () {
      expect(QatarPlates.civilianSizes.map((s) => s.slotCount), <int>[5, 4, 3]);
      for (final spec in QatarPlates.civilianSizes) {
        expect(
          spec.indicesOfGroup('serial'),
          hasLength(spec.slotCount),
          reason: spec.id,
        );
      }
    });

    test('every civilian length fills the same room', () {
      // The point of the shared span: the serial is centred the same way at
      // three, four and five digits, so the sizes read as one design.
      for (final spec in QatarPlates.civilianSizes) {
        final boxes = spec.slots.map((s) => s.box).toList();
        final left = boxes.first.left;
        final right = boxes.last.left + boxes.last.width;
        expect(
          (left + right) / 2,
          closeTo((209 + 500) / 2, 1),
          reason: spec.id,
        );
      }
    });

    test('the figures widen as they get fewer', () {
      final widths = QatarPlates.civilianSizes
          .map((s) => s.slots.first.box.width)
          .toList();
      // civilianSizes is longest-first, so each shorter serial sets wider.
      expect(widths[1], greaterThan(widths[0]));
      expect(widths[2], greaterThan(widths[1]));
      // ...but never past the cap that would make a digit read as a logo.
      expect(widths.last, lessThanOrEqualTo(64));
    });

    test('every civilian size shares the serrated hoist block', () {
      for (final spec in QatarPlates.civilianSizes) {
        expect(spec.panel.shape, isA<QatarFlagEdgeClipper>(), reason: spec.id);
        // The block is the flag, so it holds no flag of its own.
        expect(spec.country.flag, isNull, reason: spec.id);
        expect(spec.panel.flagScale, 0, reason: spec.id);
      }
    });

    test('the motorcycle plate is its own design, not a shrunk car', () {
      final moto = QatarPlates.motorcycle;
      // Near-square, where the car plate is a long European rectangle.
      expect(moto.canvasWidth / moto.canvasHeight, lessThan(2));
      expect(
        QatarPlates.civilian.canvasWidth / QatarPlates.civilian.canvasHeight,
        greaterThan(4),
      );
      // No block, so nothing to serrate.
      expect(moto.noPanel, isTrue);
      expect(moto.panel.shape, isNull);
      // It names the country in both scripts and nothing else.
      expect(
        moto.labels.map((l) => l.text),
        containsAll(<String>['قطر', 'QATAR']),
      );
      expect(moto.slotCount, 5);
    });

    test('the police plate has no block and no serration', () {
      expect(QatarPlates.police.noPanel, isTrue);
      expect(QatarPlates.police.panel.shape, isNull);
      expect(QatarPlates.police.slotCount, 4);
    });
  });

  group('the flag edge', () {
    // A block the size of the real one, so the numbers below are in the same
    // units the spec is written in.
    const size = Size(54, 110);
    final path = const QatarFlagEdgeClipper().getClip(size);

    /// How far inboard the shape reaches at [y] — the rightmost x still inside
    /// it, found by stepping in from the tip.
    double edgeAt(double y) {
      for (var x = size.width; x >= 0; x -= 0.05) {
        if (path.contains(Offset(x, y))) return x;
      }
      return 0;
    }

    test('the spine sits at 22/28 of the width', () {
      // Every triangle's base is a valley, and the boundaries between them fall
      // at whole multiples of height/9.
      const spine = 54 * 22 / 28;
      for (var i = 1; i < 9; i++) {
        expect(edgeAt(110 * i / 9), closeTo(spine, 0.5), reason: 'valley $i');
      }
    });

    test('nine tips reach the full width', () {
      final step = 110 / 9;
      for (var i = 0; i < 9; i++) {
        expect(edgeAt(i * step + step / 2), closeTo(54, 0.5), reason: 'tip $i');
      }
    });

    test('the block is solid back to the hoist edge', () {
      // Nothing is cut out of the left of the column — the serration is one
      // edge, not a pattern through the block.
      for (var y = 1.0; y < 110; y += 5) {
        expect(path.contains(Offset(1, y)), isTrue, reason: 'y=$y');
      }
    });

    test('it reclips only against a different clipper', () {
      const clipper = QatarFlagEdgeClipper();
      expect(clipper.shouldReclip(const QatarFlagEdgeClipper()), isFalse);
    });
  });

  testWidgets('the civilian plate paints', (tester) async {
    final controller = PlateController(spec: QatarPlates.civilian)
      ..setValues(const <String?>['1', '2', '3', '4', '5', '6']);
    addTearDown(controller.dispose);

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: Center(
          child: SizedBox(
            width: 520,
            height: 110,
            child: PlateCanvas(
              spec: QatarPlates.civilian,
              country: QatarCountry.civilian,
              theme: QatarThemes.civilian,
              mode: PlateMode.display,
              controller: controller,
              onChooseCharacter: (_) async => null,
            ),
          ),
        ),
      ),
    );
    expect(tester.takeException(), isNull);
    // The clip is in the tree, holding the block to the flag's shape.
    expect(
      find.byWidgetPredicate(
        (w) => w is ClipPath && w.clipper is QatarFlagEdgeClipper,
      ),
      findsOneWidget,
    );
  });
}
