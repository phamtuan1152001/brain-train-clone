import '../model/tile_model.dart';

bool selected = false;
// List of source
List<TileModel> pairs = [];
// List chứa 3 Img đầu tiên
List<TileModel> getImg = [];
// List còn lại sau khi lấy 3 Img
List<TileModel> remain = [];

List selectedImageAssetPath = [];
// String selectedImageAssetPath = '';
List<int> selectedTileIndex = [];

int score = 0;

// Pick Img random
List<T> pickRandomItemsAsListWithSubList<T>(List<T> items, int count) =>
    (items.toList()..shuffle()).sublist(0, count);

// Use check item exists
var checkString;

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
    //////////////////
    TileModel(imageAssetPath: 'assets/Animal/chuot.png', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/vit.png', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/doi.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/cuu.png', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/cavoi.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/bachtuot.png', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/trau.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/ran.png', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/chuot.png', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/vit.png', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/chuot.png', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/vit.png', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/doi.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/cuu.png', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/cavoi.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/bachtuot.png', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/trau.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/ran.png', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/chuot.png', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/vit.png', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/chuot.png', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/vit.png', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/doi.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/cuu.png', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/cavoi.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/bachtuot.png', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/trau.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/ran.png', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/chuot.png', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/vit.png', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/chuot.png', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/vit.png', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/doi.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/cuu.png', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/cavoi.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/bachtuot.png', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/trau.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/ran.png', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/chuot.png', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/vit.png', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/chuot.png', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/vit.png', isSelected: false),
  ];
  return pairs;
}
