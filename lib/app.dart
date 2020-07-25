import 'package:change4charity/locator.dart';
import 'package:change4charity/services/navigation_service.dart';
import 'package:change4charity/ui/router.dart';
import 'package:change4charity/ui/shared/app_colors.dart';
import 'package:change4charity/ui/views/startup_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:change4charity/ui/shared/app_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatelessWidget {
  final _startUpModel = StartUpView();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        // ... app-specific localization delegate[s] here
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'), // English, no country code
        const Locale('de', 'DE'), // Hebrew, no country code
      ],
      debugShowCheckedModeBanner: false,
      title: 'Change4Charity',
      builder: (context, child) => Navigator(
        //key: locator<DialogService>().dialogNavigationKey,
        onGenerateRoute: (settings) =>
            MaterialPageRoute(builder: (context) => child),
      ),
      navigatorKey: locator<NavigationService>().navigationKey,
      theme: ThemeData(
        primaryColor: primaryColor,
        textTheme: Theme.of(context).textTheme.apply(
              fontFamily: AppTheme.sf,
            ),
        appBarTheme: AppBarTheme(color: Color.fromARGB(255, 255, 0, 0)),
      ),
      home: _startUpModel,
      onGenerateRoute: generateRoute,
    );
  }
}
