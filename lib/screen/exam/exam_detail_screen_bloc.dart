import 'package:rxdart/rxdart.dart';

enum ScreenState { pristine, dirty }

class ExamDetailScreenBloc {
  final _stateController =
      BehaviorSubject<ScreenState>.seeded(ScreenState.pristine);
  Stream<ScreenState> get stateStream => _stateController.stream;

  void setIsDirty() {
    _stateController.add(ScreenState.dirty);
  }

  void setIsPristine() {
    _stateController.add(ScreenState.pristine);
  }

  void dispose() {
    _stateController.close();
  }
}
