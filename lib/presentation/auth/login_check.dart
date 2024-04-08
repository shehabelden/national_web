import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:national_web/presentation/home_bage/home_screen.dart';

import 'cubit/cubit.dart';
import 'cubit/state.dart';
import 'login_screen.dart';

class LoginCheck extends StatelessWidget {
  const LoginCheck({super.key});
  @override
  Widget build(BuildContext context) {
    AuthCubit cubit=AuthCubit();
    return BlocBuilder<AuthCubit,AuthMainState>(
        builder: (context,state) {
          if(state is EmptyLoginState){
          return Center(child: CircularProgressIndicator(),);}
          else{
            return FirebaseAuth.instance.currentUser == null ? LoginScreen() :HomeScreen();}
          }

    );
  }
}
