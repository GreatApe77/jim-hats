import 'package:flutter/material.dart';
import 'package:jim_hats_mobile/presentation/routing/app_routes.dart';
import 'package:jim_hats_mobile/presentation/cubits/app_drawer/app_drawer_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jim_hats_mobile/presentation/views/gym_challenge/gym_challenge_page_arguments.dart';
import 'package:jim_hats_mobile/presentation/widgets/user_circle_avatar/user_circle_avatar.dart';

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
              if (state is AppDrawerLoadDataInProgress) {
                return ListTile(
                  leading: CircularProgressIndicator(),
                );
              }
              if (state is AppDrawerLoadDataSuccess) {
                return ListTile(
                  key: Key('AppDrawer.logged_user_list_tile'),
                  selected: ModalRoute.of(context)?.settings.name ==
                      AppRoutes.userStats,
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context)
                        .pushReplacementNamed(AppRoutes.userStats);
                  },
                  leading: UserCircleAvatar(
                    username: state.loggedUser.username,
                    avatarUrl: state.loggedUser.profilePicture,
                  ),
                  title: Text(state.loggedUser.username),
                );
              }
              return SizedBox.shrink(
                key: Key('AppDrawer.empty_logged_user'),
              );
            },
          ),
          Divider(
            height: 32,
          ),
          BlocBuilder<AppDrawerCubit, AppDrawerState>(
            bloc: widget.appDrawerCubit,
            builder: (context, state) {
              if (state is AppDrawerLoadDataInProgress) {
                return ListTile(
                  leading: CircularProgressIndicator(),
                );
              }
              if (state is AppDrawerLoadDataSuccess) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: state.challenges.map(
                    (e) {
                      GymChallengePageArguments? args;
                      if (ModalRoute.of(context)?.settings.arguments
                          is GymChallengePageArguments) {
                        args = ModalRoute.of(context)?.settings.arguments
                            as GymChallengePageArguments?;
                      }
                      return ListTile(
                        selected: args?.challengeId ==
                            e.id, //ModalRoute.of(context)?.settings.arguments.challengeId ==
                        //e.id,

                        onTap: () {
                          Navigator.of(context).pop();
                          final gymChallengePageArgs =
                              GymChallengePageArguments(challengeId: e.id);
                          Navigator.of(context).pushReplacementNamed(
                              AppRoutes.gymChallenge,
                              arguments: gymChallengePageArgs);
                        },
                        title: Text(e.name),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(e.image ?? ''),
                        ),
                      );
                    },
                  ).toList(),
                );
              }
              return SizedBox.shrink();
            },
          ),
          Divider(
            height: 32,
          ),
          ListTile(
            key: Key('AppDrawer.create_group_list_tile'),
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.createChallenge);
            },
            leading: Icon(Icons.add_circle_outline),
            title: Text('Create group'),
          ),
          ListTile(
            key: Key('AppDrawer.join_group_list_tile'),
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.joinGroup);
            },
            leading: Icon(Icons.group_outlined),
            title: Text('Join group'),
          ),
          ListTile(
            leading: Icon(Icons.flag_outlined),
            title: Text('Completed challenges'),
          ),
          Divider(),
          ListTile(
            key: Key('AppDrawer.settings_list_tile'),
            selected:
                ModalRoute.of(context)?.settings.name == AppRoutes.settings,
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed(AppRoutes.settings);
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
