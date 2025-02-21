import 'package:jim_hats_mobile/shared/utils/application_exception.dart';

class TokenNotFoundException extends ApplicationException {
  TokenNotFoundException() : super(message: 'Token not found');
}
