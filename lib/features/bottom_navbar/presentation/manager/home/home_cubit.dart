import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_steps_tracker/core/data/data_sources/database.dart';
import 'package:flutter_steps_tracker/core/data/error/failures/firebase_auth_failure.dart';
import 'package:flutter_steps_tracker/core/domain/use_cases/use_case.dart';
import 'package:flutter_steps_tracker/features/bottom_navbar/data/models/exchange_history_model.dart';
import 'package:flutter_steps_tracker/features/bottom_navbar/domain/use_cases/get_user_data_use_case.dart';
import 'package:flutter_steps_tracker/features/bottom_navbar/domain/use_cases/set_exchange_history_use_case.dart';
import 'package:flutter_steps_tracker/features/bottom_navbar/domain/use_cases/set_steps_and_points_use_case.dart';
import 'package:flutter_steps_tracker/features/bottom_navbar/presentation/manager/home/home_state.dart';
import 'package:flutter_steps_tracker/utilities/constants/enums.dart';
import 'package:injectable/injectable.dart';
import 'package:pedometer/pedometer.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final SetExchangeHistoryUseCase _setExchangeHistoryUseCase;
  final SetStepsAndPointsUseCase _setStepsAndPointsUseCase;
  final GetUserDataUseCase _getUserDataUseCase;
  late Stream<StepCount> _stepCountStream;
  String _steps = '?';

  HomeCubit(
    this._setExchangeHistoryUseCase,
    this._setStepsAndPointsUseCase,
    this._getUserDataUseCase,
  ) : super(
          const HomeState.initial(),
        );

  Future<void> getUserData() async {
    emit(const HomeState.stepsAndPointsLoading());
    final result = await _getUserDataUseCase(NoParams());
    emit(
      result.fold(
        (failure) {
          if (failure is FirebaseAuthFailure) {
            failure.maybeWhen(
                orElse: () => const HomeState.stepsError(
                    message: 'Something went wrong!'),
                operationNotAllowed: (message) =>
                    HomeState.stepsError(message: message));
          }
          return const HomeState.stepsError(message: 'Something went wrong!');
        },
        (userData) => HomeState.stepsAndPointsLoaded(
          steps: userData.totalSteps,
          healthPoints: userData.healthPoints,
        ),
      ),
    );
  }

  void initPlatformState() {
    emit(const HomeState.loading());
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);
  }

  void onStepCount(StepCount event) async {
    debugPrint(event.toString());
    var oldSteps = int.tryParse(_steps) ?? 0;
    _steps = event.steps.toString();
    emit(HomeState.loaded(steps: _steps));
    await _setStepsAndPointsUseCase(event.steps);
    await onFeedbackState(oldSteps, event.steps);
  }

  Future<void> onFeedbackState(int oldSteps, int newSteps) async {
    if ((oldSteps % 100) > (newSteps % 100)) {
      emit(HomeState.feedbackGain(steps: _steps));
      await _setExchangeHistoryUseCase(
        ExchangeHistoryModel(
          id: documentIdFromLocalGenerator(),
          title: ExchangeHistoryTitle.exchange.title,
          date: DateTime.now().toIso8601String(),
          points: 5,
        ),
      );
    }
  }

  void onStepCountError(error) {
    debugPrint('onStepCountError: $error');
    _steps = 'Step Count not available';
    emit(HomeState.error(message: _steps));
  }
}
