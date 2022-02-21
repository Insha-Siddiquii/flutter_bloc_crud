import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_crud/users/models/user_model.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(const UserState()) {
    on<UserFetch>(_callToUserFetch);
    on<AddUser>(_callToAddUser);
    on<RemoveUser>(_callToRemoveUser);
    on<EditUser>(_callToEditUser);
  }

  _callToUserFetch(UserFetch event, Emitter<UserState> emit) async {
    try {
      if (state.users.isEmpty) {
        await Future.delayed(
          const Duration(seconds: 3),
          () => emit(
            state.copyWith(
              status: UserListStatus.complete,
              users: [],
            ),
          ),
        );
      } else {
        emit(state.copyWith(
          status: UserListStatus.complete,
          users: state.users,
        ));
      }
    } catch (_) {
      emit(state.copyWith(
        status: UserListStatus.failed,
      ));
    }
  }

  _callToAddUser(AddUser event, Emitter<UserState> emit) async {
    emit(state.copyWith(status: UserListStatus.inProgress));
    try {
      await Future.delayed(const Duration(seconds: 3), () {
        emit(
          state.copyWith(
            status: UserListStatus.complete,
            users: state.users.toList()
              ..add(
                UserModel(
                  userId: (state.users.length + 1).toString(),
                  userName: event.name,
                  userEmail: event.email,
                  userPhoneNumber: event.phone,
                ),
              ),
          ),
        );
      });
    } catch (_) {
      emit(state.copyWith(
        status: UserListStatus.failed,
      ));
    }
  }

  _callToRemoveUser(RemoveUser event, Emitter<UserState> emit) async {
    // emit(state.copyWith(status: UserListStatus.inProgress));
    try {
      emit(state.copyWith(
        status: UserListStatus.complete,
        users: state.users.toList()
          ..removeWhere((item) => item.userId == event.id),
      ));
    } catch (_) {
      emit(state.copyWith(
        status: UserListStatus.failed,
      ));
    }
  }

  _callToEditUser(EditUser event, Emitter<UserState> emit) async {
    emit(state.copyWith(status: UserListStatus.inProgress));
    try {
      await Future.delayed(const Duration(seconds: 3), () {
        var user = state.users
            .firstWhere((element) => element.userId == event.editUser.userId);
        user.userName = event.editUser.userName;
        user.userEmail = event.editUser.userEmail;
        user.userPhoneNumber = event.editUser.userPhoneNumber;
        emit(state.copyWith(
          status: UserListStatus.complete,
        ));
      });
    } catch (_) {
      emit(state.copyWith(
        status: UserListStatus.failed,
      ));
    }
  }
}
