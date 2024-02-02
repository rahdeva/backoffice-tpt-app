import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'initializer.dart';
import 'routes/page_names.dart';
import 'routes/page_routes.dart';
import 'themes/app_theme.dart';
import 'utills/localization/app_translation.dart';
import 'utills/localization/locale_helper.dart';

void main() async {
  if (kDebugMode) {
    debugPrint = (String? message, {int? wrapWidth}) =>
        debugPrintSynchronously(message, wrapWidth: wrapWidth);
  } else {
    debugPrint = (String? message, {int? wrapWidth}) {};
  }

  WidgetsFlutterBinding.ensureInitialized();
  await Initializer.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        translations: AppTranslation(),
        locale: LocaleHelper().getCurrentLocale(),
        fallbackLocale: LocaleHelper().fallbackLocale,
        initialRoute: PageName.LOADER,
        getPages: PageRoutes.pages,
        theme: AppTheme.buildThemeData(true, context),
        builder: (BuildContext context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
            child: child ?? Container(),
          );
        },
      );
    });
  }
}