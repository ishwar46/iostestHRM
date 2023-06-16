part of 'leave_bloc.dart';

abstract class LeaveEvent extends Equatable {
  const LeaveEvent();
}

class LoadLeaveSummaryDetails extends LeaveEvent {
  @override
  List<Object?> get props => [];
}

class LoadLeaveTypeandPerson extends LeaveEvent {
  @override
  List<Object?> get props => [];
}

class LeaveRequestClick extends LeaveEvent {
  final LeaveApplicationRequest _leaveApplicationRequest;

  const LeaveRequestClick(this._leaveApplicationRequest);
  @override
  List<Object?> get props => [_leaveApplicationRequest];
}
