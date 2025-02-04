import 'package:flutter/material.dart';
import 'package:jim_hats_mobile/data/logged_user/repositories/logged_user_repository.dart';
import 'package:jim_hats_mobile/locator.dart';
import 'package:jim_hats_mobile/shared/ui/widgets/app_drawer/cubit/app_drawer_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    widget.appDrawerCubit.loadLoggedUser();
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
              if (state is AppDrawerLoadUserInProgress) {
                return ListTile(
                  leading: CircularProgressIndicator(),
                );
              }
              if (state is AppDrawerLoadUserSuccess) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        NetworkImage(state.loggedUser.profilePicture ?? ''),
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
          ...List.generate(
            2,
            (index) => ListTile(
              title: Text('$index'),
            ),
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
