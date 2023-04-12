part of 'time_machine_cubit.dart';

enum DateStatus { init, timeLoopStarted, secondUpdate, minuteUpdate, hourUpdate, halfHourUpdate, dayUpdate, restart,
  timeStop }

class TimeMachineCubitState {
  final DateStatus dateStatus;
  final DateTime currentDateTime;

  const TimeMachineCubitState({required this.dateStatus, required this.currentDateTime});

  const TimeMachineCubitState.init(DateTime initDateTime)
      : dateStatus = DateStatus.init,
        currentDateTime = initDateTime;

  TimeMachineCubitState copyWith({required DateStatus updateDateStatus, required DateTime updateCurrentDateTime}) =>
      TimeMachineCubitState(dateStatus: updateDateStatus, currentDateTime: updateCurrentDateTime);
}

// LOOP MODEL & ENUM (not in use)
enum LoopType { once, forever, boolFunctionCheck }

class LoopFunction {
  final LoopType type;
  final VoidCallback loopFunction;

  // add frequency duration to check time and compare w/ against time loop //
  final Duration frequency;
  final DateTime checkTime;
  final bool Function()? checkCallback;

  const LoopFunction(
      {required this.type,
      required this.checkTime,
      required this.frequency,
      required this.loopFunction,
      this.checkCallback});

  const LoopFunction.init(
      {required LoopType initType,
      required VoidCallback initLoopFunction,
      // check frequency duration to against time loop //
      required Duration initFrequency,
      required DateTime initCheckTime,
      required bool Function()? initCheckCallback})
      : type = initType,
        loopFunction = initLoopFunction,
        frequency = initFrequency,
        checkTime = initCheckTime,
        checkCallback = initCheckCallback;

  LoopFunction copyWith(DateTime updateCheckTime) => LoopFunction(
      type: type, loopFunction: loopFunction, frequency: frequency, checkCallback: checkCallback, checkTime: checkTime);
}
