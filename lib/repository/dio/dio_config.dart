import 'package:aluco/utils/jwt_utils.dart';

final headers = <String, dynamic>{
  'Authorization': JWTUtils.getToken()
};