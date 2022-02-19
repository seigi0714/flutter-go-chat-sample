import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider =
    StateNotifierProvider<UserNotifier, String>(
        (_) => UserNotifier());

class UserNotifier extends StateNotifier<String> {
  UserNotifier() : super("");

  void setName(String name) {
    state = name;
  }
}
