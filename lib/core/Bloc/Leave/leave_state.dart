part of 'leave_bloc.dart';

abstract class LeaveState extends Equatable {
  const LeaveState();
}

class LeaveDetailsLoading extends LeaveState {
  @override
  List<Object?> get props => [];
}

class LeaveDetailsLoaded extends LeaveState {
  final List<LeaveSummaryResponse> leaveSummaryList;
  final List<LeaveApplicationDetails> leaveDetailsList;

  const LeaveDetailsLoaded(this.leaveSummaryList, this.leaveDetailsList);
  @override
  List<Object?> get props => [leaveSummaryList, leaveDetailsList];
}

class LeaveDetailsLoadFailed extends LeaveState {
  final String message;

  const LeaveDetailsLoadFailed(this.message);

  @override
  List<Object?> get props => [message];
}

class LeaveRequestLoading extends LeaveState {
  @override
  List<Object?> get props => [];
}

class LeaveRequestSuccessful extends LeaveState {
  final ApplicationRequestResponse requestResponse;

  const LeaveRequestSuccessful(this.requestResponse);
  @override
  List<Object?> get props => [requestResponse];
}

class LeaveRequestFailed extends LeaveState {
  final String message;

  const LeaveRequestFailed(this.message);
  @override
  List<Object?> get props => [message];
}

class LeaveTypesDetailsLoaded extends LeaveState {
  final List<LeaveApplyTypeResponse> leaveApplyTypeList;
  final List<LeaveApplyTypeResponse> leaveApplyPersonList;

  const LeaveTypesDetailsLoaded(
      this.leaveApplyTypeList, this.leaveApplyPersonList);
  @override
  List<Object?> get props => [leaveApplyTypeList, leaveApplyPersonList];
}

class LeaveTypeLoadFailed extends LeaveState {
  @override
  List<Object?> get props => [];
}
