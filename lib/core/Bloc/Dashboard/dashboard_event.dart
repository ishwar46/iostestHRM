part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();
}

class LoadDashboardData extends DashboardEvent {
  @override
  List<Object> get props => [];
}
