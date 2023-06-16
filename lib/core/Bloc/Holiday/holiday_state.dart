part of 'holiday_bloc.dart';

abstract class HolidayState extends Equatable {
  const HolidayState();
}

class HolidayLoading extends HolidayState {
  @override
  List<Object> get props => [];
}

class HolidayLoaded extends HolidayState {
  final List<HolidayDetailsResponse> holidayDetailsResponse;
  final Map<DateTime, List<HolidayDetailsResponse>> kEvents;
  const HolidayLoaded(this.holidayDetailsResponse, this.kEvents);

  @override
  List<Object?> get props => [holidayDetailsResponse, kEvents];
}

class HolidayLoadFailed extends HolidayState {
  @override
  List<Object?> get props => [];
}
