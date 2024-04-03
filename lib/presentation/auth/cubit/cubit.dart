import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'state.dart';
class AuthCubit extends Cubit<AuthMainState> {
  AuthCubit() : super(AuthInitState());
  static AuthCubit get(context) => BlocProvider.of(context);
  signInCubit(emailAddress, password) async {
    emit(EmptyLoginState());
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: "$emailAddress", password: password);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
    emit(SignInState());
  }

  signUpCubit(emailAddress, password,name) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: "$emailAddress",
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        // print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    print("e");
    createProf(FirebaseAuth.instance.currentUser!.uid,name);
    emit(SignUpState());
  }
  createProf(uid,name)async{
   await FirebaseFirestore.instance.collection("Profile").doc(uid).set(
     {
       "name":name,
     }
   );
   FirebaseFirestore.instance.
   collection("Profile").doc(uid).collection("my_cards").doc("national_card").set({
     "name":"national card",
   });
   FirebaseFirestore.instance.
   collection("Profile").doc(uid).collection("my_family").add({});
  }
}
