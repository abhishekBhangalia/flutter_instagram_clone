// ignore_for_file: unnecessary_null_comparison

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/models/User.dart' as model;
import 'package:instagram_clone/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<String> registerUser({
    required String username,
    required String email,
    required String password,
    required String bio,
    required Uint8List prof_img,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          username.isNotEmpty &&
          bio.isNotEmpty &&
          prof_img != null) {
        //registering user
        UserCredential _cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        print(_cred.user!.uid);

        String photoUrl = await StorageMethods()
            .uploadImageToStorage("profilePics", prof_img, false);

        model.User newUser = model.User(
            email: email,
            password: password,
            username: username,
            bio: bio,
            followes: [],
            following: [],
            uid: _cred.user!.uid,
            photoUrl: photoUrl);

        //add user data to firestore database
        await _firebaseFirestore
            .collection('users')
            .doc(_cred.user!.uid)
            .set(newUser.toMap());

        res = 'success';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> loginUser(
      {required String email, required String passwd}) async {
    String res = "Some error";

    try {
      if (email.isNotEmpty && passwd.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(email: email, password: passwd);
        res = 'success';
      }
    }

    // we can customise message shown wrt different error codes

    // on FirebaseAuthException catch (e){
    //   if(e.code == 'wrong-password'){

    //   }
    // }

    catch (err) {
      res = err.toString();
    }

    return res;
  }

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    print('user ${currentUser.email}');

    DocumentSnapshot snapshot =
        await _firebaseFirestore.collection('users').doc(currentUser.uid).get();

    return model.User.getUserFromSnap(snapshot);
  }


  Future<void> signOut() async {
    await _auth.signOut();
  }
}
