import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'body.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';
import 'drawer.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    MainCubit cubit=MainCubit.get(context);
    cubit.getMyProfile();
    cubit.requestAddCardCubit("",cubit.myProfile["userType"]);
    print(cubit.requestData);
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child:DrawerWidget(cubit:cubit),
      ),
      body:  BlocBuilder<MainCubit,MainState>(
          builder: (context,state) {
          return  cubit.requestData.isEmpty ?  const Center(child: CircularProgressIndicator(),) : BodyHome();
        }
      ),
    );
  }
}
