import 'package:jim_hats_mobile/core/utils/application_exception.dart';

class TokenNotFoundException extends ApplicationException {
  TokenNotFoundException() : super(message: 'Token not found');
}
