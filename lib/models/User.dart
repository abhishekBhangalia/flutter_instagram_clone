import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String password;
  final String username;
  final String bio;
  final List? followes;
  final List? following;
  final String uid;
  final String photoUrl;

  const User(
      {required this.email,
      required this.password,
      required this.username,
      required this.bio,
      required this.followes,
      required this.following,
      required this.uid,
      required this.photoUrl});

  Map<String, dynamic> toMap() => {
        "email": email,
        "password": password,
        "username": username,
        "bio": bio,
        'followers': followes,
        'following': following,
        'uid': uid,
        'photoUrl': photoUrl,
      };

  static User getUserFromSnap(DocumentSnapshot snapshot) {
    print("snapshot");
    print(snapshot.data());
    var snap = snapshot.data() as Map<String, dynamic>;
    return User(
      email: snap['email'],
      password: snap['password'],
      username: snap['username'],
      bio: snap['bio'],
      followes: snap['followes'],
      following: snap['following'],
      uid: snap['uid'],
      photoUrl: snap['photoUrl'],
    );
  }
}
