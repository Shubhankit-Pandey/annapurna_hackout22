import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseDonor {
  final String uid;

  DatabaseDonor({required this.uid});

  final CollectionReference profileCollection =
  FirebaseFirestore.instance.collection('donor_profile');

  Future<void> updateUserData(String email,String uid) async {
    print("result1$email");
    return await profileCollection.doc(uid).set({
      'email': email,
      'uid': uid,
  });
  }
}

class DatabaseNGO{
  final String uid;

  DatabaseNGO({required this.uid});

  final CollectionReference profile =
  FirebaseFirestore.instance.collection('ngo_profile');

  Future<void> updateUserData(String email,String uid) async {
    print("result1$email");
    return await profile.doc(uid).set({
      'email': email,
      'uid': uid,
    });
  }
}