import 'package:flutter/material.dart';
import 'package:flutter_bloc_crud/add_user/add_user.dart';
import 'package:flutter_bloc_crud/users/bloc/user_bloc.dart';
import 'package:flutter_bloc_crud/users/widgets/user_list.dart';

class UserView extends StatelessWidget {
  const UserView({Key? key, required this.userBloc}) : super(key: key);
  final UserBloc userBloc;
  static const String routeName = '/users';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: UserList(
        userBloc: userBloc,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) =>
                  AddUserView(userBloc: userBloc),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
