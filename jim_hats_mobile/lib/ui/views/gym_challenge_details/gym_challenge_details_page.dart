import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jim_hats_mobile/locator.dart';
import 'package:jim_hats_mobile/core/constants/app_spacings.dart';
import 'package:jim_hats_mobile/ui/views/gym_challenge/gym_challenge_page_arguments.dart';
import 'package:jim_hats_mobile/presentation/cubits/gym_challenge_details_page/gym_challenge_details_page_cubit.dart';

class GymChallengeDetailsPage extends StatefulWidget {
  const GymChallengeDetailsPage(
      {super.key,
      required this.pageArguments,
      required this.gymChallengeDetailsPageCubit});
  final GymChallengePageArguments pageArguments;
  final GymChallengeDetailsPageCubit gymChallengeDetailsPageCubit;
  @override
  State<GymChallengeDetailsPage> createState() =>
      _GymChallengeDetailsPageState();
}

class _GymChallengeDetailsPageState extends State<GymChallengeDetailsPage> {
  @override
  void initState() {
    super.initState();
    widget.gymChallengeDetailsPageCubit
        .loadData(widget.pageArguments.challengeId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppSpacings.horizontalPadding.toDouble()),
        child: BlocBuilder<GymChallengeDetailsPageCubit,
            GymChallengeDetailsPageState>(
              bloc: widget.gymChallengeDetailsPageCubit,
          builder: (context, state) {
            if (state is GymChallengeDetailsPageLoadDataInProgress) {
              return Center(
                child: const CircularProgressIndicator(),
              );
            }
            if(state is GymChallengeDetailsPageLoadError){
              return Center(
                child: const Text('Error'),
              );
            }
            if (state is GymChallengeDetailsPageLoadSuccess) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      state.challenge.name,
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(state.admin.username),
                    subtitle: Text('Group Admin'),
                    leading: CircleAvatar(backgroundImage: NetworkImage(state.admin.profilePicture??''),),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${state.members.length} Members'),
                      InkWell(
                        child: Text(
                          'All',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 60,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          width: 10,
                        );
                      },
                      //children: [],
                      itemCount: state.members.length,
                      itemBuilder: (context, index) {
                        return CircleAvatar(
                          backgroundImage: NetworkImage(state.members[index].profilePicture?? ''),
                        );
                      },
                      //  List.generate(
                      //   20,
                      //   (index) => CircleAvatar(),
                      // ),
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    onTap: () {},
                    textColor: Theme.of(context).colorScheme.error,
                    leading: Icon(
                      Icons.logout,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    title: Text('Leave'),
                  )
                ],
              );
            }
            return SizedBox.shrink();
          },
        ),
      )),
    );
  }
}
