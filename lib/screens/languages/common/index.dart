import 'package:brain_train_clone_app/service/language_game_api.dart'
    show checkValidWord, checkMatchWord;
import 'package:brain_train_clone_app/components/toast.dart';

Future<bool> handleCheck(
    {required String userAnswer,
    required String userInput,
    required int numberWord,
    required String checkingWord,
    required List<String> ans,
    required List<String> listSuccess}) async {
  bool isMatchWord = await checkMatchWord(userAnswer, ans);
  if (!isMatchWord) {
    showToastErrorMatch();
  }

  bool isValidWord = await checkValidWord(checkingWord);
  if (!isValidWord) {
    showToastError();
  }

  if (isMatchWord && isValidWord) {
    listSuccess.add(userAnswer);
    ans.add(userAnswer);
    showToastCorrect("+ 200");
  }

  bool isSuccess = isMatchWord && isValidWord;

  return isSuccess;
}
