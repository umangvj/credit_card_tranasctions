part of 'calendar_bloc.dart';

enum CalendarType { box, number, git }

class CalendarState extends Equatable {
  const CalendarState({
    this.selectedDate,
    this.selectedDateData,
    this.calendarType = CalendarType.box,
  });

  final DateTime? selectedDate;
  final DayData? selectedDateData;
  final CalendarType calendarType;

  @override
  List<Object?> get props => [selectedDate, selectedDateData, calendarType];

  CalendarState copyWith({
    DateTime? selectedDate,
    DayData? selectedDateData,
    CalendarType? calendarType,
  }) {
    return CalendarState(
      selectedDate: selectedDate ?? this.selectedDate,
      selectedDateData: selectedDateData ?? this.selectedDateData,
      calendarType: calendarType ?? this.calendarType,
    );
  }
}
