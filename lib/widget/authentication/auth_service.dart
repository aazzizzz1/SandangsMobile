import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  static FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> signIn({required String email,required String password}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
      );
      return FirebaseAuth.instance.currentUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        rethrow;
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        rethrow;
      }
    }
    return null;
  }

  Future verifyEmail() async {
    final user = FirebaseAuth.instance.currentUser;
    await user?.sendEmailVerification();
  }

  Future<User?> createUser({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return FirebaseAuth.instance.currentUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      rethrow;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static void signOut(){
    auth.signOut();
  }

  Future<bool> checkEmail ({required String email}) async {
    try{
      final list  = await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      if(list.isNotEmpty){
        return true;
      } else {
        return false;
      }
    } catch (e){
      print(e.toString());
      rethrow;
    }
  }

  void resetPassword(String email) async {
    await auth.sendPasswordResetEmail(email: email);
  }
}