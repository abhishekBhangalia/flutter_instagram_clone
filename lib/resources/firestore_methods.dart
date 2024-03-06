import 'dart:js_interop';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram_clone/models/Post.dart';
import 'package:instagram_clone/resources/storage_methods.dart';
import 'package:instagram_clone/utils/utils.dart';
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


  Future<void> postComment(String postId, String text, String uid, String name, String profilePic) async {
    try{
      if (text.isNotEmpty){
        String commentId = const Uuid().v1();
        await _firestore.collection('posts').doc(postId).collection('comments').doc(commentId).set({
          'profilePic':profilePic,
          'name':name,
          'text':text,
          'uid':uid,
          'commentId':commentId,
          'datePublished':DateTime.now(),
        });
      }
      else{
        print('Text is empty');
      }
    }
    catch(e){
      print(e.toString(),);
    }
  }


  //delete a post
  Future<void> deletePost(String postId) async {
    try{

    await _firestore.collection('posts').doc(postId).delete();
    } catch(e){
      print(e.toString());
    }
  }

  Future<void> followUser(String uid, String followId) async{
    try{
      DocumentSnapshot snap = await _firestore.collection('users').doc(uid).get();
      List following = (snap.data()! as dynamic)['following'];
      bool isFollowing = following.contains(followId);
      if (isFollowing){
        await _firestore.collection('users').doc(followId).update({
          'followers':FieldValue.arrayRemove([uid])
        });
        await _firestore.collection('users').doc(uid).update({
          'following':FieldValue.arrayRemove([followId])
        });

      } else {
        await _firestore.collection('users').doc(followId).update({
          'followers':FieldValue.arrayUnion([uid])
        });
        await _firestore.collection('users').doc(uid).update({
          'following':FieldValue.arrayUnion([followId])
        });
      }

    } catch(e){
      print(e.toString());
    }
  }
}
