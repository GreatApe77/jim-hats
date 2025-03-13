import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jim_hats_mobile/locator.dart';
import 'package:jim_hats_mobile/presentation/routing/app_routes.dart';
import 'package:jim_hats_mobile/core/constants/app_spacings.dart';
import 'package:jim_hats_mobile/presentation/cubits/auth/auth_cubit.dart';
import 'package:jim_hats_mobile/presentation/widgets/app_drawer/app_drawer.dart';
import 'package:jim_hats_mobile/presentation/cubits/app_drawer/app_drawer_cubit.dart';
import 'package:jim_hats_mobile/presentation/widgets/take_photo_widget/take_photo_widget.dart';
import 'package:jim_hats_mobile/presentation/blocs/theme/theme_bloc.dart';
import 'package:jim_hats_mobile/presentation/cubits/settings_page/settings_cubit.dart';
import 'package:jim_hats_mobile/presentation/widgets/user_circle_avatar/user_circle_avatar.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingsCubit>(
      create: (context) => locator.get<SettingsCubit>()..loadSettingsData(),
      child: const SettingsView(),
    );
  }
}

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      drawer: AppDrawer(appDrawerCubit: locator.get<AppDrawerCubit>()),
      body: Center(
          child: BlocBuilder<SettingsCubit, SettingsState>(
        bloc: context.read<SettingsCubit>(),
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
                    horizontal: AppSpacings.horizontalPadding),
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
                        final settingsCubit =
                            BlocProvider.of<SettingsCubit>(context);
                        showModalBottomSheet(
                          showDragHandle: true,
                          context: context,
                          routeSettings: ModalRoute.of(context)?.settings,
                          builder: (context) => BlocProvider.value(
                            value: settingsCubit,
                            child: SafeArea(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: AppSpacings.horizontalPadding
                                        ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      'Photo Selection',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                    ListTile(
                                      onTap: () =>
                                          _updatePhoto(context, settingsCubit),
                                      title: Text('Update photo'),
                                      leading: Icon(Icons.image),
                                    ),
                                    ListTile(
                                      onTap: () =>
                                          _removePhoto(context, settingsCubit),
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
                          ),
                        );
                      },
                      title: Text('Change profile picture'),
                      leading: UserCircleAvatar(
                        avatarUrl: state.loggedUser.profilePicture,
                        username: state.loggedUser.username,
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
                      bloc: context.read<ThemeBloc>(),
                      builder: (context, state) {
                        return ListTile(
                          leading: state is ThemeDark
                              ? Icon(Icons.dark_mode)
                              : Icon(Icons.light_mode),
                          title: Text('Toggle'),
                          trailing: Switch(
                            value: state is ThemeDark,
                            onChanged: (value) {
                              context
                                  .read<ThemeBloc>()
                                  .add(ThemeToggledEvent());
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
                      bloc: context.read<AuthCubit>(),
                      listener: (context, state) {
                        if (state.authStatus == AuthStatus.unauthenticated) {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            AppRoutes.welcome,
                            (route) => false,
                          );
                        }
                      },
                      child: ListTile(
                        onTap: () => _logOut(context),
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

  void _removePhoto(BuildContext context, SettingsCubit settingCubit) {
    Navigator.of(context).pop();
    settingCubit.updateLoggedUserProfilePicture(null);
  }

  void _updatePhoto(BuildContext context, SettingsCubit settingsCubit) {
    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: settingsCubit,
          child: TakePhotoWidget(
            onPhotoChosen: (photo) {
              Navigator.of(context).pop();
              if (photo == null) return;
              settingsCubit.updateLoggedUserProfilePicture(photo);
            },
          ),
        ),
      ),
    );
  }

  void _logOut(BuildContext context) {
    context.read<AuthCubit>().logOut();
  }
}
