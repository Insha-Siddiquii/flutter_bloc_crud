part of 'adduserform_bloc.dart';

class AdduserformState extends Equatable {
  const AdduserformState(
      {this.formStatus = FormzStatus.pure,
      this.username = const Username.pure(),
      this.useremail = const Useremail.pure(),
      this.userphonenumber = const Userphonenumber.pure()});

  final FormzStatus formStatus;
  final Username username;
  final Useremail useremail;
  final Userphonenumber userphonenumber;

  @override
  List<Object> get props => [formStatus, username, useremail, userphonenumber];

  AdduserformState copyWith({
    formStatus,
    username,
    useremail,
    userphonenumber,
  }) {
    return AdduserformState(
      formStatus: formStatus ?? this.formStatus,
      useremail: useremail ?? this.useremail,
      username: username ?? this.username,
      userphonenumber: userphonenumber ?? this.userphonenumber,
    );
  }
}
