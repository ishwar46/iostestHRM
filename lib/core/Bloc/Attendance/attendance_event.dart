part of 'attendance_bloc.dart';

abstract class AttendanceEvent extends Equatable {
  const AttendanceEvent();
}

class LoadAttendanceDetail extends AttendanceEvent {
  final String fromDate;
  final String toDate;

  const LoadAttendanceDetail(this.fromDate, this.toDate);
  @override
  List<Object?> get props => [fromDate, toDate];
}

class ManualAttendanceClicked extends AttendanceEvent {
  final ManualAttendanceRequest manualAttendanceRequest;

  const ManualAttendanceClicked(this.manualAttendanceRequest);
  @override
  List<Object?> get props => [manualAttendanceRequest];
}
