// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class User {
  final String uid;
  final String name;
  final String email;
  final String phoneNumber;
  final List<String> groupList;

  User({
    required this.uid,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.groupList,
  });

  User copyWith({
    String? uid,
    String? name,
    String? email,
    String? phoneNumber,
    List<String>? groupList,
  }) {
    return User(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      groupList: groupList ?? this.groupList,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'groupList': groupList,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        uid: map['uid'] as String,
        name: map['name'] as String,
        email: map['email'] as String,
        phoneNumber: map['phoneNumber'] as String,
        groupList: List<String>.from(
          (map['groupList'] as List<String>),
        ));
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(uid: $uid, name: $name, email: $email, phoneNumber: $phoneNumber, groupList: $groupList)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.name == name &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        listEquals(other.groupList, groupList);
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        name.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode ^
        groupList.hashCode;
  }
}
