import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/presentation/widgets/user_circle_avatar/user_circle_avatar.dart';

void main() {
  testWidgets(
    'Should display initials (Uppercased) if no avatar url is provided',
    (widgetTester) async {
      await widgetTester.pumpWidget(
        MaterialApp(
          home: UserCircleAvatar(
            avatarUrl: null,
            username: 'Mateus',
          ),
        ),
      );

      final initialsFinder = find.text('MA');
      expect(initialsFinder, findsOne);
    },
  );
}
