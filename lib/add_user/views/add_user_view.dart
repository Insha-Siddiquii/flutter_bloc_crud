import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_crud/add_user/bloc/adduserform_bloc.dart';
import 'package:flutter_bloc_crud/users/users.dart';
import 'package:formz/formz.dart';

class AddUserView extends StatelessWidget {
  const AddUserView({
    Key? key,
    required this.userBloc,
  }) : super(key: key);

  final UserBloc userBloc;
  static const routeName = '/addUser';

  @override
  Widget build(BuildContext context) {
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _phoneController = TextEditingController();
    final formGlobalKey = GlobalKey<FormState>();
    Map<String, dynamic>? _routeParam;
    var routeData = ModalRoute.of(context)!.settings.arguments;
    if (routeData != null) {
      _routeParam = routeData as Map<String, dynamic>;
      UserModel userMdoel = routeData['user'] as UserModel;
      _nameController.text = userMdoel.userName;
      _emailController.text = userMdoel.userEmail;
      _phoneController.text = userMdoel.userPhoneNumber;
    }
    AdduserformBloc addUserBloc = AdduserformBloc();
    return Scaffold(
      appBar: AppBar(
        title: _routeParam != null && _routeParam['isEdit']
            ? const Text('Edit User')
            : const Text('Add User'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: BlocProvider(
            create: (context) => addUserBloc,
            child: FormWidget(
                formGlobalKey: formGlobalKey,
                nameController: _nameController,
                emailController: _emailController,
                phoneController: _phoneController,
                routeParam: _routeParam,
                userBloc: userBloc,
                addUserBloc: addUserBloc),
          ),
        ),
      ),
    );
  }
}

class FormWidget extends StatelessWidget {
  const FormWidget({
    Key? key,
    required this.formGlobalKey,
    required TextEditingController nameController,
    required TextEditingController emailController,
    required TextEditingController phoneController,
    required Map<String, dynamic>? routeParam,
    required this.userBloc,
    required this.addUserBloc,
  })  : _nameController = nameController,
        _emailController = emailController,
        _phoneController = phoneController,
        _routeParam = routeParam,
        super(key: key);

  final GlobalKey<FormState> formGlobalKey;
  final TextEditingController _nameController;
  final TextEditingController _emailController;
  final TextEditingController _phoneController;
  final Map<String, dynamic>? _routeParam;
  final UserBloc userBloc;
  final AdduserformBloc addUserBloc;

  _triggerFieldValidation(
    AdduserformState state,
    BuildContext context,
  ) {
    context
        .read<AdduserformBloc>()
        .add(UsernameChanged(username: state.username.value));
    context
        .read<AdduserformBloc>()
        .add(UseremailChanged(useremail: state.useremail.value));
    context.read<AdduserformBloc>().add(
        UserphonenumberChanged(userphonenumber: state.userphonenumber.value));

    if (state.useremail.invalid ||
        state.username.invalid ||
        state.userphonenumber.invalid) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text('Please enter correct information'),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdduserformBloc, AdduserformState>(
      builder: (context, stateForm) {
        return Column(
          children: [
            TextField(
              controller: _nameController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                errorText:
                    stateForm.username.invalid ? 'Name is required' : null,
                labelText: 'Name',
              ),
              onChanged: (name) =>
                  addUserBloc.add(UsernameChanged(username: name)),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                errorText: !(stateForm.useremail.pure)
                    ? stateForm.useremail.error ==
                            UseremailValidationError.empty
                        ? 'Email is required'
                        : stateForm.useremail.error ==
                                UseremailValidationError.inValid
                            ? 'Email is invalid'
                            : null
                    : null,
                labelText: 'Email',
              ),
              onChanged: (email) =>
                  addUserBloc.add(UseremailChanged(useremail: email)),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              maxLength: 10,
              decoration: InputDecoration(
                errorText: !(stateForm.userphonenumber.pure)
                    ? stateForm.userphonenumber.error ==
                            UserphonenumberValidationError.empty
                        ? 'Phone Number is required'
                        : stateForm.userphonenumber.error ==
                                UserphonenumberValidationError.inValid
                            ? 'Phone number is invalid'
                            : null
                    : null,
                labelText: 'Phone Number',
              ),
              onChanged: (ph) =>
                  addUserBloc.add(UserphonenumberChanged(userphonenumber: ph)),
            ),
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                return state.status != UserListStatus.inProgress
                    ? ElevatedButton(
                        onPressed: () async {
                          if (stateForm.formStatus == FormzStatus.valid) {
                            _routeParam != null && _routeParam!['isEdit']
                                ? userBloc.add(EditUser(
                                    editUser: UserModel(
                                    userId: _routeParam!['user'].userId,
                                    userName: _nameController.text,
                                    userEmail: _emailController.text,
                                    userPhoneNumber: _phoneController.text,
                                  )))
                                : userBloc.add(
                                    AddUser(
                                      name: _nameController.text,
                                      email: _emailController.text,
                                      phone: _phoneController.text,
                                    ),
                                  );
                          } else {
                            _triggerFieldValidation(stateForm, context);
                          }
                        },
                        child: _routeParam != null && _routeParam!['isEdit']
                            ? const Text('Edit')
                            : const Text('Add'),
                      )
                    : const CircularProgressIndicator();
              },
            )
          ],
        );
      },
    );
  }
}
