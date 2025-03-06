import 'package:jim_hats_mobile/core/utils/application_exception.dart';

class TimeOutException extends ApplicationException {
  TimeOutException()
      : super(message: 'The Server is taking too long to answer');
}
