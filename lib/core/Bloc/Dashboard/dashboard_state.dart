part of 'dashboard_bloc.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();
}

class DashboardLoading extends DashboardState {
  @override
  List<Object?> get props => [];
}

class DashboardLoadedState extends DashboardState {
  final String name;
  final String workShiftName;
  final List<LeaveSummaryResponse>? leaveSummaryResponse;
  final String punchTime;
  final String remarks;
  final List<PersonalAttendanceDetailsResponse>
      personalAttendanceDetailsResponse;

  const DashboardLoadedState(
      this.name,
      this.workShiftName,
      this.leaveSummaryResponse,
      this.punchTime,
      this.remarks,
      this.personalAttendanceDetailsResponse);
  @override
  List<Object?> get props => [
        name,
        workShiftName,
        leaveSummaryResponse,
        punchTime,
        remarks,
        personalAttendanceDetailsResponse
      ];
}

class DashboardDataLoadFailed extends DashboardState {
  final String message;

  const DashboardDataLoadFailed(this.message);
  @override
  List<Object?> get props => [];
}
