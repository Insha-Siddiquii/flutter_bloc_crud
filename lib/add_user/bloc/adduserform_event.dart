part of 'adduserform_bloc.dart';

abstract class AdduserformEvent extends Equatable {
  const AdduserformEvent();

  @override
  List<Object> get props => [];
}

class UsernameChanged extends AdduserformEvent {
  final String username;
  const UsernameChanged({required this.username});
}

class UseremailChanged extends AdduserformEvent {
  final String useremail;
  const UseremailChanged({required this.useremail});
}

class UserphonenumberChanged extends AdduserformEvent {
  final String userphonenumber;
  const UserphonenumberChanged({required this.userphonenumber});
}

class UserFormSubmit extends AdduserformEvent {
  const UserFormSubmit();
}
