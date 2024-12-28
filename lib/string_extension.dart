import 'v_service.dart';

extension StringExtension on String {
  String get tr {
    return VService().translate(this);
  }

  String trIfAbsent(String defaultValue) {
    final translation = VService().translate(this);
    return translation.isNotEmpty ? translation : defaultValue;
  }

  String trWithArgs({Map<String, String>? args}) {
    String translation = VService().translate(this);

    if (args != null) {
      args.forEach((key, value) {
        translation = translation.replaceAll('{$key}', value);
      });
    }

    return translation;
  }
}
