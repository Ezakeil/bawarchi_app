import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../auth/data/user_model.dart';

class PreferencesRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  PreferencesRepository({FirebaseFirestore? firestore, FirebaseAuth? auth})
    : _firestore = firestore ?? FirebaseFirestore.instance,
      _auth = auth ?? FirebaseAuth.instance;

  Future<void> saveUserPreferences({
    required String dietaryPreference,
    required String healthGoal,
  }) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw StateError('No authenticated user');
    }

    final docRef = _firestore.collection('users').doc(user.uid);

    final preferences = UserPreferences(
      dietaryPreference: dietaryPreference,
      healthGoal: healthGoal,
    );

    await docRef.set({
      'preferences': preferences.toMap(),
      'onboardingComplete': true,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Future<Map<String, dynamic>?> getUserPreferences() async {
    final user = _auth.currentUser;
    if (user == null) return null;
    final doc = await _firestore.collection('users').doc(user.uid).get();
    final data = doc.data();
    if (data == null) return null;
    final prefs = data['preferences'];
    if (prefs is Map<String, dynamic>) return prefs;
    return null;
  }

  Future<bool> isOnboardingComplete() async {
    final user = _auth.currentUser;
    if (user == null) {
      print('[PreferencesRepo] isOnboardingComplete: no user, returning false');
      return false;
    }
    final doc = await _firestore.collection('users').doc(user.uid).get();
    final data = doc.data();
    print(
      '[PreferencesRepo] isOnboardingComplete: doc exists=${doc.exists}, data=$data',
    );
    if (data == null) {
      print('[PreferencesRepo] isOnboardingComplete: no data, returning false');
      return false;
    }
    final flag = data['onboardingComplete'];
    print(
      '[PreferencesRepo] isOnboardingComplete: flag value=$flag, type=${flag.runtimeType}',
    );
    final result = flag == true;
    print('[PreferencesRepo] isOnboardingComplete: returning $result');
    return result;
  }
}
