import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_crud/add_user/add_user.dart';
import 'package:flutter_bloc_crud/users/users.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late UserBloc userBloc;
  @override
  void initState() {
    userBloc = UserBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => userBloc,
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: UserView(
            userBloc: userBloc,
          ),
          routes: {
            UserView.routeName: (context) => UserView(
                  userBloc: userBloc,
                ),
            AddUserView.routeName: (context) => AddUserView(
                  userBloc: userBloc,
                ),
          }),
    );
  }
}
