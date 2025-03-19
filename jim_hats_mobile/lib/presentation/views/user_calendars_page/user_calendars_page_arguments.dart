import 'package:jim_hats_mobile/data/exercise_logs/models/exercise_log.dart';
import 'package:jim_hats_mobile/data/logged_user/models/logged_user.dart';

class UserCalendarsPageArguments {
  final Map<String, List<ExerciseLog>> exerciseLogsGroupedByDate;
  final LoggedUser loggedUser;
  UserCalendarsPageArguments({
    required this.exerciseLogsGroupedByDate,
    required this.loggedUser,
  });
}
