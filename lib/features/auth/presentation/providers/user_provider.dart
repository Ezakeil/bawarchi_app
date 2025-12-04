import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? _userName;
  
  // Expose getter with default value
  String get userName => (_userName == null || _userName!.isEmpty) ? 'Chef' : _userName!;

  UserProvider() {
    _init();
  }

  void _init() {
    _auth.authStateChanges().listen((User? user) {
      if (user != null) {
        loadUserData();
      } else {
        _userName = null;
        notifyListeners();
      }
    });
  }

  // Public method to refresh data
  Future<void> loadUserData() async {
    final user = _auth.currentUser;
    if (user == null) return;

    try {
      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (doc.exists) {
        final data = doc.data();
        _userName = data?['name'] as String?;
      } else {
        _userName = null; 
      }
    } catch (e) {
      debugPrint('Error fetching user data: $e');
      _userName = null;
    }
    notifyListeners();
  }
}
