import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iranshahr_plate/iranshahr.dart';

// Throwaway: ink extent per unit glyphHeight for every UAE caption.
void main() {
  testWidgets('probe', (tester) async {
    final loader = FontLoader('Roboto');
    for (final p in const [
      '/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf',
      '/usr/share/fonts/truetype/noto/NotoSansArabic-Bold.ttf',
    ]) {
      loader.addFont(
        File(p).readAsBytes().then((b) => ByteData.view(b.buffer)),
      );
    }
    await loader.load();
    final texts = <String>{
      for (final s in [
        UaePlates.abuDhabiLong,
        UaePlates.abuDhabiShort,
        UaePlates.ajmanLong,
        UaePlates.ajmanShort, //
        UaePlates.dubaiLong,
        UaePlates.dubaiShort,
        UaePlates.fujairahLong,
        UaePlates.fujairahShort,
        UaePlates.rasAlKhaimahLong,
        UaePlates.rasAlKhaimahShort,
        UaePlates.sharjahLong,
        UaePlates.sharjahShort,
        UaePlates.ummAlQuwainLong, UaePlates.ummAlQuwainShort,
      ])
        for (final l in s.labels) l.text,
      'A',
      '23456',
    }.toList();
    for (final (i, t) in texts.indexed) {
      // ignore: avoid_print
      print('PROBE\t$i\t$t');
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Container(
            color: const Color(0xFFFFFFFF),
            alignment: Alignment.center,
            child: SizedBox(
              width: 2000,
              height: 200,
              child: Center(
                child: Text(
                  t,
                  softWrap: false,
                  style: UaeThemes.long.glyphStyle(
                    100,
                    const Color(0xFF000000),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      await expectLater(
        find.byType(SizedBox),
        matchesGoldenFile('_probe/p$i.png'),
      );
    }
  });
}
