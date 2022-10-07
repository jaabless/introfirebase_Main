class MainUser {
  final String uid;

  MainUser({required this.uid});
}

class UserData {
  final String uid;
  final String name;
  final String hospitalNumber;
  final String gender;
  final String date;
  final String email;
  final String phone;
  final String image;

  UserData(
      {required this.uid,
      required this.name,
      required this.hospitalNumber,
      required this.gender,
      required this.date,
      required this.email,
      required this.phone,
      required this.image});
}
