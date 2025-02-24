import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:spot_speek/presentation/views/login_screen.dart';
import 'package:spot_speek/presentation/widgets/custom_text_field.dart';
import 'dart:io';
import '../viewmodels/profile_viewmodel.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProfileViewModel>();

    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: vm.pickProfileImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: vm.profileImageUrl.isNotEmpty
                    ? NetworkImage(vm.profileImageUrl)
                    : vm.selectedImage != null
                        ? FileImage(vm.selectedImage!) as ImageProvider
                        : AssetImage("assets/profile_placeholder.png"),
              ),
            ),
            SizedBox(height: 20),
            BorderedTextField(
              placeholder: 'Name',
              controller: vm.nameController,
              validator: (p0) => '',
            ),
            SizedBox(height: 20),
            if (vm.isLoading)
              CircularProgressIndicator()
            else
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      var success = await vm.saveProfile();
                      if (success == true) {
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text("Save Changes"),
                  ),
                  SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: () async {
                      await vm.logout();
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return LoginScreen();
                        },
                      ));
                      // Navigator.of(context).pushReplacementNamed(
                      //     '/login'); // Navigate to login screen
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: BorderSide(color: Colors.red),
                    ),
                    child: Text("Logout"),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
