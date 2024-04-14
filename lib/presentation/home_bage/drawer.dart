import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:national_web/presentation/home_bage/cubit/cubit.dart';

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
                    await cubit.requestAddCardCubit("",cubit.myProfile["userType"]);
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
                    await cubit.requestUpdateCardCubit("update",cubit.myProfile["userType"]);
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
                    cubit.requestAddFamilyCubit("");
                  },
                  child: const Row(
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
                child: InkWell(
                  onTap: () {
                    cubit.requestUpdateFamilyCubit("update");
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
