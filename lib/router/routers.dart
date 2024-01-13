import 'package:brain_train_clone_app/screens/attention/attention_page.dart';
import 'package:brain_train_clone_app/screens/home/home_page.dart';
import 'package:brain_train_clone_app/screens/languages/language_page.dart';
import 'package:brain_train_clone_app/screens/math/math_page.dart';
import 'package:brain_train_clone_app/screens/memory/game2/memory_two.dart';
import 'package:brain_train_clone_app/screens/memory/memory_page.dart';

// list page of languages game
import 'package:brain_train_clone_app/screens/languages/find_words.dart';
import 'package:brain_train_clone_app/screens/languages/next_words.dart';
import 'package:brain_train_clone_app/screens/languages/connect_words.dart';
import 'package:brain_train_clone_app/screens/languages/arrange_words.dart';

// list page of math game
import 'package:brain_train_clone_app/screens/math/game1_screens/game1_screen.dart';
import 'package:brain_train_clone_app/screens/math/game1_screens/g1_congrat_screen.dart';
import 'package:brain_train_clone_app/screens/math/game2_screens/g2_levels_screen.dart';
import 'package:brain_train_clone_app/screens/math/game2_screens/game2_screen.dart';
import 'package:brain_train_clone_app/screens/math/game2_screens/g2_congrat_screen.dart';

import '../screens/memory/game1/memory_one_levels.dart';

class RouteGenerator {
  const RouteGenerator._();

  // common
  static const homePage = '/homepage';

  // language page
  static const languagePage = '/languagePage';
  static const findWords = '/findWords';
  static const nextWords = '/nextWords';
  static const connectWords = '/connectWords';
  static const arrangeWords = '/arrangeWords';

  // attention page
  static const attentionPage = '/attentionPage';

  // memory page
  static const memoryPage = '/memoryPage';
  static const memoryOneLevel = '/memoryOneLevel';
  static const memoryTwo = '/memoryTwo';
  static const memoryThree = '/memoryThree';

  // math page
  static const mathPage = '/mathPage';
  static const smaller = '/smaller';
  static const smallerResult = '/smallerResult';
  static const sumLevels = '/sumLevels';
  static const sum = '/sum';
  static const sumResult = '/sumResult';

  static final routes = {
    homePage: (context) => const HomePage(),
    languagePage: (context) => const LanguagePage(),
    attentionPage: (context) => const AttentionPage(),
    memoryPage: (context) => const MemoryPage(),
    mathPage: (context) => const MathPage(),

    // list game of language
    findWords: (context) => const FindWordsPage(),
    nextWords: (context) => const NextWordsPage(),
    connectWords: (context) => const ConnectWordsPage(),
    arrangeWords: (context) => const ArrangeWordsPage(),

    // list game of math
    smaller: (context) => const Math1Screen(),
    smallerResult: (context) => const Math1CongratScreen(),
    sumLevels: (context) => const Math2LevelsScreen(),
    sum: (context) => const Math2Screen(),
    sumResult: (context) => const Math2CongratScreen(),

    // list game of memory
    memoryOneLevel: (context) => const MemoryOneLevel(),
    memoryTwo: (context) => const MemoryTwo(),
  };
}
