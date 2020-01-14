import 'package:aluco/core/bloc/linear_loading_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';

class LoadingInterceptor implements InterceptorsWrapper {
  @override
  Future onError(DioError err) async {
    BlocProvider.getBloc<LinearLoadingBloc>().finishLoading();
  }

  @override
  Future onRequest(RequestOptions options) async {
    print('onRequest');
    BlocProvider.getBloc<LinearLoadingBloc>().startLoading();
  }

  @override
  Future onResponse(Response response) async {
    print('onResponse');
    BlocProvider.getBloc<LinearLoadingBloc>().finishLoading();
  }
}
