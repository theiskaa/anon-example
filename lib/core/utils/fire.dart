import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
FirebaseAuth fireauthInstance = FirebaseAuth.instance;

CollectionReference postsRef = firestoreInstance.collection('posts');
