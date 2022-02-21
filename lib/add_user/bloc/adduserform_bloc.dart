import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_crud/users/models/models.dart';
import 'package:formz/formz.dart';

part 'adduserform_event.dart';
part 'adduserform_state.dart';

class AdduserformBloc extends Bloc<AdduserformEvent, AdduserformState> {
  AdduserformBloc() : super(const AdduserformState()) {
    on<UsernameChanged>(_callToUserNameChanged);
    on<UseremailChanged>(_callToUserEmailChanged);
    on<UserphonenumberChanged>(_callToUserPhoneNumberChanged);
  }

  _callToUserNameChanged(
      UsernameChanged event, Emitter<AdduserformState> emit) {
    {
      final username = Username.dirty(event.username);
      return emit(state.copyWith(
        username: username,
        formStatus:
            Formz.validate([state.userphonenumber, state.useremail, username]),
      ));
    }
  }

  _callToUserEmailChanged(
      UseremailChanged event, Emitter<AdduserformState> emit) {
    final useremail = Useremail.dirty(event.useremail);
    return emit(state.copyWith(
      useremail: useremail,
      formStatus:
          Formz.validate([state.userphonenumber, state.username, useremail]),
    ));
  }

  _callToUserPhoneNumberChanged(
      UserphonenumberChanged event, Emitter<AdduserformState> emit) {
    final userphonenumber = Userphonenumber.dirty(event.userphonenumber);
    return emit(state.copyWith(
      userphonenumber: userphonenumber,
      formStatus:
          Formz.validate([state.username, state.useremail, userphonenumber]),
    ));
  }
}
