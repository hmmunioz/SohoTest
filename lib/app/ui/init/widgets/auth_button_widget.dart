import 'package:sohotest/app/utils/cubits/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sohotest/app/utils/size_config.dart';

class SohoButtonWidget extends StatelessWidget {
  const SohoButtonWidget({
    super.key,
    this.functionToExecute,
    required this.text,
    required this.icon,
  });
  final VoidCallback? functionToExecute;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(builder: (context, themeState) {
      return ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          width: 0.8.sw,
          height: .07.sh,
          child: ElevatedButton(
            onPressed: functionToExecute,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColorLight),
              foregroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColorLight),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(SizeConfig.sm),
                  side: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 1.0,
                  ),
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: Theme.of(context).primaryColorDark,
                ),
                SizedBox(
                  width: 0.04.sw,
                ),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontFamily: 'YuGiOhMatrix',
                    color: Theme.of(context).primaryColorDark,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
