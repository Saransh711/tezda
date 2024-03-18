// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tezda/screens/login/bloc/login_bloc.dart';
import 'package:tezda/screens/login/bloc/login_state.dart';
import 'package:tezda/screens/profile/edit_my_profile.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Profile'),
        ),
        body: BlocBuilder<LoginBloc, LoginBlocState>(
          builder: (context, state) {
            if (state is LoginSuccess) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 75,
                        backgroundImage: state.image.isNotEmpty
                            ? NetworkImage(state.image)
                            : null,
                        child: state.image.isNotEmpty
                            ? null
                            : const Icon(Icons.error),
                      )
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    'Name: ${state.name}',
                    style: const TextStyle(fontSize: 20.0),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    'Email:${state.email}',
                    style: const TextStyle(fontSize: 20.0),
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UpdateProfileScreen(
                                  name: state.name,
                                  email: state.email,
                                )),
                      );
                    },
                    child: const Text('Update Profile'),
                  ),
                ],
              );
            } else {
              return Container();
            }
          },
        ));
  }
}
