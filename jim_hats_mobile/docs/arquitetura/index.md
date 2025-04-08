## 🏗️ Visão Geral da Arquitetura do Projeto

A aplicação mobile Jim Hats foi desenvolvida com uma arquitetura em camadas, inspirada no padrão MVP (Model-View-Presenter). Essa estrutura foi adotada de forma que as camadas inferiores não conheçam as superiores, promovendo um baixo acoplamento entre os módulos da aplicação.

Além disso, foram implementadas técnicas de injeção de dependência, facilitando a realização de testes unitários. Isso permite a substituição de implementações reais por objetos mockados, possibilitando o isolamento e controle do comportamento durante os testes.

Dessa forma, a aplicação mantém uma hierarquia clara de dependências entre as camadas, promovendo uma arquitetura mais escalável, testável e de fácil manutenção.

Uma melhor explicação sobre cada camada pode ser encontrada na imagem abaixo:
<div align="center">
  <img src="../../../readme-assets/diagrama_arquitetura_jim_hats_flutter.drawio.png" alt="Arquitetura do projeto" width="600"/>
  <p>Arquitetura do projeto</p>
</div>

### Camada Model

A camada Model é responsável por gerenciar os dados da aplicação. Ela contém as classes que representam os dados e a lógica de negócios, além de realizar operações de leitura e gravação em fontes de dados, como bancos de dados ou APIs. No contexto da aplicação ela é representada por 2 subcamadas:

- **Data Sources**: Responsável por comunicar a aplicação com a API, realizando operações de leitura e gravação de dados. Essa camada é responsável por fazer as requisições HTTP e retornar os dados convertidos para objetos dart. As classes dessa camada recebem uma fonte de dados como parâmetro em seus construtores, permitindo a injeção de dependência. Isso facilita a realização de testes unitários, pois é possível substituir a implementação real por uma versão mockada, nessa aplicação a maioria dos data sources recebm um cliente HTTP como parâmetro para realizar as requisições.

- **Repositories**: Responsável por fornecer uma interface para acessar os dados da aplicação. Ela encapsula a lógica de acesso aos dados e fornece métodos para realizar operações específicas. Os repositórios utilizam os data sources para obter os dados necessários e podem aplicar regras de negócios antes de retorná-los à camada Presenter. Além disso, os repositórios foram pensados para implementarem a lógica de cache em memória, evitando chamadas desnecessárias à API. Essa lógica é implementada através de um serviço de cache que é injetado nos repositórios. Ademais, Os repositórios recebem os `data sources` como parâmetro em seus construtores, permitindo a injeção de dependência e ,assim, facilitando a realização de testes unitários.

Exemplo de um Data Source utilizado na aplicação:

```dart
//Abstração
abstract class LoggedUserDataSource {
  Future<LoggedUser> getLoggedUser();
  Future<void> updateLoggedUser(UpdateLoggedUserDto updateLoggedUserDto);
}

//Implementação
class NetworkLoggedUserDataSource implements LoggedUserDataSource {
  final HttpService _httpClient;
  NetworkLoggedUserDataSource({
    required HttpService httpClient,
  }) : _httpClient = httpClient;

  @override
  Future<LoggedUser> getLoggedUser() async {
    try {
      final response = await _httpClient.get(
        '/users/me',
      );
      return LoggedUser.fromMap(response['data']);
    } on UnauthorizedException {
      throw InvalidTokenException();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateLoggedUser(UpdateLoggedUserDto updateLoggedUserDto) async {
    await _httpClient.patch(
      '/users/me',
      data: updateLoggedUserDto.toMap(),
    );
  }
}
```
Como pode ser observado, a implementação do `NetworkLoggedUserDataSource` utiliza o `HttpService` para realizar as requisições HTTP. O `HttpService` é uma abstração que representa um cliente HTTP e pode ser facilmente substituído por uma implementação mockada durante os testes unitários.

Exemplo de um Repository utilizado na aplicação:

