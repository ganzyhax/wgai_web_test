part of 'consultant_bloc.dart';

@immutable
sealed class ConsultantEvent {}

final class ConsultantLoad extends ConsultantEvent {}

final class ConsultantUpdateStatus extends ConsultantEvent {
  final String status;
  final String taskId;
  ConsultantUpdateStatus({required this.taskId, required this.status});
}

final class ConsultantOptionSubmitResponse extends ConsultantEvent {
  final String taskId;
  final List answer;
  ConsultantOptionSubmitResponse({required this.taskId, required this.answer});
}

final class ConsultantTextBoxSubmitResponse extends ConsultantEvent {
  final String taskId;
  final String answer;
  ConsultantTextBoxSubmitResponse({required this.taskId, required this.answer});
}
final class ConsultantCheckTask extends ConsultantEvent{
    final String taskId;
ConsultantCheckTask({required this.taskId});
}
