import 'package:cloud_firestore/cloud_firestore.dart';

class UserPreferences {
  final String dietaryPreference;
  final String healthGoal;

  UserPreferences({
    required this.dietaryPreference,
    required this.healthGoal,
  });

  Map<String, dynamic> toMap() {
    return {
      'dietaryPreference': dietaryPreference,
      'healthGoal': healthGoal,
    };
  }

  factory UserPreferences.fromMap(Map<String, dynamic> map) {
    return UserPreferences(
      dietaryPreference: map['dietaryPreference'] ?? '',
      healthGoal: map['healthGoal'] ?? '',
    );
  }
}

class UserModel {
  final String uid;
  final String email;
  final String name;
  final UserPreferences? preferences;
  final bool onboardingComplete;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    this.preferences,
    this.onboardingComplete = false,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'preferences': preferences?.toMap() ?? {},
      'onboardingComplete': onboardingComplete,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : FieldValue.serverTimestamp(),
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : FieldValue.serverTimestamp(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      preferences: map['preferences'] != null
          ? UserPreferences.fromMap(map['preferences'])
          : null,
      onboardingComplete: map['onboardingComplete'] ?? false,
      createdAt: (map['createdAt'] as Timestamp?)?.toDate(),
      updatedAt: (map['updatedAt'] as Timestamp?)?.toDate(),
    );
  }
}
