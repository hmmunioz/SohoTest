import 'package:sohotest/app/data_source/task/task_data_source.dart';
import 'package:sohotest/app/repository/task_repository.dart';
import 'package:sohotest/app/ui/navigation/navigation_cubit.dart';
import 'package:sohotest/app/enums/language_enum.dart';
import 'package:sohotest/app/utils/cubits/theme_cubit.dart';
import 'package:sohotest/app/utils/database.dart';
import 'package:sohotest/app/utils/localstorage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sohotest/app/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:sohotest/app/routes/go_route.dart';
import 'package:sohotest/app/utils/di.dart';
import 'package:sohotest/app/utils/styles.dart';
import 'package:sohotest/locale/locale.dart';
import 'package:device_preview/device_preview.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var delegate = await LocalizationDelegate.create(
    fallbackLocale: 'es_ES',
    supportedLocales: ['es_ES', 'en_US'],
  );
  await setupLocator();
  runAppMethod(delegate);
}

void runAppMethod(LocalizationDelegate delegate) async {
  final database = await DatabaseHelper.instance.database;

  final taskDataSource = TaskDataSource(database);
  final taskRepository = TaskRepository(taskDataSource);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<InitBloc>(
          create: (context) => InitBloc(),
        ),
        BlocProvider<NavigationCubit>(
          create: (context) => NavigationCubit(const NavigationState()),
        ),
        BlocProvider<TaskBloc>(
          create: (context) => TaskBloc(taskRepository),
        ),
        BlocProvider<ThemeCubit>(
          create: (context) => ThemeCubit(),
        ),
      ],
      child: DevicePreview(
        enabled: false,
        builder: (context) => LocalizedApp(
          delegate,
          const SohotestApp(),
        ),
      ),
    ),
  );
}

class SohotestApp extends StatefulWidget {
  const SohotestApp({super.key});

  @override
  State<SohotestApp> createState() => _SohotestAppState();
}

class _SohotestAppState extends State<SohotestApp> with WidgetsBindingObserver {
  final LocalStorageService _localStorageService = GetIt.I<LocalStorageService>();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _localStorageService.setLanguageStorage = LanguageEnum.es.name;
    changeLocale(context, LanguageEnum.es.name);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;
    final router = MyAppRouter(context);
    return LocalizationProvider(
      state: LocalizationProvider.of(context).state,
      child: Material(
        child: BlocBuilder<ThemeCubit, ThemeState>(builder: (context, themeState) {
          return MaterialApp.router(
            title: translate('sohotest'),
            routerConfig: router.createdRouter(),
            builder: DevicePreview.appBuilder,
            locale: DevicePreview.locale(context),
            localizationsDelegates: const [
              AppLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: localizationDelegate.supportedLocales,
            theme: themeState == ThemeState.light ? AppStyles.appThemeLight : AppStyles.appThemeDark,
            debugShowCheckedModeBanner: false,
          );
        }),
      ),
    );
  }
}
