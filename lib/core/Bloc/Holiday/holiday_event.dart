part of 'holiday_bloc.dart';

abstract class HolidayEvent extends Equatable {
  const HolidayEvent();
}

class LoadHolidayDetails extends HolidayEvent {
  @override
  List<Object?> get props => [];
}
