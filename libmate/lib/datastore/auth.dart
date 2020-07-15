import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:libmate/datastore/model.dart';


Future<UserModel> googleSignIn(bool login) async {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  if (login) {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult =
    await FirebaseAuth.instance.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    // Checking if email and name is null
    assert(user.email != null);
    assert(user.displayName != null);
    assert(user.photoUrl != null);

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    assert(user.uid == currentUser.uid);

    return UserModel(
        name: user.displayName,
        email: user.email,
        photoUrl: user.photoUrl,
        uid: user.uid);
  } else {
    await googleSignIn.signOut();
    return UserModel(name: '', email: '', photoUrl: '', uid: '');
  }
}


class AuthDataService {

  void createEntry(data) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    Firestore.instance.collection("users")
        .document(firebaseUser.uid)
        .setData(data)
        .then((value) {
      print("User Data was successfully Committed to the servers");
    });
  }

  void updateEntry(data) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    Firestore.instance.collection("users")
        .document(firebaseUser.uid)
        .setData(data)
        .then((value) {
      print("User Data was successfully Committed to the servers");
    });
  }
}