```dart
class LoggedUserRepository {
  final LoggedUserDataSource _loggedUserDataSource;
  final CacheService _cacheService;
  // cache???

  LoggedUserRepository({
    required LoggedUserDataSource loggedUserDataSource,
    required CacheService cacheService,
  })  : _cacheService = cacheService,
        _loggedUserDataSource = loggedUserDataSource;

  Future<LoggedUser> getLoggedUser() async {
    var loggedUser = _cacheService.get<LoggedUser>('loggedUser');
    if (loggedUser == null) {
      //await Future.delayed(Duration(seconds: 2));
      loggedUser = await _loggedUserDataSource.getLoggedUser();
      _cacheService.store(
        'loggedUser',
        loggedUser,
        duration: Duration(
          minutes: 1,
        ),
      );
    }
    return loggedUser;
  }

  Future<LoggedUser> updateLoggedUser(
    UpdateLoggedUserDto updateLoggedUserDto,
  ) async {
    await _loggedUserDataSource.updateLoggedUser(updateLoggedUserDto);
    final loggedUser = await getLoggedUser();
    return loggedUser.copyWith(
      profilePicture: updateLoggedUserDto.profilePicture,
    );
  }
}
```
Como pode ser observado, o `LoggedUserRepository` utiliza o `LoggedUserDataSource` para obter os dados do usuário logado. Além disso, ele utiliza o `CacheService` para armazenar os dados em memória e evitar chamadas desnecessárias à API. O repositório também possui um método para atualizar os dados do usuário logado, que chama o método correspondente no data source e atualiza o cache.

Na aplicação, as classes que representam essa camada podem ser encontradas em `lib/data`.

### Camada Presenter

A camada Presenter é responsável por gerenciar a lógica de apresentação da aplicação. Ela atua como intermediária entre a camada Model e a camada View, recebendo os dados da camada Model e formatando-os para serem exibidos na interface do usuário. Além disso, ela também recebe as interações do usuário na View e as repassa para a camada Model.

Essa camada é responsável por implementar a lógica de negócios da aplicação, como validações e formatações de dados. Ela também é responsável por gerenciar o estado da View, atualizando-a sempre que houver mudanças nos dados.

No contexto da aplicação, a camada Presenter é representada pelos Blocs/Cubits,estes são responsáveis por capturar eventos das views e emitir os estados correspondentes.Além disso, eles recebem os repositórios como parâmetro em seus construtores, para serem utilizados como comunicação com a camada Model. Isso permite que os Blocs/Cubits sejam testados de forma isolada, substituindo os repositórios por implementações mockadas.

Exemplo de um Cubit utilizado na aplicação:

```dart
class GymChallengeDetailsPageCubit extends Cubit<GymChallengeDetailsPageState> {
  final GymChallengesRepository _gymChallengesRepository;
  final LoggedUserRepository _loggedUserRepository;
  GymChallengeDetailsPageCubit(
      {required GymChallengesRepository gymChallengesRepository,
      required LoggedUserRepository loggedUserRepository})
      : _loggedUserRepository = loggedUserRepository,
        _gymChallengesRepository = gymChallengesRepository,
        super(GymChallengeDetailsPageInitial());

  void loadData(int challengeId) async {
    try {
      emit(GymChallengeDetailsPageLoadDataInProgress());
      final loggedUser = await _loggedUserRepository.getLoggedUser();
      final data = await Future.wait([
        _gymChallengesRepository.getGymChallengesOfUser(loggedUser.id),
        _gymChallengesRepository.getMembersOfChallenge(challengeId),
      ]);

      final challenges = data[0] as List<GymChallenge>;
      final currentChallenge = challenges.firstWhere(
        (element) => element.id == challengeId,
      );
      final members = data[1] as List<ChallengeMember>;
      emit(
        GymChallengeDetailsPageLoadSuccess(
          challenge: currentChallenge,
          members: members,
          admin: _getAdminOfChallenge(currentChallenge, members),
        ),
      );
    } catch (e) {
      emit(GymChallengeDetailsPageLoadError());
    }
  }

  ChallengeMember _getAdminOfChallenge(
      GymChallenge challenge, List<ChallengeMember> members) {
    final creatorId = challenge.creatorId;
    final admin = members.firstWhere(
      (member) => member.id == creatorId,
    );
    return admin;
  }
}
```
Como pode ser observado, o `GymChallengeDetailsPageCubit` utiliza os repositórios para obter os dados necessários e emite os estados correspondentes. Ele também possui um método para obter o administrador do desafio, que é utilizado para exibir as informações corretas na View.

Na aplicação, as classes que representam essa camada podem ser encontradas em `lib/presentation/cubits` ou  `lib/presentation/blocs`.

### Camada View

A camada View é responsável por exibir os dados para o usuário e capturar as interações do usuário. Ela é composta pelas telas e widgets da aplicação, que são responsáveis por renderizar a interface do usuário.

Essa camada é responsável por realizar inscrições em eventos emitidos pelos Blocs/Cubits e atualizar a interface do usuário sempre que houver mudanças nos estados. Além disso, ela também é responsável por capturar as interações do usuário e repassá-las para a camada Presenter.

Exemplo de uma View utilizada na aplicação:

