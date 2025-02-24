import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spot_speek/core/constants/app_colors.dart';
import 'package:spot_speek/core/constants/style.dart';
import 'package:spot_speek/presentation/widgets/custom_button.dart';
import 'package:spot_speek/presentation/widgets/custom_text_field.dart';
import 'package:spot_speek/core/constants/routes.dart';
import 'package:spot_speek/presentation/viewmodels/auth_viewmodel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  TextStyle titleStyle() {
    return TextStyle(
        color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 35);
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = context.watch<AuthViewModel>();
    return Scaffold(
        appBar: AppBar(title: const Text('')),
        body: Stack(children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Column(
              spacing: 10,
              children: [
                Text(
                  "Welcome to SpotSeek",
                  style: titleStyle(),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),

                BorderedTextField(
                    placeholder: "Enter Your Email",
                    validator: (value) {
                      return null;

// Validate Email
                    },
                    controller: _emailController,
                    leftIcon: const Icon(Icons.email_outlined)),

                BorderedTextField(
                  leftIcon: const Icon(Icons.lock),
                  placeholder: "Enter Your Password",
                  controller: _passwordController,
                  validator: (value) {
                    return null;

                    // Validate Password
                  },
                ),
                // const Spacer(),
                if (authViewModel.isLoading)
                  const CircularProgressIndicator()
                else
                  CustomButton(
                      onPressed: () async {
                        var isSuccess = await authViewModel.login(
                            _emailController.text.trim(),
                            _passwordController.text.trim());
                        if (isSuccess) {
                          Navigator.pushReplacementNamed(
                              context, AppRoutes.home);
                        }
                      },
                      text: 'Login'),
                if (authViewModel.errorMessage.isNotEmpty)
                  Text(
                    authViewModel.errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                        onPressed: () {
                          authViewModel.removeError();
                          Navigator.pushReplacementNamed(
                              context, AppRoutes.signup);
                        },
                        child: const Text("Register here"))
                  ],
                )
                // Text(
                //   errorMessage,
                //   style: TextStyle(color: Colors.red),
                // ),
              ],
            ),
          ),
        ]));
  }
}
