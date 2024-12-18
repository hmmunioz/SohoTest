import 'package:sohotest/app/common_widgets/flag_language.dart';
import 'package:sohotest/app/utils/cubits/theme_cubit.dart';
import 'package:sohotest/app/utils/size_config.dart';
import 'package:sohotest/app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'btn_back_widget.dart';

class AppBarSoho extends StatelessWidget {
  const AppBarSoho({
    super.key,
    required this.isBack,
  });

  final bool isBack;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AppBar(
      backgroundColor: Theme.of(context).primaryColorLight,
      toolbarHeight: size.height * .06,
      elevation: 10,
      leading: isBack ? const ButtonBack() : const FlagLanguage(),
      title: Text(
        translate('soho'),
        style: AppStyles.titleStyle(context: context, color: Theme.of(context).primaryColor),
      ),
      centerTitle: true,
      actions: [
        if (!isBack)
          BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, themeState) {
              return GestureDetector(
                onTap: () {
                  context.read<ThemeCubit>().toggleTheme();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: SizeConfig.sm),
                  child: Icon(
                    themeState != ThemeState.light ? Icons.dark_mode : Icons.light_mode,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}
