import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/data/gym_challenges/models/gym_challenge.dart';
import 'package:jim_hats_mobile/data/gym_challenges/models/ranking.dart';
import 'package:jim_hats_mobile/locator.dart';
import 'package:jim_hats_mobile/presentation/cubits/ranking_page/ranking_page_cubit.dart';
import 'package:jim_hats_mobile/presentation/views/ranking/ranking_page.dart';
import 'package:jim_hats_mobile/presentation/views/ranking/ranking_page_arguments.dart';
import 'package:mocktail/mocktail.dart';

class MockRankingPageCubit extends MockCubit<RankingPageState>
    implements RankingPageCubit {}

void main() {
  late RankingPageCubit mockRankingPageCubit;
  final sampleRankingPageArguments = RankingPageArguments(challengeId: 1);
  final sampleChallenge = GymChallenge(
    id: 1,
    name: 'Sample Challenge',
    description: 'this is a simple challenge',
    createdAt: DateTime(2025),
    startAt: DateTime(2025),
    endAt: DateTime(2026),
    creatorId: 1,
  );
  final sampleRankings = [
    Ranking(
      id: 1,
      username: 'Mateus',
      logCount: 99,
    ),
    Ranking(
      id: 2,
      username: 'John',
      logCount: 150,
    ),
    Ranking(
      id: 5,
      username: 'Arthur',
      logCount: 131,
    )
  ];
  setUp(
    () {
      mockRankingPageCubit = MockRankingPageCubit();
      locator.registerFactory<RankingPageCubit>(
        () => mockRankingPageCubit,
      );
      when(() => mockRankingPageCubit
          .loadData(sampleRankingPageArguments.challengeId)).thenAnswer(
        (_) async {},
      );
    },
  );
  tearDown(
    () {
      locator.unregister<RankingPageCubit>();
    },
  );
  testWidgets('Should display ranking data', (tester) async {
    whenListen(
      mockRankingPageCubit,
      Stream<RankingPageState>.fromIterable([]),
      initialState: RankingPageInitial(),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: RankingPage(rankingPageArguments: sampleRankingPageArguments),
      ),
    );
    await tester.pump();
    expect(find.byKey(Key('RankingView.shrinked_sized_box')), findsOneWidget);
  });
  testWidgets('Should display circular progress indicator when loading',
      (tester) async {
    whenListen(
      mockRankingPageCubit,
      Stream<RankingPageState>.fromIterable([RankingPageDataLoadInProgress()]),
      initialState: RankingPageInitial(),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: RankingPage(rankingPageArguments: sampleRankingPageArguments),
      ),
    );
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    //expect(find.byKey(Key('RankingView.shrinked_sized_box')), findsOneWidget);
  });
  testWidgets('Should display page data', (tester) async {
    whenListen(
      mockRankingPageCubit,
      Stream<RankingPageState>.fromIterable([
        RankingPagedDataLoadSuccess(
          challenge: sampleChallenge,
          rankings: sampleRankings,
        )
      ]),
      initialState: RankingPageInitial(),
    );
    when(
      () => mockRankingPageCubit.countTotalOfLogs(sampleRankings),
    ).thenReturn(150);
    await tester.pumpWidget(
      MaterialApp(
        home: RankingPage(rankingPageArguments: sampleRankingPageArguments),
      ),
    );
    await tester.pump();
    expect(find.byKey(Key('RankingView.total_count_text')),findsOneWidget);
    expect(find.text('150'), findsOne);
    //expect(find.byKey(Key('RankingView.shrinked_sized_box')), findsOneWidget);
  });
}
