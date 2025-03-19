import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/presentation/views/welcome/welcome_page.dart';

void main() {
  testWidgets(
    'Welcome page should display app name',
    (widgetTester) async {
      await widgetTester.pumpWidget(MaterialApp(
        home: WelcomePage(),
      ));
      expect(find.textContaining('Jim Hats'), findsOne);
    },
  );
}
