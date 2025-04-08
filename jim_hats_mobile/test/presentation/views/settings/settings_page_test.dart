import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/data/logged_user/models/logged_user.dart';
import 'package:jim_hats_mobile/locator.dart';
import 'package:jim_hats_mobile/presentation/blocs/theme/theme_bloc.dart';
import 'package:jim_hats_mobile/presentation/cubits/app_drawer/app_drawer_cubit.dart';
import 'package:jim_hats_mobile/presentation/cubits/auth/auth_cubit.dart';
import 'package:jim_hats_mobile/presentation/cubits/settings_page/settings_cubit.dart';
import 'package:jim_hats_mobile/presentation/routing/app_routes.dart';
import 'package:jim_hats_mobile/presentation/views/settings/settings_page.dart';
import 'package:mocktail/mocktail.dart';

class MockSettingsCubit extends MockCubit<SettingsState>
    implements SettingsCubit {}

class MockAppDrawerCubit extends MockCubit<AppDrawerState>
    implements AppDrawerCubit {}

class MockThemeBloc extends MockBloc<ThemeEvent, ThemeState>
    implements ThemeBloc {}

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
  late SettingsCubit mockSettingsCubit;
  late ThemeBloc mockThemeBloc;
  late AuthCubit mockAuthCubit;
  final changeThemeSwitchKey = Key('SettingsView.change_theme_switch');
  final signOutBtnKey = Key('SettingsView.sign_out_btn');
  final profilePictureListTileKey = Key('SettingsView.profile_pic_list_tile');
  final removePhotoListTileKey = Key('SettingsView.remove_photo_list_tile');
  final LoggedUser sampleLoggedUser = LoggedUser(
    id: 1,
    username: 'mateus',
    email: 'mateus@mateus.com',
  );
  setUp(
    () {
      mockSettingsCubit = MockSettingsCubit();
      mockThemeBloc = MockThemeBloc();
      mockAuthCubit = MockAuthCubit();
      locator.registerFactory<AppDrawerCubit>(
        () => MockAppDrawerCubit(),
      );
      locator.registerFactory<ThemeBloc>(
        () => mockThemeBloc,
      );
      locator.registerFactory<SettingsCubit>(
        () => mockSettingsCubit,
      );
      locator.registerFactory<AuthCubit>(
        () => mockAuthCubit,
      );
    },
  );
  tearDown(
    () {
      locator.unregister<AppDrawerCubit>();
      locator.unregister<SettingsCubit>();
      locator.unregister<ThemeBloc>();
      locator.unregister<AuthCubit>();
    },
  );
  testWidgets('Should display empty data', (tester) async {
    whenListen(
      mockSettingsCubit,
      Stream<SettingsState>.fromIterable([]),
      initialState: SettingsInitial(),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: SettingsPage(),
      ),
    );
    expect(find.byKey(Key('SettingsView.shrinked_sized_box')), findsOneWidget);
    //Key('SettingsView.shrinked_sized_box')
  });
  testWidgets('Should display circular progress indicator when page is loading',
      (tester) async {
    whenListen(
      mockSettingsCubit,
      Stream<SettingsState>.fromIterable([SettingsDataLoadInProgress()]),
      initialState: SettingsInitial(),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: SettingsPage(),
      ),
    );
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    //Key('SettingsView.shrinked_sized_box')
  });
  testWidgets('Should display email and username', (tester) async {
    when(
      () => mockAuthCubit.state,
    ).thenReturn(
      AuthState(authStatus: AuthStatus.authenticated, failed: false),
    );
    when(
      () => mockThemeBloc.state,
    ).thenReturn(
      ThemeLight(),
    );
    whenListen(
      mockSettingsCubit,
      Stream<SettingsState>.fromIterable([
        SettingsDataLoadSuccess(
          loggedUser: sampleLoggedUser,
        )
      ]),
      initialState: SettingsInitial(),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<ThemeBloc>(
          create: (context) => locator.get<ThemeBloc>(),
          child: BlocProvider<AuthCubit>(
            create: (context) => locator.get<AuthCubit>(),
            child: SettingsPage(),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('mateus@mateus.com'), findsOneWidget);
    expect(find.text('mateus'), findsOneWidget);
    //expect(find.byType(CircularProgressIndicator), findsOneWidget);
    //Key('SettingsView.shrinked_sized_box')
  });
  testWidgets('Should find theme mode icon (light)', (tester) async {
    when(
      () => mockAuthCubit.state,
    ).thenReturn(
      AuthState(authStatus: AuthStatus.authenticated, failed: false),
    );
    when(
      () => mockThemeBloc.state,
    ).thenReturn(
      ThemeLight(),
    );
    whenListen(
      mockSettingsCubit,
      Stream<SettingsState>.fromIterable([
        SettingsDataLoadSuccess(
          loggedUser: sampleLoggedUser,
        )
      ]),
      initialState: SettingsInitial(),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<ThemeBloc>(
          create: (context) => locator.get<ThemeBloc>(),
          child: BlocProvider<AuthCubit>(
            create: (context) => locator.get<AuthCubit>(),
            child: SettingsPage(),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.byIcon(Icons.light_mode), findsOneWidget);
  });
  testWidgets('Should find theme mode icon (dark)', (tester) async {
    when(
      () => mockAuthCubit.state,
    ).thenReturn(
      AuthState(authStatus: AuthStatus.authenticated, failed: false),
    );
    when(
      () => mockThemeBloc.state,
    ).thenReturn(
      ThemeDark(),
    );
    whenListen(
      mockSettingsCubit,
      Stream<SettingsState>.fromIterable([
        SettingsDataLoadSuccess(
          loggedUser: sampleLoggedUser,
        )
      ]),
      initialState: SettingsInitial(),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<ThemeBloc>(
          create: (context) => locator.get<ThemeBloc>(),
          child: BlocProvider<AuthCubit>(
            create: (context) => locator.get<AuthCubit>(),
            child: SettingsPage(),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.byIcon(Icons.dark_mode), findsOneWidget);
  });
  testWidgets('Should switch app theme', (tester) async {
    when(
      () => mockAuthCubit.state,
    ).thenReturn(
      AuthState(authStatus: AuthStatus.authenticated, failed: false),
    );

    whenListen(
      mockSettingsCubit,
      Stream<SettingsState>.fromIterable([
        SettingsDataLoadSuccess(
          loggedUser: sampleLoggedUser,
        )
      ]),
      initialState: SettingsInitial(),
    );
    whenListen(
      mockThemeBloc,
      Stream<ThemeState>.fromIterable([ThemeDark()]),
      initialState: ThemeLight(),
    );
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<ThemeBloc>(
          create: (context) => locator.get<ThemeBloc>(),
          child: BlocProvider<AuthCubit>(
            create: (context) => locator.get<AuthCubit>(),
            child: SettingsPage(),
          ),
        ),
      ),
    );
    await tester.pump();
    expect(find.byIcon(Icons.light_mode), findsOneWidget);
    await tester.tap(find.byKey(changeThemeSwitchKey));
    await tester.pump();
    expect(find.byIcon(Icons.dark_mode), findsOneWidget);
  });
  testWidgets('Should navigate to welcome page when signing out',
      (tester) async {
    whenListen(
      mockAuthCubit,
      Stream<AuthState>.fromIterable([
        AuthState(
          authStatus: AuthStatus.unauthenticated,
          failed: false,
        ),
      ]),
      initialState: AuthState(
        authStatus: AuthStatus.authenticated,
        failed: false,
      ),
    );
    whenListen(
      mockSettingsCubit,
      Stream<SettingsState>.fromIterable([
        SettingsDataLoadSuccess(
          loggedUser: sampleLoggedUser,
        )
      ]),
      initialState: SettingsInitial(),
    );
    whenListen(
      mockThemeBloc,
      Stream<ThemeState>.fromIterable([ThemeDark()]),
      initialState: ThemeLight(),
    );
    await tester.pumpWidget(
      MaterialApp(
        routes: {
          AppRoutes.welcome: (context) => Scaffold(
                body: Text(
                  AppRoutes.welcome,
                ),
              ),
        },
        home: BlocProvider<ThemeBloc>(
          create: (context) => locator.get<ThemeBloc>(),
          child: BlocProvider<AuthCubit>(
            create: (context) => locator.get<AuthCubit>(),
            child: SettingsPage(),
          ),
        ),
      ),
    );
    await tester.pump();
    await tester.tap(find.byKey(signOutBtnKey), warnIfMissed: false);
    await tester.pumpAndSettle();
    expect(find.text(AppRoutes.welcome), findsOne);
  });
  testWidgets(
    'Should display modal when profile picture is tapped',
    (widgetTester) async {
      when(
        () => mockThemeBloc.state,
      ).thenReturn(ThemeLight());
      when(
        () => mockSettingsCubit.state,
      ).thenReturn(
        SettingsDataLoadSuccess(
          loggedUser: sampleLoggedUser,
        ),
      );
      when(
        () => mockAuthCubit.state,
      ).thenReturn(
        AuthState(
          authStatus: AuthStatus.authenticated,
          failed: false,
        ),
      );
      await widgetTester.pumpWidget(
        MaterialApp(
          home: BlocProvider<ThemeBloc>(
            create: (context) => locator.get<ThemeBloc>(),
            child: BlocProvider<AuthCubit>(
              create: (context) => locator.get<AuthCubit>(),
              child: SettingsPage(),
            ),
          ),
        ),
      );
      await widgetTester.pump();
      final profilePictureListTile = find.byKey(profilePictureListTileKey);
      await widgetTester.tap(profilePictureListTile);
      await widgetTester.pumpAndSettle();
      expect(find.text('Photo Selection'), findsOne);
    },
  );
  // testWidgets(
  //   'Should remove profile picture',
  //   (widgetTester) async {
  //     when(
  //       () => mockThemeBloc.state,
  //     ).thenReturn(ThemeLight());

  //     when(
  //       () => mockAuthCubit.state,
  //     ).thenReturn(
  //       AuthState(
  //         authStatus: AuthStatus.authenticated,
  //         failed: false,
  //       ),
  //     );

  //     whenListen(
  //       mockSettingsCubit,
  //       Stream<SettingsState>.fromIterable(
  //         [
  //           SettingsDataLoadInProgress(),
  //           SettingsDataLoadSuccess(
  //             loggedUser: sampleLoggedUser.copyWith(
  //               profilePicture: null,
  //             ),
  //           ),
  //         ],
  //       ),
  //       initialState: SettingsDataLoadSuccess(
  //         loggedUser: sampleLoggedUser,
  //       ),
  //     );
  //     await widgetTester.pumpWidget(
  //       MaterialApp(
  //         home: BlocProvider<ThemeBloc>(
  //           create: (context) => locator.get<ThemeBloc>(),
  //           child: BlocProvider<AuthCubit>(
  //             create: (context) => locator.get<AuthCubit>(),
  //             child: SettingsPage(),
  //           ),
  //         ),
  //       ),
  //     );
  //     await widgetTester.pump();
  //     final profilePictureListTile = find.byKey(profilePictureListTileKey);
  //     await widgetTester.tap(profilePictureListTile);
  //     await widgetTester.pumpAndSettle();
  //     await widgetTester.tap(find.byKey(removePhotoListTileKey));
  //     await widgetTester.pump();
  //     expect(find.byType(CircularProgressIndicator), findsOneWidget);
  //     await widgetTester.pumpAndSettle();
  //     expect(find.byType(UserCircleAvatar), findsOneWidget);
  //   },
  // );
}
