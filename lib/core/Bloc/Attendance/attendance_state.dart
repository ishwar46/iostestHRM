part of 'attendance_bloc.dart';

abstract class AttendanceState extends Equatable {
  const AttendanceState();
}

class AttendanceLoading extends AttendanceState {
  @override
  List<Object?> get props => [];
}

class AttendanceDataLoaded extends AttendanceState {
  final List<PersonalAttendanceDetailsResponse>
      personalAttendanceDetailsResponse;
  final List<TableRow> tableRows;

  const AttendanceDataLoaded(
      this.personalAttendanceDetailsResponse, this.tableRows);
  @override
  List<Object?> get props => [personalAttendanceDetailsResponse, tableRows];
}

class AttendanceDataLoadFailed extends AttendanceState {
  final String message;

  const AttendanceDataLoadFailed(this.message);
  @override
  List<Object?> get props => [message];
}

class ManualAttendanceRequestSuccessful extends AttendanceState {
  @override
  List<Object?> get props => [];
}

class ManualAttendanceRequestFailed extends AttendanceState {
  final String message;

  const ManualAttendanceRequestFailed(this.message);

  @override
  List<Object?> get props => [message];
}
