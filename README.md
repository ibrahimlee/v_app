# v_app

Material app with localization and theme supports

1. Set app Locale:
    await VService().loadLocale(locale: Locale('az', 'AZ'));

2. Set app ThemeMode:
   VService().setThemeMode(ThemeMode.system);

3. Use VApp:
   VApp(
      navigatorKey: CustomNavigator().navigatorKey,
      theme: AppThemes.light,
      darkTheme: AppThemes.dark,
      supportedLocales: AppLocales.supportedLocales,
      title: 'Araz Market',
      initialRoute: '/app',
      routes: {
        '/app': (context) => AppModule.create(), // Splash screen
        '/auth': (context) => AuthModule.create(), // Login screen
        '/register': (context) => RegisterModule.create(), // Register screen
        '/home': (context) => HomeModule.create(), // Home screen
      },
    )
