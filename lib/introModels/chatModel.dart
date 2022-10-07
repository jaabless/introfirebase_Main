class ChatModel {
  final String avatarUrl;
  final String name;
  final String datetime;
  final String message;

  ChatModel(
      {required this.avatarUrl,
      required this.name,
      required this.datetime,
      required this.message});

  static final List<ChatModel> dummyData = [
    ChatModel(
      avatarUrl: 'assets/images/splash.png',
      name: "Dr. Kriss Benwat",
      datetime: "10:18",
      message: "How are you doing?",
    ),
    ChatModel(
      avatarUrl: "",
      name: "Tracy",
      datetime: "19:42",
      message:
          "Before the system design which is through our requirement and analysis, we met with the system ",
    ),
    ChatModel(
      avatarUrl: "",
      name: "Kelvin",
      datetime: "30:00",
      message: "Great work",
    ),
    ChatModel(
      avatarUrl: "",
      name: "Kwame",
      datetime: "05:06",
      message: "I love you too",
    ),
    ChatModel(
      avatarUrl: "",
      name: "Ernestine",
      datetime: "05:01",
      message: "I love you. ",
    )
  ];
}
