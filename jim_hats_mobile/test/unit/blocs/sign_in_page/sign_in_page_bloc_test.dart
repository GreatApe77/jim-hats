import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/data/auth/repositories/auth_repository.dart';
import 'package:jim_hats_mobile/presentation/blocs/sign_in_page/sign_in_page_bloc.dart';
import 'package:mockito/annotations.dart';

import 'sign_in_page_bloc_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AuthRepository>()])
void main() {
  late MockAuthRepository mockAuthRepository;
  late SignInPageBloc sut;
  setUp(
    () {
      mockAuthRepository = MockAuthRepository();
      sut = SignInPageBloc(
        authRepository: mockAuthRepository,
      );
    },
  );
}
