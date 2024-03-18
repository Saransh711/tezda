import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tezda/config/route.dart';

import '../login/bloc/login_bloc.dart';
import '../login/bloc/login_event.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  void _editProfile() {
    Navigator.pushNamed(
      context,
      AppRoute.editProfile,
      arguments: {},
    );
  }

  void _logout() {
    BlocProvider.of<LoginBloc>(context).add(
      const LogoutButtonTapEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(16.0),
          children: [
            ListTile(
              title: ElevatedButton(
                onPressed: _editProfile,
                child: const Text('Edit Profile'),
              ),
            ),
            ListTile(
              title: ElevatedButton(
                onPressed: _logout,
                child: const Text('Logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
