import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/presentation/views/user_stats/widgets/stats_item.dart';

void main() {
  testWidgets(
    'Stats Item must show its text content',
    (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: const StatsItem(
          key: Key('StatsItem'),
          label: 'Label',
          value: 'Some Value',
        ),
      ));
      final labelFinder = find.text('Label');
      final valueFinder = find.text('Some Value');
      expect(labelFinder, findsOneWidget);
      expect(valueFinder, findsOneWidget);
    },
  );
}
