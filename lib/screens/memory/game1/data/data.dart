import '../model/tile_model.dart';

int points = 0;

List<TileModel> pairs = [];
List<TileModel> visiblePairs = [];
bool selected = false;

// Lưu trữ Images đã chọn
String selectedImageAssetPath = '';
int selectedTileIndex = 0;

// Số vòng chơi của mỗi level
int tries = 0;

// level để hiển thị số mảng
enum dataLevel { one, two, three, four }

// int _left = 0;
int score = 0;

// Dùng để mở khóa level
class isOPenLevel {
  isOpen() {
    int index = 0;
    if (score == 0) {
      index = 0;
    } else if (score == 600) {
      index = 1;
    } else if (score == 1200) {
      index = 2;
    }
    return index;
  }
}

List<TileModel> getPairs_2() {
  List<TileModel> pairs1 = [
    TileModel(
      imageAssetPath: "assets/yellow.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/yellow.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/grey.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/grey.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/grey.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/grey.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/grey.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/grey.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/grey.png",
      isSelected: false,
    ),
  ];
  return pairs1;
}

List<TileModel> getPairs_1() {
  List<TileModel> pairs1 = [
    TileModel(
      imageAssetPath: "assets/yellow.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/grey.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/grey.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/grey.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/grey.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/grey.png",
      isSelected: false,
    ),
  ];
  return pairs1;
}

List<TileModel> getPairs_3() {
  List<TileModel> pairs1 = [
    TileModel(
      imageAssetPath: "assets/yellow.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/yellow.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/yellow.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/grey.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/grey.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/grey.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/grey.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/grey.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/grey.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/grey.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/grey.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/grey.png",
      isSelected: false,
    ),
  ];
  return pairs1;
}

List<TileModel> getQuestion_2() {
  List<TileModel> pairs2 = [
    TileModel(
      imageAssetPath: "assets/quest.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/quest.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/quest.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/quest.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/quest.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/quest.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/quest.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/quest.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/quest.png",
      isSelected: false,
    ),
  ];
  return pairs2;
}

List<TileModel> getQuestion_1() {
  List<TileModel> pairs2 = [
    TileModel(
      imageAssetPath: "assets/quest.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/quest.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/quest.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/quest.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/quest.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/quest.png",
      isSelected: false,
    ),
  ];
  return pairs2;
}

List<TileModel> getQuestion_3() {
  List<TileModel> pairs2 = [
    TileModel(
      imageAssetPath: "assets/quest.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/quest.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/quest.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/quest.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/quest.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/quest.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/quest.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/quest.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/quest.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/quest.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/quest.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/quest.png",
      isSelected: false,
    ),
  ];
  return pairs2;
}
