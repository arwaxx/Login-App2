
import '../../view/auth/welcome_screen2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

import 'components/my_text_field.dart';
import '../../view_model/sign_in/sign_in_bloc.dart';
import '../../view_model/sign_up/sign_up_bloc.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
	final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
	bool signInRequired = false;
	IconData iconPassword = CupertinoIcons.eye_fill;
	bool obscurePassword = true;
	String? _errorMsg;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
			listener: (context, state) {
				if(state is SignInSuccess) {
					setState(() {
					  signInRequired = false;
					});
				} else if(state is SignInProcess) {
					setState(() {
					  signInRequired = true;
					});
				} else if(state is SignInFailure) {
					setState(() {
					  signInRequired = false;
						_errorMsg = 'Invalid email or password';
					});
				}
			},
			child: Form(
					key: _formKey,
					child: Column(
						children: [
							const SizedBox(height: 20),
							SizedBox(
								width: MediaQuery.of(context).size.width * 0.9,
								child: MyTextField(
									controller: emailController,
									hintText: 'Your Email',
									obscureText: false,
									keyboardType: TextInputType.emailAddress,
									prefixIcon: const Icon(CupertinoIcons.mail_solid),
									errorMsg: _errorMsg,
									validator: (val) {
										if (val!.isEmpty) {
											return 'Please fill in this field';
										} else if (!RegExp(r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$').hasMatch(val)) {
											return 'Please enter a valid email';
										}
										return null;
									}
								)
							),
							const SizedBox(height: 30),
							SizedBox(
								width: MediaQuery.of(context).size.width * 0.9,
								child: MyTextField(
									controller: passwordController,
									hintText: 'Password',
									obscureText: obscurePassword,
									keyboardType: TextInputType.visiblePassword,
									prefixIcon: const Icon(CupertinoIcons.lock_fill),
									errorMsg: _errorMsg,
									validator: (val) {
										if (val!.isEmpty) {
											return 'Please fill in this field';
										} else if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]).{8,}$').hasMatch(val)) {
											return 'Please enter a valid password';
										}
										return null;
									},
									suffixIcon: IconButton(
										onPressed: () {
											setState(() {
												obscurePassword = !obscurePassword;
												if(obscurePassword) {
													iconPassword = CupertinoIcons.eye_fill;
												} else {
													iconPassword = CupertinoIcons.eye_slash_fill;
												}
											});
										},
										icon: Icon(iconPassword),
									),
								),
							),
							const SizedBox(height: 150),
					!signInRequired
							? SizedBox(
						width: MediaQuery.of(context).size.width * 0.8,
						child: TextButton(
							onPressed: () {
								if (_formKey.currentState!.validate()) {
									context.read<SignInBloc>().add(SignInRequired(
											emailController.text, passwordController.text));
								}
							},
							style: TextButton.styleFrom(
								elevation: 3.0,
								backgroundColor: Theme.of(context).colorScheme.primary,
								foregroundColor: Colors.white,
								shape: RoundedRectangleBorder(
									borderRadius: BorderRadius.circular(12), // Rounded edges
								),
							),
							child: const Padding(
								padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8), // Adjust padding
								child: Text(
									'Sign In',
									textAlign: TextAlign.center,
									style: TextStyle(
										color: Colors.white,
										fontSize: 16,
										fontWeight: FontWeight.w600,
									),
								),
							),
						),
					)
							: const CircularProgressIndicator(),
							const SizedBox(height: 35),
							Row(
								mainAxisAlignment: MainAxisAlignment.center,
								children: [
									const Text(
										"Don’t you have an account?",
										style: TextStyle(
											fontSize: 15, // Slightly smaller font for the subheader
											fontWeight: FontWeight.w500,
											fontFamily: 'Poppins',
											color: Color(0xFF06284B),
										),
									),
									const SizedBox(width: 5),
									GestureDetector(
										onTap: () {
											Navigator.push(
												context,
												MaterialPageRoute(
													builder: (context) => WelcomeScreen2()
												),
											);
										},
										child: const Text(
											"Register",
											style: TextStyle(
												fontSize: 15,
												fontWeight: FontWeight.w600,
												fontFamily: 'Poppins',
												color: Colors.purple, // Highlighted color for the link
											),
										),
									),

								],
							),


						],
					)
				),
		);
  }
}
