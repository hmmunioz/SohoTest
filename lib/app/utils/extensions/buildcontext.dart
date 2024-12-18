import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sohotest/app/constants/assets.dart';
import 'package:sohotest/app/utils/extensions/extensions.dart';
import 'package:sohotest/app/utils/styles.dart';

extension BuildContextExtensions on BuildContext {
  showLoadingDialog(String message) {
    if (Platform.isAndroid) {
      showDialog(
        barrierDismissible: false,
        context: this,
        builder: (_) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                message,
                style: AppStyles.titleStyle(
                  context: this,
                ),
              ),
              10.pv,
              SizedBox(
                width: .60.sw,
                height: .20.sh,
                child: Image.asset(
                  AssetsUIValues.loading,
                ),
              ),
            ],
          ),
        ),
      );
    }
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: this,
        barrierDismissible: false,
        builder: (_) => CupertinoAlertDialog(
          content: Center(
            child: Column(
              children: [
                Text(message),
                10.pv,
                SizedBox(
                  width: .60.sw,
                  height: .20.sh,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(
                      Theme.of(this).primaryColorDark,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
