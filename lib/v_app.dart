import 'constant.dart';
import 'v_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class VApp extends StatelessWidget {
  final Widget? home;
  final String? initialRoute;
  final List<Locale> supportedLocales;
  final ThemeData? theme;
  final ThemeData? darkTheme;
  final ThemeData? highContrastTheme;
  final ThemeData? highContrastDarkTheme;
  final Color? color;
  final bool debugShowCheckedModeBanner;
  final LocaleResolutionCallback? localeResolutionCallback;
  final LocaleListResolutionCallback? localeListResolutionCallback;
  final String? title;
  final GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;
  final GenerateAppTitle? onGenerateTitle;
  final RouteFactory? onGenerateRoute;
  final RouteFactory? onUnknownRoute;
  final Map<String, WidgetBuilder> routes;
  final List<NavigatorObserver>? navigatorObservers;
  final TransitionBuilder? builder;
  final GlobalKey<NavigatorState>? navigatorKey;

  VApp({
    super.key,
    this.home,
    this.initialRoute,
    required List<Locale> supportedLocales,
    this.scaffoldMessengerKey,
    this.navigatorKey,
    this.theme,
    this.routes = const <String, WidgetBuilder>{},
    this.darkTheme,
    this.highContrastTheme,
    this.highContrastDarkTheme,
    this.color,
    this.debugShowCheckedModeBanner = true,
    this.localeResolutionCallback,
    this.localeListResolutionCallback,
    this.title,
    this.onGenerateTitle,
    this.onGenerateRoute,
    this.onUnknownRoute,
    this.navigatorObservers,
    this.builder,
  })  : assert(supportedLocales.isNotEmpty, 'supportedLocales cannot be empty'),
        assert(
            (home != null &&
                    initialRoute == null &&
                    routes.isEmpty) || // Yalnız home istifadə olunur
                (home == null &&
                    initialRoute != null &&
                    routes
                        .isNotEmpty), // initialRoute və routes birlikdə istifadə olunur
            'Either home or initialRoute must be provided, but not both.'),
        supportedLocales = _ensureDefaultLocale(supportedLocales);

  static List<Locale> _ensureDefaultLocale(List<Locale> locales) =>
      {...locales, defaultLocale}.toList();

  @override
  Widget build(BuildContext context) {
    final combinedNotifier = CombinedNotifier(
      VService().getCurrentLocale,
      VService().getCurrentThemeMode,
    );

    return ValueListenableBuilder<Map<String, dynamic>>(
      valueListenable: combinedNotifier,
      builder: (context, combinedValue, child) {
        final locale = combinedValue['locale'] as Locale;
        final themeMode = combinedValue['themeMode'] as ThemeMode;

        return MaterialApp(
          key: ValueKey(locale),
          scaffoldMessengerKey: scaffoldMessengerKey,
          navigatorKey: navigatorKey,
          locale: locale,
          supportedLocales: supportedLocales,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: theme,
          darkTheme: darkTheme,
          highContrastTheme: highContrastTheme,
          highContrastDarkTheme: highContrastDarkTheme,
          themeMode: themeMode,
          color: color,
          debugShowCheckedModeBanner: debugShowCheckedModeBanner,
          localeResolutionCallback: localeResolutionCallback,
          localeListResolutionCallback: localeListResolutionCallback,
          title: title ?? '',
          onGenerateTitle: onGenerateTitle,
          onGenerateRoute: (settings) {
            if (settings.name == Navigator.defaultRouteName) {
              if (home != null) {
                return MaterialPageRoute(builder: (context) => home!);
              }
            }
            if (onGenerateRoute != null) {
              return onGenerateRoute!(settings);
            }
            return null;
          },
          onUnknownRoute: onUnknownRoute,
          navigatorObservers: navigatorObservers ?? [],
          builder: (context, child) {
            return child!;
          },
          initialRoute: initialRoute,
          routes: routes,
        );
      },
    );
  }
}

class CombinedNotifier extends ValueNotifier<Map<String, dynamic>> {
  CombinedNotifier(ValueNotifier<Locale> localeNotifier,
      ValueNotifier<ThemeMode> themeNotifier)
      : super({
          'locale': localeNotifier.value,
          'themeMode': themeNotifier.value,
        }) {
    localeNotifier.addListener(() {
      value = {
        ...value,
        'locale': localeNotifier.value,
      };
      notifyListeners();
    });

    themeNotifier.addListener(() {
      value = {
        ...value,
        'themeMode': themeNotifier.value,
      };
      notifyListeners();
    });
  }
}
