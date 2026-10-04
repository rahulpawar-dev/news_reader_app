import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserProfile {
  final String name;
  final String imageUrl;
  UserProfile({required this.name, required this.imageUrl});
}

final userProvider = NotifierProvider<UserNotifier, UserProfile>(() => UserNotifier());

class UserNotifier extends Notifier<UserProfile> {
  final _box = Hive.box('auth_box');

  @override
  UserProfile build() {
    return UserProfile(
      name: _box.get('userName', defaultValue: 'Flutter Developer'),
      imageUrl: _box.get('profileImage', defaultValue: 'https://storage.googleapis.com/cms-storage-bucket/70760bf1f88b184bb1cb.png'),
    );
  }

  void updateProfile(String name, String imageUrl) {
    state = UserProfile(name: name, imageUrl: imageUrl);
    _box.put('userName', name);
    _box.put('profileImage', imageUrl);
  }

  void logout() {

    _box.delete('is_logged_in');
  }
}