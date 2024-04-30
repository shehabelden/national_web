import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:national_web/presentation/home_bage/cubit/cubit.dart';
import 'package:national_web/presentation/home_bage/screen/add_card.dart';
import 'package:national_web/presentation/home_bage/screen/add_family.dart';
import 'package:national_web/presentation/home_bage/screen/update_card.dart';
import 'package:national_web/presentation/home_bage/screen/update_family.dart';

import 'cubit/state.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key, required this.cubit});
  final MainCubit cubit;
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<MainCubit,MainState>(
        builder: (context,state) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: InkWell(
                  onTap: () async{
                    Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const  AddCard(),
                        ));
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.account_circle_outlined),
                      Text(
                        "  add card",
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: InkWell(
                  onTap: () async{
                    Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const  UpdateCard(),
                        ));
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.account_circle_outlined),
                      Text(
                        "  update card",
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const  AddFamily(),
                        ));
                  },
                  child:cubit.myProfile["userType"]!="Ministry of Interior" ? Container(): const Row(
                    children: [
                      Icon(Icons.account_circle_outlined),
                      Text(
                        "  add family member",
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: cubit.myProfile["userType"]!="Ministry of Interior" ? Container(): InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(
                      builder: (_) =>  UpdateFamily(),
                    ));
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.account_circle_outlined),
                      Text(
                        "  update family member",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
    );
  }
}
