// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:spot_speek/presentation/viewmodels/auth_viewmodel.dart';
// import 'package:spot_speek/presentation/viewmodels/create_account_viewmodel.dart';
// import 'package:spot_speek/presentation/widgets/custom_button.dart';
// import 'package:spot_speek/presentation/widgets/custom_text_field.dart';

// class CreateAccountScreen extends StatelessWidget {
//   const CreateAccountScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // final authProvider = context.read<AuthViewModel>();

//     return Scaffold(
//       appBar: AppBar(title: const Text("Create Account")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Consumer<CreateAccountViewModel>(
//             builder: (context, viewModel, child) {
//           return Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               BorderedTextField(
//                 controller: viewModel.fullNameController,
//                 placeholder: 'Full Name',
//                 validator: (value) => viewModel.fullNameError,
//               ),
//               const SizedBox(height: 16),
//               BorderedTextField(
//                 controller: viewModel.emailController,
//                 placeholder: 'Email',
//                 keyboardType: TextInputType.emailAddress,
//                 validator: (value) => viewModel.emailError,
//               ),
//               const SizedBox(height: 16),
//               BorderedTextField(
//                 controller: viewModel.passwordController,
//                 placeholder: 'Password',
//                 obscureText: true,
//                 validator: (value) => viewModel.passwordError,
//               ),
//               const SizedBox(height: 16),
//               BorderedTextField(
//                 controller: viewModel.confirmPasswordController,
//                 placeholder: 'Confirm Password',
//                 obscureText: true,
//                 validator: (value) => viewModel.confirmPasswordError,
//               ),
//               const SizedBox(height: 24),
//               CustomButton(
//                 onPressed: () => viewModel.signup(context),
//                 text: viewModel.isLoading ? "Creating..." : "Create Account",
//               ),
//             ],
//           );
//         }),
//       ),
//     );
//   }
// }
