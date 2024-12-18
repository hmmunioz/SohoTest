import 'package:sohotest/app/constants/assets.dart';
import 'package:sohotest/app/enums/language_enum.dart';
import 'package:sohotest/app/utils/localstorage.dart';
import 'package:sohotest/app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

class FlagLanguage extends StatefulWidget {
  const FlagLanguage({
    super.key,
    this.showButton = true,
  });
  final bool showButton;
  @override
  FLagLanguageState createState() => FLagLanguageState();
}

class FLagLanguageState extends State<FlagLanguage> {
  String? currentLocale = '';
  late SharedPreferences prefs;
  final LocalStorageService _localStorageService = GetIt.I<LocalStorageService>();
  @override
  void initState() {
    currentLocale = _localStorageService.getLanguageStorage;
    super.initState();
  }

  _onChange(LanguageEnum languageEnum) async {
    _localStorageService.setLanguageStorage = languageEnum.name;
    changeLocale(context, languageEnum.name);
    currentLocale = _localStorageService.getLanguageStorage;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _onChange(currentLocale == LanguageEnum.es.name || currentLocale == '' || currentLocale == null
            ? LanguageEnum.en
            : LanguageEnum.es);
      },
      child: Padding(
        padding: EdgeInsets.only(left: SizeConfig.xxs),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              width: .028.sw,
              height: .028.sw,
              currentLocale == LanguageEnum.es.name || currentLocale == '' || currentLocale == null
                  ? AssetsUIValues.languageEs
                  : AssetsUIValues.languageEn,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              currentLocale == LanguageEnum.es.name ? "esp" : "en",
              style: TextStyle(fontSize: SizeConfig.mdlg, color: Theme.of(context).primaryColor),
            )
          ],
        ),
      ),
    );
  }
}
