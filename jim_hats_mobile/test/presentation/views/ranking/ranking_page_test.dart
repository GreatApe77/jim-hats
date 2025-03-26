import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/locator.dart';
import 'package:jim_hats_mobile/presentation/cubits/ranking_page/ranking_page_cubit.dart';
import 'package:jim_hats_mobile/presentation/views/ranking/ranking_page.dart';
import 'package:jim_hats_mobile/presentation/views/ranking/ranking_page_arguments.dart';

class MockRankingPageCubit extends MockCubit<RankingPageState>
    implements RankingPageCubit {}

void main() {
  late RankingPageCubit mockRankingPageCubit;
  final sampleRankingPageArguments = RankingPageArguments(challengeId: 1);
  setUp(
    () {
      mockRankingPageCubit = MockRankingPageCubit();
      locator.registerFactory<RankingPageCubit>(
        () => mockRankingPageCubit,
      );
    },
  );
  tearDown(
    () {
      locator.unregister<RankingPageCubit>();
    },
  );
  // testWidgets('Should display ranking data', (tester) async {
  //   whenListen(
  //     mockRankingPageCubit,
  //     Stream<RankingPageState>.fromIterable([]),
  //     initialState: RankingPageInitial(),
  //   );

  //   await tester.pumpWidget(
  //     MaterialApp(
  //       home: RankingPage(rankingPageArguments: sampleRankingPageArguments),
  //     ),
  //   );
  //   await tester.pump();
  //   expect(find.byKey(Key('RankingView.shrinked_sized_box')), findsOneWidget);
  // });
}
