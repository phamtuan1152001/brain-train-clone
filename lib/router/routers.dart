import 'package:brain_train_clone_app/screens/attention/attention_page.dart';
import 'package:brain_train_clone_app/screens/home/home_page.dart';
import 'package:brain_train_clone_app/screens/languages/language_page.dart';
import 'package:brain_train_clone_app/screens/math/math_page.dart';
import 'package:brain_train_clone_app/screens/memory/memory_page.dart';

class RouteGenerator {
  const RouteGenerator._();

  // common
  static const homePage = '/homepage';

  // language page
  static const languagePage = '/languagePage';

  // attention page
  static const attentionPage = '/attentionPage';

  // memory page
  static const memoryPage = '/memoryPage';

  // math page
  static const mathPage = '/mathPage';

  static final routes = {
    homePage: (context) => const HomePage(),
    languagePage: (context) => const LanguagePage(),
    attentionPage: (context) => const AttentionPage(),
    memoryPage: (context) => const MemoryPage(),
    mathPage: (context) => const MathPage()
  };
}
