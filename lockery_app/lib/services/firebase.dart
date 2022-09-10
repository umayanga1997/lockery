import 'package:cloud_firestore/cloud_firestore.dart';

var fireStore = FirebaseFirestore.instance;

var lockersCollection = fireStore.collection('lockers');
var userCollection = fireStore.collection('users');
var bookedCollection = fireStore.collection('booked');
