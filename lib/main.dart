
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'app.dart';
import 'simple_bloc_observer.dart';

Future<void> main() async {
	WidgetsFlutterBinding.ensureInitialized();

	// Initialize Firebase
	await Firebase.initializeApp();

	// Set up Bloc observer for debugging
	Bloc.observer = SimpleBlocObserver();

	// Initialize UserRepository
	final userRepository = FirebaseUserRepo();

	// Run the app
	runApp(MyApp(userRepository));
}
