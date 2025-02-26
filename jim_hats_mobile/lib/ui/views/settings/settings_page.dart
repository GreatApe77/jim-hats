import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jim_hats_mobile/locator.dart';
import 'package:jim_hats_mobile/presentation/routing/app_routes.dart';
import 'package:jim_hats_mobile/core/constants/app_spacings.dart';
import 'package:jim_hats_mobile/shared/ui/cubits/auth/auth_cubit.dart';
import 'package:jim_hats_mobile/shared/ui/widgets/app_drawer/app_drawer.dart';
import 'package:jim_hats_mobile/shared/ui/widgets/app_drawer/cubit/app_drawer_cubit.dart';
import 'package:jim_hats_mobile/shared/ui/widgets/take_photo_widget/take_photo_widget.dart';
import 'package:jim_hats_mobile/presentation/blocs/theme/theme_bloc.dart';
import 'package:jim_hats_mobile/presentation/cubits/settings_page/settings_cubit.dart';

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
                      onTap: () {
                        showModalBottomSheet(
                          showDragHandle: true,
                          context: context,
                          builder: (context) => SafeArea(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      AppSpacings.horizontalPadding.toDouble()),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    'Photo Selection',
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  ListTile(
                                    onTap: () => _updatePhoto(context),
                                    title: Text('Update photo'),
                                    leading: Icon(Icons.image),
                                  ),
                                  ListTile(
                                    onTap: _removePhoto,
                                    title: Text(

                                      'Remove photo',
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .error),
                                    ),
                                    leading: Icon(
                                      Icons.close,
                                      color:
                                          Theme.of(context).colorScheme.error,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
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
                    BlocBuilder<ThemeBloc, ThemeState>(
                      bloc: locator.get<ThemeBloc>(),
                      builder: (context, state) {
                        return ListTile(
                          leading: state is ThemeDark
                              ? Icon(Icons.dark_mode)
                              : Icon(Icons.light_mode),
                          title: Text('Toggle'),
                          trailing: Switch(
                            value: state is ThemeDark,
                            onChanged: (value) {
                              locator.get<ThemeBloc>().add(ThemeToggledEvent());
                            },
                          ),
                        );
                      },
                    ),
                    Text(
                      'Account',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    BlocListener<AuthCubit, AuthState>(
                      bloc: locator.get<AuthCubit>(),
                      listener: (context, state) {
                        if (state.authStatus == AuthStatus.unauthenticated) {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            AppRoutes.welcome,
                            (route) => false,
                          );
                        }
                      },
                      child: ListTile(
                        onTap: () => _logOut(),
                        leading: Icon(Icons.logout_outlined),
                        title: Text('Sign out'),
                      ),
                    ),
                    ListTile(
                      textColor: Theme.of(context).colorScheme.error,
                      leading: Icon(
                        Icons.person_remove_outlined,
                        color: Theme.of(context).colorScheme.error,
                      ),
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

  void _removePhoto() {
    Navigator.of(context).pop();
    widget.settingsCubit.updateLoggedUserProfilePicture(null);
  }

  void _updatePhoto(BuildContext context) {
    //  Navigator.of(context).push(TakePhotoWidget(onPhotoChosen: (photo) {
    //    Navigator.of(context).pop();
    //  },));
    Navigator.of(context).pop();
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => TakePhotoWidget(
        onPhotoChosen: (photo) {
          Navigator.of(context).pop();
          if (photo == null) return;
          widget.settingsCubit.updateLoggedUserProfilePicture(photo);
        },
      ),
    ));
  }

  void _logOut() {
    locator.get<AuthCubit>().logOut();
  }
}
