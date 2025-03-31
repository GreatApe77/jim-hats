import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/presentation/views/splash/splah_page.dart';

void main() {
  testWidgets(
    'Splash page should display circular progress indicator',
    (widgetTester) async {
      await widgetTester.pumpWidget(MaterialApp(home: SplahPage()));
      expect(find.byType(CircularProgressIndicator), findsExactly(1));
    },
  );
}
