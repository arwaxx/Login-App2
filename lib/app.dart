
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_app/view_model/authentication/authentication_bloc.dart';
import 'package:user_repository/user_repository.dart';

import 'app_view.dart';

class MyApp extends StatelessWidget {
  final UserRepository userRepository;
  const MyApp(this.userRepository, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      create: (context) {
        print('Initializing AuthenticationBloc...');
        return AuthenticationBloc(userRepository: userRepository);
      },
      lazy: true, // Delay creation until needed
      child: const MyAppView(),
    );
  }
}
