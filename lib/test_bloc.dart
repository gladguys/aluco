import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

class TestBloc extends BlocBase {
  final loadingController = BehaviorSubject<bool>.seeded(false);
}