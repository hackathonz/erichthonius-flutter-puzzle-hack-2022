import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swap_it/models/models.dart';

abstract class ProfileRepository {
  Future<bool> validateUsername(final String username);

  Future<void> updateProfile(final UserProfile profile);
}

class RealProfileRepository extends ProfileRepository {
  final FirebaseFirestore firestore;

  final String deviceId;

  RealProfileRepository({
    required final this.deviceId,
    required final this.firestore,
  });

  @override
  Future<void> updateProfile(UserProfile profile) {
    final userDoc = firestore.collection('users').doc(deviceId);

    final usernameDoc = firestore.collection('users').doc(profile.username);

    return Future.wait(
      [
        userDoc.set(
          profile.toJson(),
        ),
        usernameDoc.set(
          {},
        ),
      ],
    );
  }

  @override
  Future<bool> validateUsername(String username) async {
    if (username.isEmpty) {
      return false;
    } else {
      final userDoc = await (firestore.collection('users').doc(username).get());

      return userDoc.exists;
    }
  }
}

class MockProfileRepository extends ProfileRepository {
  @override
  Future<void> updateProfile(UserProfile profile) {
    return Future.value();
  }

  @override
  Future<bool> validateUsername(String username) {
    return Future.value(username.isNotEmpty);
  }
}
