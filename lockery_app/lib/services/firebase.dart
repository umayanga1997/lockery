import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

FirebaseFirestore fireStore = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;
GoogleSignIn googleSignIn = GoogleSignIn();

var lockersCollection = fireStore.collection('lockers');
var userCollection = fireStore.collection('users');
var bookedCollection = fireStore.collection('booked');
var racksCollection = fireStore.collection('racks');
