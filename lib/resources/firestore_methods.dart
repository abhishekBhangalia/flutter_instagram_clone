import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram_clone/models/Post.dart';
import 'package:instagram_clone/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //upload post

  Future<String> uploadPost(
    String description,
    Uint8List postImageFile,
    String uid,
    String profileImg,
    String username,
  ) async {
    String res = "error";

    try {
      String postImgUrl = await StorageMethods()
          .uploadImageToStorage("posts", postImageFile, true);

      String postId = const Uuid().v1(); //unique id made according to time

      Post post = Post(
        description: description,
        postId: postId,
        username: username,
        postUrl: postImgUrl,
        profileImage: profileImg,
        datePublished: DateTime.now(),
        uid: uid,
        likes: [],
      );

      _firestore.collection('posts').doc(postId).set(post.toMap());
      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid]),
        });
      } else {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid]),
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
