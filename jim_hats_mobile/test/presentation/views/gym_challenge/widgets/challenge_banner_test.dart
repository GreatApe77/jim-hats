import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/data/gym_challenges/models/gym_challenge.dart';
import 'package:jim_hats_mobile/data/gym_challenges/models/ranking.dart';
import 'package:jim_hats_mobile/presentation/views/gym_challenge/widgets/challenge_banner.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  final sampleLeader = Ranking(id: 2, username: 'Leader', logCount: 200);
  final sampleUserRanking = Ranking(id: 3, username: 'User', logCount: 132);
  final sampleChallenge = GymChallenge(
    id: 4,
    name: 'June Challenge',
    description: '30 days of june',
    createdAt: DateTime(2025),
    startAt: DateTime(2025, 6),
    endAt: DateTime(2025, 7),
    creatorId: 3,
  );
  testWidgets('Should display user and leader log counts', (tester) async {
    mockNetworkImagesFor(
      () async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ChallengeBanner(
                challenge: sampleChallenge,
                leader: sampleLeader,
                user: sampleUserRanking,
                onTap: () {},
              ),
            ),
          ),
        );
        expect(find.text('${sampleLeader.logCount}'), findsOne);
        expect(find.text('${sampleUserRanking.logCount}'), findsOne);
      },
    );
  });
  testWidgets('Should display days left', (tester) async {
    mockNetworkImagesFor(
      () async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ChallengeBanner(
                challenge: sampleChallenge,
                leader: sampleLeader,
                user: sampleUserRanking,
                onTap: () {},
              ),
            ),
          ),
        );
        final daysLeft = '30';
        final daysLeftWidget =
            tester.firstWidget(find.byKey(ChallengeBanner.daysLeftKey)) as Text;
        expect(daysLeftWidget.data, daysLeft);
      },
    );
  });
  testWidgets('Should trigger onTap', (tester) async {
    mockNetworkImagesFor(
      () async {
        bool executed = false;
        void sampleOnTapFunction() {
          executed = true;
        }

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ChallengeBanner(
                challenge: sampleChallenge,
                leader: sampleLeader,
                user: sampleUserRanking,
                onTap: sampleOnTapFunction,
              ),
            ),
          ),
        );
        await tester.tap(find.byKey(ChallengeBanner.mainInkWellKey));
        await tester.pump();
        expect(executed, isTrue);
      },
    );
  });
}
