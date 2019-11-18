import 'package:aluco/core/utils/jwt_utils.dart';

final headers = <String, dynamic>{
  'Authorization': JWTUtils.getToken()
};