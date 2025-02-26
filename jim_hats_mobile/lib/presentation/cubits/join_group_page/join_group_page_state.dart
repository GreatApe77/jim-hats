part of 'join_group_page_cubit.dart';

enum JoinGroupPageStatus { idle, loading, success, error }

final class JoinGroupPageState {
  final String groupCode;
  final JoinGroupPageStatus status;
  final String errorMessage;
  JoinGroupPageState(
      {required this.groupCode,
      required this.status,
      required this.errorMessage});

  JoinGroupPageState copyWith({
    String? groupCode,
    JoinGroupPageStatus? status,
    String? errorMessage,
  }) {
    return JoinGroupPageState(
      errorMessage: errorMessage ?? this.errorMessage,
      groupCode: groupCode ?? this.groupCode,
      status: status ?? this.status,
    );
  }
}
