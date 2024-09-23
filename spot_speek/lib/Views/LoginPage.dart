import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('')),
        body: Stack(children: [
          Column(
            children: [
              Container(
                // color: Colors.brown,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2,
              ),
              Spacer()
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  "Welcome to SpotSeek",
                  style: Theme.of(context).textTheme.displayLarge,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 50),
                Icon(
                  Icons.person_pin_circle_outlined,
                  size: 200,
                  color: Theme.of(context).primaryColor,
                ),
                Spacer(),
                BorderedTextField(
                    leftIcon: Icon(Icons.email_outlined),
                    placeholder: "Enter Your Email"),
                SizedBox(height: 20),
                BorderedTextField(
                    leftIcon: Icon(Icons.lock),
                    placeholder: "Enter Your Password"),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Login'),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                        onPressed: () {}, child: const Text("Register here"))
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

class BorderedTextField extends StatelessWidget {
  final String placeholder;
  final Icon? leftIcon;

  const BorderedTextField(
      {super.key, required this.placeholder, this.leftIcon});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          prefixIcon: leftIcon,
          prefixIconColor: Theme.of(context).colorScheme.primary,
          label: Text(placeholder),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)))),
    );
  }
}
