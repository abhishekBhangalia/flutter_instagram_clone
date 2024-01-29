import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String username;

  final String uid;
  final String description;
  final String postId;
  final String postUrl;
  final String profileImage;
  final datePublished;
  final likes;

  const Post(
      {required this.description,
      required this.postId,
      required this.username,
      required this.postUrl,
      required this.profileImage,
      required this.datePublished,
      required this.uid,
      required this.likes});

  Map<String, dynamic> toMap() => {
        "description": description,
        "postId": postId,
        "postUrl": postUrl,
        "profileImage": profileImage,
        'datePublished': datePublished,
        'likes': likes,
        'uid': uid,
        'username': username,
      };

  static Post getUserFromSnap(DocumentSnapshot snapshot) {
    // print("snapshot");
    // print(snapshot.data());
    var snap = snapshot.data() as Map<String, dynamic>;
    return Post(
      description: snap['description'],
      datePublished: snap['datePublished'],
      username: snap['username'],
      postId: snap['postId'],
      postUrl: snap['postUrl'],
      profileImage: snap['profileImage'],
      uid: snap['uid'],
      likes: snap['likes'],
    );
  }
}
