import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'body.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';
import 'drawer.dart' ;
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    MainCubit cubit=MainCubit.get(context);
    cubit.requestAddCardCubit("");
    return BlocBuilder<MainCubit,MainState>(
      builder: (context,state) {
        return Scaffold(
          appBar: AppBar(),
          drawer: Drawer(
            child:DrawerWidget(cubit:cubit),
          ),
          body:MainState is  EmptyState? const Center(child: CircularProgressIndicator(),): BodyHome(),
        );
      }
    );
  }
}