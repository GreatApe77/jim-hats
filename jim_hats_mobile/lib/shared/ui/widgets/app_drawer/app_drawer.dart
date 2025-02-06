import 'package:flutter/material.dart';
import 'package:jim_hats_mobile/data/logged_user/repositories/logged_user_repository.dart';
import 'package:jim_hats_mobile/locator.dart';
import 'package:jim_hats_mobile/routing/app_router.dart';
import 'package:jim_hats_mobile/routing/app_routes.dart';
import 'package:jim_hats_mobile/shared/ui/widgets/app_drawer/cubit/app_drawer_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jim_hats_mobile/ui/views/gym_challenge/gym_challenge_page_arguments.dart';

class AppDrawer extends StatefulWidget {
  final AppDrawerCubit appDrawerCubit;
  const AppDrawer({super.key, required this.appDrawerCubit});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  void initState() {
    super.initState();
    widget.appDrawerCubit.loadDrawerData();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          BlocBuilder<AppDrawerCubit, AppDrawerState>(
            bloc: widget.appDrawerCubit,
            builder: (context, state) {
              if (state is AppDrawerInitial) {
                return SizedBox.shrink();
              }
              if (state is AppDrawerLoadDataInProgress) {
                return ListTile(
                  leading: CircularProgressIndicator(),
                );
              }
              if (state is AppDrawerLoadDataSuccess) {
                return ListTile(
                  selected: ModalRoute.of(context)?.settings.name ==
                      AppRoutes.userStats,
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRoutes.userStats);
                  },
                  leading: CircleAvatar(
                    backgroundImage:
                        NetworkImage(state.loggedUser.profilePicture ?? 'https://ui-avatars.com/api/?name=${state.loggedUser.username}'),
                  ),
                  title: Text(state.loggedUser.username),
                );
              }
              return SizedBox.shrink();
            },
          ),
          Divider(
            height: 32,
          ),
          BlocBuilder<AppDrawerCubit, AppDrawerState>(
            bloc: widget.appDrawerCubit,
            builder: (context, state) {
              if (state is AppDrawerInitial) {
                return SizedBox.shrink();
              }
              if (state is AppDrawerLoadDataInProgress) {
                return ListTile(
                  leading: CircularProgressIndicator(),
                );
              }
              if (state is AppDrawerLoadDataSuccess) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: state.challenges
                      .map(
                        (e) => ListTile(
                          onTap: () {
                            final gymChallengePageArgs = GymChallengePageArguments(challengeId: e.id);
                            Navigator.of(context).pushNamed(AppRoutes.gymChallenge,arguments: gymChallengePageArgs);
                          },
                          title: Text(e.name),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(e.image ?? ''),
                          ),
                        ),
                      )
                      .toList(),
                );
              }
              return SizedBox.shrink();
            },
          ),
          Divider(
            height: 32,
          ),
          ListTile(
            leading: Icon(Icons.add_circle_outline),
            title: Text('Create group'),
          ),
          ListTile(
            leading: Icon(Icons.group_outlined),
            title: Text('Join group'),
          ),
          ListTile(
            leading: Icon(Icons.flag_outlined),
            title: Text('Completed challenges'),
          ),
          Divider(),
          ListTile(
            selected:
                ModalRoute.of(context)?.settings.name == AppRoutes.settings,
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.settings);
            },
            leading: Icon(Icons.settings_outlined),
            title: Text('Settings'),
          ),
          ListTile(
            leading: Icon(Icons.help_outline),
            title: Text('Help & feedback'),
          ),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('About'),
          ),
        ],
      ),
    );
  }
}
