import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_crud/add_user/views/views.dart';
import 'package:flutter_bloc_crud/users/users.dart';

class UserList extends StatelessWidget {
  const UserList({Key? key, required this.userBloc}) : super(key: key);
  final UserBloc userBloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      bloc: userBloc..add(UserFetch()),
      builder: (context, state) {
        switch (state.status) {
          case UserListStatus.inProgress:
            return const Center(child: CircularProgressIndicator());

          case UserListStatus.complete:
            return state.users.isNotEmpty
                ? ListView.separated(
                    separatorBuilder: (context, index) =>
                        const Divider(thickness: 1.5),
                    itemCount: state.users.length,
                    itemBuilder: (context, index) {
                      final user = state.users[index];
                      return ListTile(
                        onTap: () => Navigator.of(context).pushNamed(
                            AddUserView.routeName,
                            arguments: {"user": user, 'isEdit': true}),
                        title: Text(
                          user.userName,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Email: ${user.userEmail}',
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.black),
                              ),
                              TextSpan(
                                text: ' Contact: ${user.userPhoneNumber}',
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.remove_circle_sharp,
                          ),
                          onPressed: () =>
                              userBloc.add(RemoveUser(id: user.userId)),
                        ),
                      );
                    },
                  )
                : const Center(child: Text('Users are not present'));

          case UserListStatus.failed:
            return const Center(child: Text('Failed to load users'));

          default:
            return Container();
        }
      },
    );
  }
}
