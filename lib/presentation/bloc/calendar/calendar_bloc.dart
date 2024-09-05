import 'package:credit_card_transactions/data/models/day_data_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  CalendarBloc() : super(const CalendarState()) {
    on<CalendarDateSelected>(_mapCalendarDateSelectedToState);
    on<CalendarTypeChanged>(_mapCalendarTypeChangedToState);
    on<ResetSelectDate>(_mapResetSelectDateToState);
  }

  Future<void> _mapCalendarDateSelectedToState(
    CalendarDateSelected event,
    Emitter<CalendarState> emit,
  ) async {
    emit(
      state.copyWith(
        selectedDate: event.date,
        selectedDateData: event.selectedDateData,
      ),
    );
  }

  Future<void> _mapCalendarTypeChangedToState(
    CalendarTypeChanged event,
    Emitter<CalendarState> emit,
  ) async {
    emit(
      state.copyWith(
        calendarType: event.calendarType,
      ),
    );
  }

  void _mapResetSelectDateToState(
    ResetSelectDate event,
    Emitter<CalendarState> emit,
  ) {
    emit(
      CalendarState(
        selectedDate: null,
        selectedDateData: null,
        calendarType: state.calendarType,
      ),
    );
  }
}
