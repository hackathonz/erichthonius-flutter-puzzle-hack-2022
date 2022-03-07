import 'package:swap_it/models/models.dart';

abstract class ProfileRepository {
  Future<bool> validateUsername(final String username);

  Future<void> updateProfile(final UserProfile profile);
}

class RealProfileRepository extends ProfileRepository {
  @override
  Future<void> updateProfile(UserProfile profile) {
    throw UnimplementedError();
  }

  @override
  Future<bool> validateUsername(String username) {
    throw UnimplementedError();
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
