## Testes Automatizados do Projeto

No projeto Jim Hats, foram implementados testes unitários e de widget para garantir a qualidade do código e a funcionalidade do aplicativo. Os testes foram realizados utilizando o framework de testes do Flutter além de bibliotecas auxiliares como `mockito` e `bloc_test`.

### Testes Unitários
Os testes unitários foram implementados para verificar a lógica de negócios e o funcionamento correto das classes e métodos do aplicativo. Eles garantem que cada unidade de código funcione conforme o esperado, permitindo identificar rapidamente problemas e falhas.

Os testes unitários foram criados,principalmente, para as camadas Model e Presenter, onde a lógica de negócios é mais complexa. Eles incluem testes para validação de dados, manipulação de estados e tratamento de exceções.

Além disso, a técnica de injeção de dependências foi crucial para injetar objetos falsos (mocks) nas classes testadas, permitindo simular comportamentos e verificar interações entre os componentes sem depender de implementações reais.

Um exemplo de teste unitário pode ser encontrado abaixo:

```dart
@GenerateMocks([SettingsDataSource, AuthDataSource, CacheService])
void main() {
  late AuthRepository sut;
  late SettingsDataSource mockSettingsDataSource;
  late AuthDataSource mockAuthDataSource;
  late CacheService mockCacheService;
  final RegisterDto sampleRegisterDto = RegisterDto(
    username: 'username',
    email: 'email',
    password: 'password',
    profilePicture: 'profilePicture',
  );
  final LoginDto sampleLoginDto = LoginDto(
    username: 'username',
    password: 'password',
  );
  setUp(
    () {
      mockSettingsDataSource = MockSettingsDataSource();
      mockCacheService = MockCacheService();
      mockAuthDataSource = MockAuthDataSource();
      sut = AuthRepository(
        cacheService: mockCacheService,
        settingsDatasource: mockSettingsDataSource,
        authDataSource: mockAuthDataSource,
      );
    },
  );

  group(
    'Register',
    () {
      test(
        'Should register a user',
        () async {
          when(mockAuthDataSource.register(sampleRegisterDto)).thenAnswer(
            (realInvocation) => Future.value(),
          );
          await expectLater(sut.register(sampleRegisterDto), completes);
        },
      );
      test(
        'Should not register a user because data source throws a exception',
        () async {
          when(mockAuthDataSource.register(sampleRegisterDto)).thenAnswer(
            (realInvocation) => throw Exception(),
          );
          await expectLater(sut.register(sampleRegisterDto), throwsException);
        },
      );
    },
  );

  group(
    'Login',
    () {
      test(
        'Should login and return a auth token',
        () async {
          final sampleToken = 'some_token';
          when(mockAuthDataSource.login(sampleLoginDto)).thenAnswer(
            (realInvocation) async => sampleToken,
          );
          when(mockSettingsDataSource.set<String>('token', sampleToken))
              .thenAnswer(
            (realInvocation) async => Future.value(),
          );
          final token = await sut.login(sampleLoginDto);
          await expectLater(token, sampleToken);
        },
      );
      test(
        'Should not login because data source throws',
        () {
          when(mockAuthDataSource.login(sampleLoginDto)).thenAnswer(
            (_) async => throw Exception(),
          );
          expect(sut.login(sampleLoginDto), throwsException);
        },
      );
      test(
        'Should return true if the token is present',
        () async {
          String sampleToken = 'retrieved_token';
          when(mockSettingsDataSource.get<String>('token')).thenAnswer(
            (realInvocation) async => sampleToken,
          );
          final result = await sut.isLoggedIn();
          expect(result, isTrue);
        },
      );
      test(
        'Should return false if token is not present',
        () async {
          when(mockSettingsDataSource.get<String>('token')).thenAnswer(
            (realInvocation) async => null,
          );
          final result = await sut.isLoggedIn();
          expect(result, isFalse);
        },
      );
    },
  );
  group(
    'Logout',
    () {
      test(
        'Should logout',
        () async {
          await expectLater(sut.logout(), completes);
          verifyInOrder([
            mockCacheService.clearCache(),
            mockSettingsDataSource.remove('token'),
          ]);
        },
      );
    },
  );
}

```
No teste acima, o `AuthRepository` é testado para verificar se o registro e o login de um usuário funcionam corretamente. O uso de mocks permite simular o comportamento do `AuthDataSource` e do `SettingsDataSource`,estes são recriados a cada execução do teste, garantindo que o estado do teste não seja afetado por execuções anteriores.

