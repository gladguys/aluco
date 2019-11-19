import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

class LinearLoadingBloc extends BlocBase {
  final _loadingController = BehaviorSubject<bool>.seeded(false);
  Stream<bool> get loadingStream =>  _loadingController.stream;

  void startLoading() {
    _loadingController.add(true);
  }

  void finishLoading() {
    _loadingController.add(false);
  }
}