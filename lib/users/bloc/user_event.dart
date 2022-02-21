part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UserFetch extends UserEvent {}

class AddUser extends UserEvent {
  final String name;
  final String email;
  final String phone;

  const AddUser({
    required this.name,
    required this.email,
    required this.phone,
  });
}

class RemoveUser extends UserEvent {
  final String id;

  const RemoveUser({
    required this.id,
  });
}

class EditUser extends UserEvent {
  final UserModel editUser;

  const EditUser({
    required this.editUser,
  });
}
