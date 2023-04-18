import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'time_machine_cubit_state.dart';

const int _secondsLoop = 1;

class TimeMachineCubit extends Cubit<TimeMachineCubitState> {
  Timer? timer;
  TimeMachineCubit(DateTime dateTime) : super(TimeMachineCubitState.init(dateTime)) {
    _runLoop();
  }

  // public method to stop and start the Date/Time Controller
  void cancelDateTime() {
    if ((timer?.isActive ?? false)) {
      timer?.cancel();
      emit(state.copyWith(updateDateStatus: DateStatus.timeStop, updateCurrentDateTime: DateTime.now()));
    }
  }

  void restartDateTimeCubit() {
    cancelDateTime();
    emit(state.copyWith(updateDateStatus: DateStatus.restart, updateCurrentDateTime: DateTime.now()));
    _runLoop();
  }


  void _runLoop() {
    emit(state.copyWith(updateDateStatus: DateStatus.timeLoopStarted, updateCurrentDateTime: DateTime.now()));
    if (!(timer?.isActive ?? false)) {
      timer = Timer.periodic(const Duration(seconds: _secondsLoop), (timer) => _timeLoop());
    }
  }

  void _timeLoop() {
    try {
      final DateTime upDate = DateTime.now();
      // post day update
      if (upDate.day != state.currentDateTime.day) {
        emit(state.copyWith(updateDateStatus: DateStatus.dayUpdate, updateCurrentDateTime: upDate));
      }
      // post hour update
      if (upDate.hour != state.currentDateTime.hour) {
        emit(state.copyWith(updateDateStatus: DateStatus.hourUpdate, updateCurrentDateTime: upDate));
      }

      if(upDate.minute == 30) {
        emit(state.copyWith(updateDateStatus: DateStatus.halfHourUpdate, updateCurrentDateTime: upDate));
      }

      if (upDate.minute != state.currentDateTime.minute) {
        emit(state.copyWith(updateDateStatus: DateStatus.minuteUpdate, updateCurrentDateTime: upDate));
      }

      if (upDate.second != state.currentDateTime.second) {
        emit(state.copyWith(updateDateStatus: DateStatus.secondUpdate, updateCurrentDateTime: upDate));
      }
    } catch (e, stacktrace) {
      restartDateTimeCubit();
      debugPrint('DateTimeCubit _timeLoop error ${e.toString()} state ${stacktrace.toString()}');
    }
  }
}
