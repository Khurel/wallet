import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class WalletFirebaseUser {
  WalletFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

WalletFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<WalletFirebaseUser> walletFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<WalletFirebaseUser>((user) => currentUser = WalletFirebaseUser(user));
