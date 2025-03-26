import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/presentation/theme/fonts.dart';

void main() {
  testWidgets(
    'Should create a text theme based on font family',
    (tester) async {
      await tester.pumpWidget(
        Builder(
          builder: (context) {
            final textTheme = createTextTheme(
              context,
              'Inter',
              'Inter',
            );
            expect(textTheme, isA<TextTheme>());
            return SizedBox.fromSize();
          },
        ),
      );
    },
  );
}
