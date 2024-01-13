import '../model/tile_model.dart';

int points = 0;

bool selected = false;
List<TileModel> pairs = [];
List<TileModel> quest = [];
List<TileModel> visiblePairs = [];

List<TileModel> roundPairs = [];
List<TileModel> remain = [];

int index = 0;
var contain;

// String selectedImageAssetPath = "";
List<String> selectedImageAssetPath = [];

// Pick Img random
List<T> pickRandomItemsAsListWithSubList<T>(List<T> items, int count) =>
    (items.toList()..shuffle()).sublist(0, count);

List<TileModel> getPairs() {
  List<TileModel> pairs = [
    TileModel(imageAssetPath: 'assets/Animal/doi.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/cuu.png', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/cavoi.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/bachtuot.png', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/trau.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/ran.png', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/chuot.png', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/vit.png', isSelected: false),
  ];
  return pairs;
}

List<TileModel> getQuestion() {
  List<TileModel> pairs = [
    // 1
    TileModel(
      imageAssetPath: 'assets/Animal/question.png',
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: 'assets/Animal/question.png',
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: 'assets/Animal/question.png',
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: 'assets/Animal/question.png',
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: 'assets/Animal/question.png',
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: 'assets/Animal/question.png',
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: 'assets/Animal/question.png',
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: 'assets/Animal/question.png',
      isSelected: false,
    ),
  ];

  return pairs;
}
