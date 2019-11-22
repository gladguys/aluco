import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

enum LoadingState { loading, notLoading }

class LoadingBloc extends BlocBase {
  final _loadingStateController =
      BehaviorSubject<LoadingState>.seeded(LoadingState.notLoading);
  Observable<LoadingState> get loadingState => _loadingStateController.stream;

  void startLoading() {
    _loadingStateController.add(LoadingState.loading);
  }

  void stopLoading() {
    _loadingStateController.add(LoadingState.notLoading);
  }
}