```dart
class RankingPage extends StatelessWidget {
  final RankingPageArguments rankingPageArguments;
  const RankingPage({
    super.key,
    required this.rankingPageArguments,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RankingPageCubit>(
      create: (context) => locator.get<RankingPageCubit>()
        ..loadData(rankingPageArguments.challengeId),
      child: const RankingView(),
    );
  }
}

class RankingView extends StatelessWidget {
  const RankingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<RankingPageCubit, RankingPageState>(
        bloc: context.read<RankingPageCubit>(),
        builder: (context, state) {
          if (state is RankingPageDataLoadInProgress) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is RankingPagedDataLoadSuccess) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppSpacings.horizontalPadding),
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        state.challenge.name,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    LinearProgressIndicator(
                      value: _getRemainingDaysPercentage(
                          startDate: state.challenge.startAt,
                          endDate: state.challenge.endAt),
                      minHeight: 20,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Starts ${DateHelper.formatDateShort(state.challenge.startAt)}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            'Finishes ${DateHelper.formatDateShort(state.challenge.endAt)}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'Rankings',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    ListView.builder(
                      itemCount: state.rankings.length,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(state.rankings[index].username),
                          subtitle: Text(
                              '${state.rankings[index].logCount} days active'),
                          leading: UserCircleAvatar(
                            username: state.rankings[index].username,
                            avatarUrl: state.rankings[index].profilePicture,
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'Group stats',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    ListTile(
                      title: Text(
                          key: Key('RankingView.total_count_text'),
                          '${context.read<RankingPageCubit>().countTotalOfLogs(state.rankings)}'),
                      subtitle: Text('Total check-ins'),
                      leading: Icon(Icons.monitor_heart),
                    )
                  ],
                ),
              ),
            );
          }
          return SizedBox.shrink(
            key: Key('RankingView.shrinked_sized_box'),
          );
        },
      ),
    );
  }

  double _getRemainingDaysPercentage({
    required DateTime startDate,
    required DateTime endDate,
  }) {
    final today = DateTime.now();

    final challengeTimeInDays = endDate.difference(startDate).inDays;
    final daysPassed = today.difference(startDate).inDays;
    if (daysPassed <= 0) return 0;
    final percentage = daysPassed.toDouble() / challengeTimeInDays.toDouble();

    return percentage.isNaN ? 0 : percentage;
  }
}

```
Como pode ser observado, a `RankingView` utiliza o `RankingPageCubit` para obter os dados necessários e exibi-los na interface do usuário. Ela também possui um método para calcular a porcentagem de dias restantes do desafio, que é utilizado para exibir uma barra de progresso. O Cubit é consumido via service locator e o BlocProvider é responsável por criar a instância do Cubit e disponibilizá-la para a árvore de widgets, e quando o widget é removido da árvore, o BlocProvider também remove a instância do Cubit, liberando os recursos utilizados.

Para atualizar a interface do usuário, a `RankingView` utiliza o `BlocBuilder`, que é responsável por escutar os estados emitidos pelo `RankingPageCubit` e atualizar a interface sempre que houver uma mudança de estado. O `BlocBuilder` é um widget que se reconstrói sempre que o estado muda, permitindo que a interface do usuário seja atualizada de forma reativa.

Na aplicação, as classes que representam essa camada podem ser encontradas em `lib/presentation/views`.
### Componentes auxiliares

Além das camadas principais, a aplicação também possui uma série de classes auxiliares que são utilizadas por todas as camadas. Podem ser localizadas em `lib/core` e são responsáveis por fornecer funcionalidades comuns, como formatação de datas, validação de dados,declaração de exceções, entre outras.
Essas classes são utilizadas para evitar a duplicação de código e promover a reutilização de funcionalidades em toda a aplicação. Elas são projetadas para serem independentes das camadas Model, Presenter e View, permitindo que sejam utilizadas em qualquer parte da aplicação.

exemplo de uma classe auxiliar:

```dart
class MemoryCacheService implements CacheService {
  final Map<String, dynamic> _cacheHashMap = {};

  @override
  void store<V>(String key, V value,
      {Duration duration = const Duration(seconds: 5)}) {
    _cacheHashMap[key] = value;
    Future.delayed(
      duration,
      () {
        remove(key);
      },
    );
  }

  @override
  void clearCache() {
    _cacheHashMap.clear();
  }

  @override
  void remove(String key) {
    _cacheHashMap.remove(key);
  }

  @override
  V? get<V>(String key) {
    return _cacheHashMap[key] as V?;
  }
}
```
A classe `MemoryCacheService` é uma implementação simples de um serviço de cache em memória. Ela armazena os dados em um `Map` e permite armazenar, remover e obter os dados do cache. Além disso, ela também possui um método para limpar todo o cache. Na aplicação, ela injetada como dependência nos repositórios.

<hr>

[Página anterior](../tecnologias-utilizadas/index.md) | [Próxima página](../testes/index.md)

[Voltar ao início](../index.md)