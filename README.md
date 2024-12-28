# v_app

Material app with localization and theme support.

1. Set app Locale:
   ```dart
    await VService().loadLocale(locale: Locale('az', 'AZ'));
   ```

3. Set app ThemeMode:
   ```dart
   VService().setThemeMode(ThemeMode.system);
   ```

5. Use VApp:
    ```dart
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
    ```
