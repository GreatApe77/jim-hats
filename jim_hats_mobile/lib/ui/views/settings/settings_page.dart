import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jim_hats_mobile/locator.dart';
import 'package:jim_hats_mobile/shared/ui/constants/app_spacings.dart';
import 'package:jim_hats_mobile/shared/ui/widgets/app_drawer/app_drawer.dart';
import 'package:jim_hats_mobile/shared/ui/widgets/app_drawer/cubit/app_drawer_cubit.dart';
import 'package:jim_hats_mobile/ui/views/settings/cubit/settings_cubit.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, required this.settingsCubit});
  final SettingsCubit settingsCubit;
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
    widget.settingsCubit.loadSettingsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      drawer: AppDrawer(appDrawerCubit: locator.get<AppDrawerCubit>()),
      body: Center(
          child: BlocBuilder<SettingsCubit, SettingsState>(
        bloc: widget.settingsCubit,
        builder: (context, state) {
          if (state is SettingsInitial) {
            return SizedBox.shrink();
          }
          if (state is SettingsDataLoadInProgress) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is SettingsDataLoadSuccess) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppSpacings.horizontalPadding.toDouble()),
                child: ListView(
                  children: [
                    Text(
                      'General',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    ListTile(
                      title: Text('Change profile picture'),
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(state.loggedUser.profilePicture ?? ''),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.person_outlined),
                      title: Text('Name'),
                      subtitle: Text(state.loggedUser.username),
                    ),
                    ListTile(
                      leading: Icon(Icons.email_outlined),
                      title: Text('Email'),
                      subtitle: Text(state.loggedUser.email),
                    ),
                    ListTile(
                      leading: Icon(Icons.key_outlined),
                      title: Text('Password'),

                      subtitle: Text('••••••••'),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Theme',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    ListTile(
                      leading: Icon(Icons.format_paint),
                      title: Text('Theme'),
                    ),
                    Text(
                      'Account',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    ListTile(
                      leading: Icon(Icons.logout_outlined),
                      title: Text('Sign out'),
                    ),
                    ListTile(
                      textColor: Theme.of(context).colorScheme.error,
                      leading: Icon(Icons.person_remove_outlined,
                      color: Theme.of(context).colorScheme.error,),
                      title: Text('Delete account'),
                      
                    ),
                  ],
                ),
              ),
            );
          }
          return SizedBox.shrink();
        },
      )),
    );
  }
}
