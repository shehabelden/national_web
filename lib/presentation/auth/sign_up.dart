import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/var/controllers.dart';
import '../../utils/var/image.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';
class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});
  @override
  Widget build(BuildContext context) {
    AuthCubit cubit=AuthCubit();
    return  Scaffold(
      body: BlocBuilder<AuthCubit,AuthMainState>(
          builder: (context,state) {
            return Row(
              children: [
                Expanded(flex: 1,child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(ImagesVar.images),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                ),
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 200.0,right: 20,left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const  Padding(
                            padding:  EdgeInsets.only(bottom: 20.0),
                            child:  Text("Sign up your account",style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                style:const TextStyle(
                                  color: Color(0xFF888888),
                                ),
                                decoration: InputDecoration(
                                  hintText: "user name",
                                  hintStyle:
                                  const TextStyle(
                                    color: Color(0xFF888888),
                                  ),
                                  filled: true,
                                  fillColor:const Color(0xFFFAFAFA), // Change this to the desired background color

                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white.withOpacity(0)), //
                                    borderRadius: BorderRadius.circular(12),// Change this to the desired border color
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:const BorderSide(color: Color(0xff888888)),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                controller:Controllers.userNameController ,
                              ),
                             const Text("  gmail",style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF888888),
                              ),),
                              TextFormField(
                                style:const TextStyle(
                                  color: Color(0xFF888888),
                                ),
                                controller: Controllers.emailController,
                                decoration: InputDecoration(
                                  hintText: "gmail",
                                  hintStyle:
                                  const TextStyle(
                                    color: Color(0xFF888888),
                                  ),
                                  filled: true,
                                  fillColor:const Color(0xFFFAFAFA), // Change this to the desired background color

                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white.withOpacity(0)), //
                                    borderRadius: BorderRadius.circular(12),// Change this to the desired border color
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:const BorderSide(color: Color(0xff888888)),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20,),
                              const Text("  password",style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF888888),
                              ),),
                              TextFormField(
                                style:const TextStyle(
                                  color: Color(0xFF888888),
                                ),
                                decoration: InputDecoration(
                                  hintText: "password",
                                  hintStyle:
                                  const TextStyle(
                                    color: Color(0xFF888888),
                                  ),
                                  filled: true,
                                  fillColor:const Color(0xFFFAFAFA), // Change this to the desired background color

                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white.withOpacity(0)), //
                                    borderRadius: BorderRadius.circular(12),// Change this to the desired border color
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:const BorderSide(color: Color(0xff888888)),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                controller:Controllers.passwordController ,
                              ),
                              TextFormField(
                                style:const TextStyle(
                                  color: Color(0xFF888888),
                                ),
                                decoration: InputDecoration(
                                  hintText: "password check",
                                  hintStyle:
                                  const TextStyle(
                                    color: Color(0xFF888888),
                                  ),
                                  filled: true,
                                  fillColor:const Color(0xFFFAFAFA), // Change this to the desired background color

                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white.withOpacity(0)), //
                                    borderRadius: BorderRadius.circular(12),// Change this to the desired border color
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:const BorderSide(color: Color(0xff888888)),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                controller:Controllers.passwordCheckController ,
                              ),

                              Padding(
                                padding: const EdgeInsets.only(top: 20.0,left: 200.0),
                                child: InkWell(
                                  onTap: (){
                                    // Navigator.push(context, MaterialPageRoute(builder: (_){
                                    //   return const LoginCheck();
                                    // }));
                                    // cubit.signUpCubit
                                    //   (Controllers.emailController.text,
                                    //     Controllers.passwordController.text,
                                    //     Controllers.userNameController.text);
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 300,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color:const Color(0xFF00B140),
                                        borderRadius: BorderRadius.circular(12),
                                    ),
                                    child:const Text("Sign Up",style: TextStyle(
                                        color: Colors.white
                                    ),),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
      ),
    );
  }
}