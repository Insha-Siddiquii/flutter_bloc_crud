part of 'user_bloc.dart';

enum UserListStatus { inProgress, complete, failed }

class UserState extends Equatable {
  const UserState({
    this.status = UserListStatus.inProgress,
    this.users = const [],
  });

  final UserListStatus status;
  final List<UserModel> users;

  @override
  List<Object> get props => [
        status,
        users,
      ];

  UserState copyWith({
    required UserListStatus status,
    List<UserModel>? users,
  }) {
    return UserState(
      status: status,
      users: users ?? this.users,
    );
  }
}
