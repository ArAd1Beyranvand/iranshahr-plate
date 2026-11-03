import 'package:flutter/widgets.dart';

/// The serrated inboard edge of Qatar's hoist block.
///
/// Qatar is the one country in this package whose country block is not a
/// rectangle. The block is the hoist end of the flag itself: a maroon column
/// whose right edge is the flag's nine-point serration, and the plate's white
/// field shows through the notches. A [PlateRule] cannot draw that and a
/// [PlateBox] cannot describe it, so the shape is a clipper handed to
/// [PlatePanel.shape].
///
/// The geometry is the flag's own, not an eyeballed approximation. The official
/// construction draws the white
/// hoist as a path over a `75 × 18` field:
///
/// ```
/// M22,18 H0 V0 H22 l6,1 -6,1 l6,1 -6,1 …   (nine times)
/// ```
///
/// which is nine triangles, each two units of height tall, whose tips reach
/// `6` units inboard of a spine at `x = 22`. So in fractions of the block:
///
/// - the spine — the valleys, the leftmost the edge comes — sits at
///   `22/28` of the width, because the block this clipper cuts is the maroon
///   one and its full width runs out to the tips at `28`;
/// - the tips reach the full width;
/// - there are [_points] triangles spanning the whole height, tip-centred.
///
/// Measured against the reference photograph (1000 × 221 px) the same numbers
/// come back: nine peaks at `x ≈ 103`, nine valleys at `x ≈ 86`, over a block
/// running `13 → 103`, which is a spine at `(86-13)/(103-13) = 0.81 ≈ 22/28`.
class QatarFlagEdgeClipper extends CustomClipper<Path> {
  const QatarFlagEdgeClipper();

  /// Nine serrations, per the flag's construction sheet.
  static const int _points = 9;

  /// Where the valleys sit, as a fraction of the block's width. `22/28` of the
  /// flag's white hoist, which is this block's maroon mirror image.
  static const double _spine = 22 / 28;

  @override
  Path getClip(Size size) {
    final spine = size.width * _spine;
    // Each triangle owns an equal share of the height and its tip is at the
    // middle of that share, so the edge leaves and returns to the spine at
    // every boundary — including the top and bottom edges, which is why the
    // corners are valleys and not half-teeth.
    final step = size.height / _points;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(spine, 0);
    for (var i = 0; i < _points; i++) {
      final top = i * step;
      path
        ..lineTo(size.width, top + step / 2)
        ..lineTo(spine, top + step);
    }
    return path
      ..lineTo(0, size.height)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) =>
      oldClipper is! QatarFlagEdgeClipper;
}
