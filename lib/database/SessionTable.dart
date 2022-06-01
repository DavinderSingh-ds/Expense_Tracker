// ignore_for_file: file_names

class SessionModel {
  int? id;
  String userName;
  String userEmail;
  String userPassword;
  String confirmPassword;
  SessionModel({
    this.id,
    required this.userName,
    required this.userEmail,
    required this.userPassword,
    required this.confirmPassword,
  });
  factory SessionModel.fromdatabaseJson(Map<String, dynamic> data) =>
      SessionModel(
        id: data['id'],
        userName: data['name'],
        userEmail: data['email'],
        userPassword: data['passwrd'],
        confirmPassword: data['cnfpsswrd'],
      );
  Map<String, dynamic> todatabaseJson() => {
        'id': id,
        'name': userName,
        'email': userEmail,
        'passwrd': userPassword,
        'cnfpsswrd': confirmPassword,
      };
}
