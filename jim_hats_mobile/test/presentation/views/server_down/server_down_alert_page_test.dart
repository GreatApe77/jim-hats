import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/presentation/routing/app_routes.dart';
import 'package:jim_hats_mobile/presentation/views/server_down/server_down_alert_page.dart';

void main() {
  testWidgets(
    'Should display content',
    (widgetTester) async {
      await widgetTester.pumpWidget(
        MaterialApp(
          home: ServerDownAlertPage(),
        ),
      );
      expect(
        find.text('Sorry, there is something wrong with the server'),
        findsOne,
      );
      expect(find.text('Retry'), findsOne);
      expect(find.byType(TextButton), findsOneWidget);
    },
  );
  testWidgets(
    'Should navigate to splash on button tap',
    (widgetTester) async {
      await widgetTester.pumpWidget(
        MaterialApp(
          home: ServerDownAlertPage(),
          routes: {
            AppRoutes.splash: (context) => Scaffold(
                  body: Text(AppRoutes.splash),
                ),
          },
        ),
      );
      final retryBtn = find.byType(TextButton);
      await widgetTester.tap(retryBtn);
      await widgetTester.pumpAndSettle();
      expect(find.text(AppRoutes.splash), findsOne);
    },
  );
}
