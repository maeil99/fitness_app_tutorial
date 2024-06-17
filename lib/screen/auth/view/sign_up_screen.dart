import 'package:fitness_app_tutorial/config/theme/app_palette.dart';
import 'package:fitness_app_tutorial/screen/auth/bloc/auth_bloc.dart';
import 'package:fitness_app_tutorial/screen/auth/widget/auth_field.dart';
import 'package:fitness_app_tutorial/screen/auth/widget/auth_gradient_button.dart';
import 'package:fitness_app_tutorial/utils/constant/path_route.dart';
import 'package:fitness_app_tutorial/utils/widget/loader.dart';
import 'package:fitness_app_tutorial/utils/widget/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  late final AuthBloc _authBloc;

  @override
  void initState() {
    _authBloc = AuthBloc();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<AuthBloc, AuthState>(
        bloc: _authBloc,
        listener: (context, state) async {
          if (state is AuthFailure) {
            showSnackBar(context, state.message);
          }

          if (state is AuthSuccess) {
            await Navigator.pushReplacementNamed(context, PathRoute.homeScreen);
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Loader();
          }
          return Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(30),
                  AuthField(controller: nameController, hintText: "Name"),
                  const Gap(15),
                  AuthField(controller: emailController, hintText: "Email"),
                  const Gap(15),
                  AuthField(
                    controller: passwordController,
                    hintText: "Password",
                    isObscureText: true,
                  ),
                  const Gap(20),
                  AuthGradientButton(
                    title: "Sign Up",
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        _authBloc.add(AuthSignUp(
                          name: nameController.text.trim(),
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                        ));
                      }
                    },
                  ),
                  const Gap(20),
                  GestureDetector(
                    onTap: () async {
                      await Navigator.pushNamed(context, PathRoute.loginScreen);
                    },
                    child: RichText(
                      text: TextSpan(
                        text: "Already have an account? ",
                        style: Theme.of(context).textTheme.titleMedium,
                        children: [
                          TextSpan(
                            text: "Sign In",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: AppPalette.gradient2,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
