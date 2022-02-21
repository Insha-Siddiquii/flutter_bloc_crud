import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class UserModel extends Equatable {
  UserModel({
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.userPhoneNumber,
  });

  final String userId;
  late String userName;
  late String userEmail;
  late String userPhoneNumber;

  @override
  List<Object?> get props => [
        userId,
        userName,
        userEmail,
        userPhoneNumber,
      ];
}
