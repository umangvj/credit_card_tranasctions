part of 'calendar_bloc.dart';

sealed class CalendarEvent extends Equatable {
  const CalendarEvent();
}

class CalendarDateSelected extends CalendarEvent {
  const CalendarDateSelected({
    required this.date,
    required this.selectedDateData,
  });

  final DateTime date;
  final DayData? selectedDateData;

  @override
  List<Object?> get props => [date, selectedDateData];
}

class CalendarTypeChanged extends CalendarEvent {
  const CalendarTypeChanged({
    required this.calendarType,
  });

  final CalendarType calendarType;

  @override
  List<Object?> get props => [calendarType];
}

class ResetSelectDate extends CalendarEvent {
  const ResetSelectDate();

  @override
  List<Object?> get props => [];
}
