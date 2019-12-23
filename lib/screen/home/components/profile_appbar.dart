import 'package:aluco/core/utils/pref_utils.dart';
import 'package:aluco/repository/api/API.dart';
import 'package:aluco/widget/al_fallback_user_image.dart';
import 'package:aluco/widget/al_info_user_dialog.dart';
import 'package:flutter/material.dart';
import 'package:gg_flutter_components/dialog/gg_dialog.dart';
import 'package:ok_image/ok_image.dart';

class ProfileAppbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final teacherId = PrefUtils.getTeacherId();
    return GestureDetector(
      onTap: () => GGDialog.show(
        context,
        ALInfoUserDialog(),
      ),
      child: OKImage(
        url: '$AWS_FILE_BUCKET_URL/$teacherId.jpg',
        width: 32,
        height: 32,
        timeout: Duration(seconds: 20),
        fit: BoxFit.contain,
        errorWidget: (e) => const ALFallbackUserImage(
          'assets/images/user.png',
          width: 32,
          height: 32,
        ),
      ),
    );
  }
}
