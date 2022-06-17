import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class EnglishUniverseFirebaseUser {
  EnglishUniverseFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

EnglishUniverseFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<EnglishUniverseFirebaseUser> englishUniverseFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<EnglishUniverseFirebaseUser>(
            (user) => currentUser = EnglishUniverseFirebaseUser(user));
