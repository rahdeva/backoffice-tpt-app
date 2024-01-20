import 'package:get/get.dart';
import 'langs/english.dart';
import 'langs/indonesian.dart';

class AppTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {'en': en, 'id': id};
}
