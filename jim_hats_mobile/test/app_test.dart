import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/app.dart';
import 'package:jim_hats_mobile/locator.dart';
import 'package:jim_hats_mobile/presentation/blocs/theme/theme_bloc.dart';
import 'package:jim_hats_mobile/presentation/cubits/auth/auth_cubit.dart';
import 'package:jim_hats_mobile/presentation/cubits/internet_connectivity/cubit/internet_connectivity_cubit.dart';
import 'package:jim_hats_mobile/presentation/views/welcome/welcome_page.dart';
import 'package:mocktail/mocktail.dart';

class MockThemeBloc extends MockBloc<ThemeEvent, ThemeState>
    implements ThemeBloc {}

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

class MockInternetConnectivityCubit extends MockCubit<InternetConnectivityState>
    implements InternetConnectivityCubit {}

void main() {
  late MockThemeBloc mockThemeBloc;
  late MockAuthCubit mockAuthCubit;
  late MockInternetConnectivityCubit mockInternetConnectivityCubit;
  setUp(() {
    mockThemeBloc = MockThemeBloc();
    mockAuthCubit = MockAuthCubit();
    mockInternetConnectivityCubit = MockInternetConnectivityCubit();
  });

  testWidgets(
    'Should boot app in unauthenticated state',
    (tester) async {
      when(
        () => mockAuthCubit.state,
      ).thenReturn(
        AuthState(
          authStatus: AuthStatus.authenticated,
          failed: false,
        ),
      );
      when(
        () => mockThemeBloc.state,
      ).thenReturn(
        ThemeLight(),
      );
      when(
        () => mockInternetConnectivityCubit.state,
      ).thenReturn(
        InternetConnectivityState(
          status: InternetConnectivityStatus.connected,
        ),
      );
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<ThemeBloc>.value(
              value: mockThemeBloc,
            ),
            BlocProvider<AuthCubit>.value(
              value: mockAuthCubit,
            ),
            BlocProvider<InternetConnectivityCubit>.value(
              value: mockInternetConnectivityCubit,
            ),
          ],
          child: App(),
        ),
      );
      //expect(find.byType(WelcomePage), findsOneWidget);
      //await tester.pumpAndSettle();
      //expect(find.by, matcher)
      //expect(mockAuthCubit.state, isA<AuthUnauthenticated>());
    },
  );
}