### Testes de Widget

Os testes de widget foram implementados para verificar a interface do usuário e a interação entre os componentes. Eles garantem que os widgets sejam exibidos corretamente e que as interações do usuário sejam tratadas como esperado.
Para testar a reatividade, a camada `Presenter` é mockada para emitir estados específicos, permitindo verificar se os widgets reagem corretamente a essas mudanças de estado.

Um exemplo de teste de widget pode ser encontrado abaixo:

```dart
class MockNewCheckInPageCubit extends MockCubit<NewCheckInPageState>
    implements NewCheckInPageCubit {}

void main() {
  late MockNewCheckInPageCubit mockNewCheckInPageCubit;
  final samplePageArguments = NewCheckInPageArguments(
    photo: XFile('any'),
    challengeId: 9,
  );
  setUp(() {
    mockNewCheckInPageCubit = MockNewCheckInPageCubit();
    locator.registerFactory<NewCheckInPageCubit>(
      () => mockNewCheckInPageCubit,
    );
  });
  tearDown(() async {
    await locator.reset();
  });
  testWidgets('Should display main form components', (tester) async {
    when(
      () => mockNewCheckInPageCubit.state,
    ).thenReturn(
      NewCheckInPageState(
          status: NewCheckInPageStatus.idle,
          photo: samplePageArguments.photo,
          title: '',
          description: ''),
    );
    await tester.pumpWidget(
      MaterialApp(
        home: NewCheckInPage(
          pageArguments: samplePageArguments,
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(
      find.byKey(NewCheckInView.exerciseLogDescriptionTextFieldKey),
      findsOneWidget,
    );
    expect(
      find.byKey(NewCheckInView.postButtonKey),
      findsOneWidget,
    );
    expect(
      find.byKey(NewCheckInView.exerciseLogTitleTextFieldKey),
      findsOneWidget,
    );
  });
  testWidgets('Should display loading indicator', (tester) async {
    when(
      () => mockNewCheckInPageCubit.state,
    ).thenReturn(
      NewCheckInPageState(
        status: NewCheckInPageStatus.loading,
        photo: samplePageArguments.photo,
        title: '',
        description: '',
      ),
    );
    await tester.pumpWidget(
      MaterialApp(
        home: NewCheckInPage(
          pageArguments: samplePageArguments,
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
  testWidgets(
    'Should navigate to /gym-challenge when form submission is OK',
    (widgetTester) async {
      whenListen(
        mockNewCheckInPageCubit,
        Stream.fromIterable([
          NewCheckInPageState(
            status: NewCheckInPageStatus.success,
            photo: samplePageArguments.photo,
            title: '',
            description: '',
          ),
        ]),
        initialState: NewCheckInPageState(
          status: NewCheckInPageStatus.idle,
          photo: samplePageArguments.photo,
          title: '',
          description: '',
        ),
      );
      await widgetTester.pumpWidget(
        MaterialApp(
          routes: {
            AppRoutes.gymChallenge: (context) => const Scaffold(
                  body: Text(
                    AppRoutes.gymChallenge,
                  ),
                ),
          },
          home: NewCheckInPage(
            pageArguments: samplePageArguments,
          ),
        ),
      );
      await widgetTester.enterText(
          find.byKey(NewCheckInView.exerciseLogTitleTextFieldKey), 'title');
      await widgetTester.enterText(
          find.byKey(NewCheckInView.exerciseLogDescriptionTextFieldKey),
          'description');
      await widgetTester.tap(
        find.byKey(NewCheckInView.postButtonKey),
        warnIfMissed: false,
      );
      await widgetTester.pumpAndSettle();

      expect(find.text(AppRoutes.gymChallenge), findsOne);
    },
  );
  testWidgets(
    'Should display snack bar when form submission fails',
    (widgetTester) async {
      whenListen(
        mockNewCheckInPageCubit,
        Stream.fromIterable([
          NewCheckInPageState(
            status: NewCheckInPageStatus.failed,
            photo: samplePageArguments.photo,
            title: '',
            description: '',
          ),
        ]),
        initialState: NewCheckInPageState(
          status: NewCheckInPageStatus.idle,
          photo: samplePageArguments.photo,
          title: '',
          description: '',
        ),
      );
      await widgetTester.pumpWidget(
        MaterialApp(
          home: NewCheckInPage(
            pageArguments: samplePageArguments,
          ),
        ),
      );
      await widgetTester.enterText(
          find.byKey(NewCheckInView.exerciseLogTitleTextFieldKey), 'title');
      await widgetTester.enterText(
          find.byKey(NewCheckInView.exerciseLogDescriptionTextFieldKey),
          'description');
      await widgetTester.tap(
        find.byKey(NewCheckInView.postButtonKey),
        warnIfMissed: false,
      );
      await widgetTester.pumpAndSettle();

      expect(
        find.byType(SnackBar),
        findsOneWidget,
      );
    },
  );
  testWidgets(
    'Should display add photo btn when photo is null',
    (widgetTester) async {
      when(
        () => mockNewCheckInPageCubit.state,
      ).thenReturn(
        NewCheckInPageState(
          status: NewCheckInPageStatus.idle,
          photo: null,
          title: '',
          description: '',
        ),
      );
      await widgetTester.pumpWidget(
        MaterialApp(
          home: NewCheckInPage(
            pageArguments: samplePageArguments,
          ),
        ),
      );
      await widgetTester.pumpAndSettle();

      expect(
        find.text('Add a Photo'),
        findsOneWidget,
      );
    },
  );
  testWidgets(
    'Should display modal when media inkwell is clicked',
    (widgetTester) async {
      when(
        () => mockNewCheckInPageCubit.state,
      ).thenReturn(
        NewCheckInPageState(
          status: NewCheckInPageStatus.idle,
          photo: null,
          title: '',
          description: '',
        ),
      );
      await widgetTester.pumpWidget(
        MaterialApp(
          home: NewCheckInPage(
            pageArguments: samplePageArguments,
          ),
        ),
      );
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(
        find.byKey(NewCheckInView.mediaCardInkwellKey),
      );
      await widgetTester.pumpAndSettle();
      expect(find.text('Photo Selection'), findsOne);
    },
  );
  testWidgets(
    'Should display Take picture widget when clicking on Update Photo btn',
    (widgetTester) async {
      when(
        () => mockNewCheckInPageCubit.state,
      ).thenReturn(
        NewCheckInPageState(
          status: NewCheckInPageStatus.idle,
          photo: null,
          title: '',
          description: '',
        ),
      );
      await widgetTester.pumpWidget(
        MaterialApp(
          home: NewCheckInPage(
            pageArguments: samplePageArguments,
          ),
        ),
      );
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(
        find.byKey(NewCheckInView.mediaCardInkwellKey),
      );
      await widgetTester.pumpAndSettle();
      //Update photo
      await widgetTester.tap(
        find.text('Update photo'),
      );
      await widgetTester.pumpAndSettle();
      expect(find.byType(TakePhotoWidget), findsOneWidget);
    },
  );
}  
```
Como o exemplo acima, o `NewCheckInPage` é testado para verificar se os componentes principais são exibidos corretamente e se a navegação e as interações do usuário funcionam como esperado. O uso de mocks permite simular o comportamento do `NewCheckInPageCubit`, garantindo que o teste seja isolado e não dependa de implementações reais.

<hr>

[Página anterior](../arquitetura/index.md) | [Próxima página](../flavors/index.md)

[Voltar ao início](../index.md)