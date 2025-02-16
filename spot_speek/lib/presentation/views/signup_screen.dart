import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spot_speek/core/constants/routes.dart';
import 'package:spot_speek/presentation/viewmodels/signup_viewmodel.dart';
import 'package:spot_speek/presentation/widgets/custom_button.dart';
import 'package:spot_speek/presentation/widgets/custom_text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final signupViewModel = context.watch<SignUpViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text("Signup")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              BorderedTextField(
                controller: _fullNameController,
                placeholder: 'Full Name',
                leftIcon: const Icon(Icons.person),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Full Name is required";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              BorderedTextField(
                controller: _emailController,
                placeholder: 'Email',
                leftIcon: const Icon(Icons.email),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email is required";
                  }
                  if (!RegExp(
                          r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                      .hasMatch(value)) {
                    return "Enter a valid email";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              BorderedTextField(
                controller: _passwordController,
                leftIcon: const Icon(Icons.lock),
                placeholder: 'Password',
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password is required";
                  }
                  if (value.length < 6) {
                    return "Password must be at least 6 characters";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              BorderedTextField(
                controller: _confirmPasswordController,
                placeholder: 'Confirm Password',
                obscureText: true,
                leftIcon: const Icon(Icons.lock),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Confirm your password";
                  }
                  if (value != _passwordController.text) {
                    return "Passwords do not match";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              if (signupViewModel.isLoading)
                const CircularProgressIndicator()
              else
                CustomButton(
                  onPressed: () => _signup(signupViewModel),
                  text: 'Sign Up',
                ),
              if (signupViewModel.errorMessage != null)
                Text(
                  signupViewModel.errorMessage!,
                  style: TextStyle(color: Colors.red),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, AppRoutes.login);
                      },
                      child: const Text("Login Here"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _signup(SignUpViewModel viewModel) async {
    if (_formKey.currentState?.validate() ?? false) {
      bool success = await viewModel.signUp(
        _fullNameController.text.trim(),
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      if (success) {
        // Navigate to HomeScreen if signup is successful
        if (context.mounted) {
          Navigator.pushReplacementNamed(context, AppRoutes.home);
        }
      } else {
        // Show an error message if sign-up fails
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Sign up failed. Please try again.")),
        );
      }
    }
  }
}
