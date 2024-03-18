// ignore_for_file: library_private_types_in_public_api

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tezda/screens/login/bloc/login_bloc.dart';
import 'package:tezda/screens/login/bloc/login_state.dart';

import '../login/bloc/login_event.dart';

class UpdateProfileScreen extends StatefulWidget {
  final File? image;
  final String name;
  final String email;

  const UpdateProfileScreen(
      {super.key, this.image, required this.name, required this.email});

  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  File? image;

  Future<void> getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Update Profile'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocListener<LoginBloc, LoginBlocState>(
              listener: (context, state) {
            if (state is UpdateSuccess) {
              Navigator.of(context).pop();
            }
          }, child: BlocBuilder<LoginBloc, LoginBlocState>(
            builder: (context, state) {
              if (state is LoginSuccess) {
                nameController.text = widget.name;
                emailController.text = widget.email;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                        onTap: getImage,
                        child: CircleAvatar(
                          radius: 75,
                          backgroundImage: state.image.isNotEmpty
                              ? NetworkImage(state.image)
                              : Image.file(image!).image,
                          child: state.image.isNotEmpty
                              ? null
                              : const Icon(Icons.error),
                        )),
                    const SizedBox(height: 20.0),
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(labelText: 'Name'),
                    ),
                    const SizedBox(height: 20.0),
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () async {
                        // String profileImageUrl =
                        //     ''; // Initialize with an empty string

                        // // Upload image to Firebase Storage
                        // if (image != null) {
                        //   profileImageUrl = await uploadImageToFirebase(image!);
                        // }

                        context.read<LoginBloc>().add(SaveButtonTapEvent(
                            email: emailController.text.trim(),
                            name: nameController.text.trim(),
                            img: ""));
                      },
                      child: const Text('Save'),
                    ),
                  ],
                );
              } else {}
              return Container();
            },
          )),
        ));
  }
}
