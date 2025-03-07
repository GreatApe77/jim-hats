import 'package:jim_hats_mobile/data/exercise_logs/models/exercise_log.dart';

class UserCalendarsPageArguments {
  final Map<String, List<ExerciseLog>> exerciseLogsGroupedByDate;

  UserCalendarsPageArguments({required this.exerciseLogsGroupedByDate});
}
