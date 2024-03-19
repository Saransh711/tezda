// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, unused_local_variable

import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tezda/screens/login/bloc/login_bloc.dart';
import 'package:tezda/screens/login/bloc/login_event.dart';
import 'package:tezda/screens/login/bloc/login_state.dart';

class UpdateProfileScreen extends StatefulWidget {
  final File? image;
  final String name;
  final String email;

  const UpdateProfileScreen({
    super.key,
    this.image,
    required this.name,
    required this.email,
  });

  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  File? image;
  String imageUrl = "";

  @override
  void initState() {
    super.initState();
    fetchProfileImage();
  }

  Future<void> fetchProfileImage() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userId = user.uid;
        final ref = firebase_storage.FirebaseStorage.instance
            .ref()
            .child('profile_images/$userId');

        String downloadUrl = await ref.getDownloadURL();
        setState(() {
          imageUrl = downloadUrl;
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching profile image: $e');
      }
    }
  }

  Future<void> getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      final base64Image = base64Encode(bytes);

      setState(() {
        image = File(pickedFile.path);
        imageUrl = base64Image;
      });
    }
  }

  Future<String> uploadImage(File imageFile) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userId = user.uid;
        firebase_storage.Reference ref =
            firebase_storage.FirebaseStorage.instance.ref().child(
                'profile_images/$userId/${DateTime.now().millisecondsSinceEpoch}');
        firebase_storage.UploadTask uploadTask = ref.putFile(imageFile);
        firebase_storage.TaskSnapshot storageTaskSnapshot = await uploadTask;
        String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
        return downloadUrl;
      } else {
        return '';
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error uploading image: $e');
      }
      return '';
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
          },
          child: BlocBuilder<LoginBloc, LoginBlocState>(
            builder: (context, state) {
              if (state is LoginSuccess) {
                nameController.text = widget.name;
                emailController.text = widget.email;
                imageUrl = state.image;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: getImage,
                      child: CircleAvatar(
                        radius: 75,
                        backgroundImage: imageUrl.isNotEmpty
                            ? NetworkImage(imageUrl)
                            : image != null
                                ? Image.file(image!).image
                                : null,
                        child: imageUrl.isNotEmpty
                            ? null
                            : image != null
                                ? Container()
                                : const Icon(Icons.error),
                      ),
                    ),
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
                        String imageUrl = '';
                        if (image != null) {
                          imageUrl = await uploadImage(image!);
                        }
                        context.read<LoginBloc>().add(
                              SaveButtonTapEvent(
                                email: emailController.text.trim(),
                                name: nameController.text.trim(),
                                img: "",
                              ),
                            );
                      },
                      child: const Text('Save'),
                    ),
                  ],
                );
              } else if (state is Loading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.amber,
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
