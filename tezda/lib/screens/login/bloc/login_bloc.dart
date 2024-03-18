// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginBlocState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  LoginBloc() : super(const LoginInInitial()) {
    on<LoginButtonTapEvent>((event, emit) async {
      await signInUser(event, emit);
    });
    on<LogoutButtonTapEvent>((event, emit) async {
      await signOutUser(emit);
    });
    on<SaveButtonTapEvent>((event, emit) async {
      await updateUser(event, emit);
    });
  }
  Future<void> signInUser(
      LoginButtonTapEvent event, Emitter<LoginBlocState> emit) async {
    try {
      UserCredential userCredential;
      try {
        userCredential = await _auth.signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
      } catch (signInError) {
        if (signInError is FirebaseAuthException &&
            signInError.code == 'user-not-found') {
          userCredential = await _auth.createUserWithEmailAndPassword(
            email: event.email,
            password: event.password,
          );
        } else {
          rethrow;
        }
      }
      // Store user information in Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        "id": userCredential.user!.uid,
        'name': userCredential.user!.displayName ?? '',
        'email': userCredential.user!.email ?? '',
        'img': userCredential.user!.photoURL ?? '',
      });
      DocumentSnapshot userData = await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      Map<String, dynamic> userInfo = userData.data() as Map<String, dynamic>;

      emit(LoginSuccess(
        id: userInfo['id'],
        name: userInfo['name'],
        email: userInfo['email'],
        image: userInfo['img'],
      ));
    } catch (e) {
      rethrow; // Propagate error up
    }
  }

  Future<void> signOutUser(Emitter<LoginBlocState> emit) async {
    try {
      await _auth.signOut();
      emit(const LogoutSuccess());
    } catch (e) {
      emit(LoginFailure(error: e.toString()));
    }
  }

  Future<void> updateUser(
      SaveButtonTapEvent event, Emitter<LoginBlocState> emit) async {
    try {
      await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
        'name': event.name,
        'email': event.email,
        'img': event.img,
      });
      emit(const UpdateSuccess());
      DocumentSnapshot userData = await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .get();

      Map<String, dynamic> userInfo = userData.data() as Map<String, dynamic>;
      emit(const UpdateSuccess());
      emit(LoginSuccess(
        id: userInfo['id'],
        name: userInfo['name'],
        email: userInfo['email'],
        image: userInfo['img'],
      ));
    } catch (e) {
      rethrow;
    }
  }
}
