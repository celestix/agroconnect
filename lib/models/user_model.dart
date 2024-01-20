import 'package:cloud_firestore/cloud_firestore.dart';

const _userCollection = 'users';

class UserModel {
  late final String uid;
  late final String firstName;
  late final String? lastName;
  late final String? email;

  UserModel({
    required this.uid,
    required this.firstName,
    this.lastName,
    this.email,
  });

  UserModel.fromMap(Map<String, dynamic> map) {
    uid = map['uid'];
    firstName = map['firstName'];
    lastName = map['lastName'];
    email = map['email'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
    };
  }

  Future<void> add({FirebaseFirestore? dbInstance}) async {
    await (dbInstance ?? FirebaseFirestore.instance)
        .collection(_userCollection)
        .doc(uid)
        .set(toMap());
  }

  Future<void> update({FirebaseFirestore? dbInstance}) async {
    await (dbInstance ?? FirebaseFirestore.instance)
        .collection(_userCollection)
        .doc(uid)
        .update(toMap());
  }

  Future<void> delete({FirebaseFirestore? dbInstance}) async {
    await (dbInstance ?? FirebaseFirestore.instance)
        .collection(_userCollection)
        .doc(uid)
        .delete();
  }
}

Future<UserModel> getUser(String uid, {FirebaseFirestore? dbInstance}) async {
  final user = await (dbInstance ?? FirebaseFirestore.instance)
      .collection(_userCollection)
      .doc(uid)
      .get();
  return UserModel.fromMap(user.data()!);
}
