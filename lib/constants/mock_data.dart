class MockData {
  static List<Map<String, dynamic>> cards = [
    {
      "id": 1,
      "image": 'images/language-background.jpg',
      "icon": 'images/language-icon.jpg',
      "title": 'Trò Chơi Ngôn Ngữ',
      "description": '4 Trò Chơi',
      "pathName": '/languagePage'
    },
    {
      "id": 2,
      "image": 'images/attention-background.png',
      "icon": 'images/attention-icon.png',
      "title": 'Trò Chơi Tập Trung',
      "description": '4 Trò Chơi',
      "pathName": '/attentionPage'
    },
    {
      "id": 3,
      "image": 'images/memory-background.png',
      "icon": 'images/memory.png',
      "title": 'Trò Chơi Ghi Nhớ',
      "description": '4 Trò Chơi',
      "pathName": '/memoryPage'
    },
    {
      "id": 4,
      "image": 'images/math-background.png',
      "icon": 'images/math-icon.jpg',
      "title": 'Trò Chơi Tính Toán',
      "description": '4 Trò Chơi',
      "pathName": '/mathPage'
    },
  ];

  static List<Map<String, dynamic>> languageGames = [
    {
      "id": 1,
      "image": 'images/game_languages1.png',
      "icon": 'images/game_languages1.png',
      "title": 'Tìm từ bắt đầu với',
      "description": '',
      "paddingLeft": 5,
      "paddingTop": 45,
      "padding": 0,
      "color": 0xff2D2D2D,
      "pathName": "/gameLetter"
    },
    {
      "id": 2,
      "image": 'images/game_languages2.png',
      "icon": 'images/game_languages2.png',
      "title": 'Tìm từ tiếp theo',
      "description": '',
      "paddingLeft": 7,
      "paddingTop": 45,
      "padding": 0,
      "color": 0xff444444,
      "pathName": "/gameWord"
    },
    {
      "id": 3,
      "image": 'images/game_languages3.png',
      "icon": 'images/game_languages3.png',
      "title": 'Nối Từ',
      "description": '',
      "paddingLeft": 7,
      "paddingTop": 45,
      "padding": 0,
      "color": 0xff444444,
      "pathName": "/gameConj"
    },
    {
      "id": 4,
      "image": 'images/game_languages4.png',
      "icon": 'images/game_languages4.png',
      "title": 'Sắp xếp từ',
      "description": '',
      "paddingLeft": 7,
      "paddingTop": 45,
      "padding": 0,
      "color": 0xff444444,
      "pathName": "/gameSort"
    },
  ];
}
