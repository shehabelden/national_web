import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/var/controllers.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';
import '../drawer.dart';
import '../request_page.dart';

class UpdateCard extends StatelessWidget {
  const UpdateCard({super.key});
  @override
  Widget build(BuildContext context) {
    MainCubit cubit=MainCubit.get(context);
    cubit.requestUpdateCardCubit("update",cubit.myProfile["userType"]);
    cubit.getMyProfile();
    return   BlocBuilder<MainCubit,MainState>(
        builder: (context,state) {
          return  Scaffold(
            appBar: AppBar(),
            drawer: Drawer(
              child:DrawerWidget(cubit:cubit),
            ),
            body:state is UpdateCardEmptyState ? const Center(child: CircularProgressIndicator(),) : Padding(
              padding: const EdgeInsets.only(left: 350.0),
              child: Container(
                height: 600,
                width: 800,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(.5),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20,),
                    const Text("       update card request",style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF800f2f),
                    ),),
                    const SizedBox(height: 40,),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: cubit.updateDataCard.length,
                        itemBuilder: (context,i) {
                          return InkWell(
                            onTap: (){
                              Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) =>   RequestPage(
                                      cubit: cubit,
                                      name:cubit.profile[i]["name"],
                                      requestType: cubit.updateDataCard[i]["request_name"],
                                      image:cubit.updateDataCard[i]["image"],
                                      massegge: cubit.updateDataCard[i]["massege"] ==null ? "":cubit.updateDataCard[i]["massege"] ,
                                      national:cubit.profile[i]["national_id"] ,
                                    ),
                                  ));

                            },
                            child: Container(
                              height: 50,
                              width: 200,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey.shade100,width: 2),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child:  Padding(
                                      padding:const EdgeInsets.only(left: 20.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text("name :",style: TextStyle(
                                                  color: Color(0xFF800f2f),
                                                  fontWeight: FontWeight.bold
                                              ),),
                                              Text("${cubit.updateDataCard[i]["name"]}"),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("request type :",style: TextStyle(
                                                  color: Color(0xFF800f2f),
                                                  fontWeight: FontWeight.bold
                                              ),),
                                              Text(" ${cubit.updateDataCard[i]["request_name"]}"),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: SizedBox(
                                      width: 200,
                                      height: 50,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 0.0),
                                        child: Row(
                                          children: [
                                            InkWell(
                                              onTap: () async{
                                                await cubit.addAcptedData(cubit.profileId[i],{"status":"accepted"},cubit.updateDataCard[i],"my_cards", cubit.requestId[i],);
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(
                                                    content: const Text('done'),
                                                    action: SnackBarAction(
                                                      label: '',
                                                      onPressed: () {
                                                        // Code to execute.
                                                      },
                                                    ),
                                                  ),
                                                );

                                              },
                                              child: Container(
                                                width: 100,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color:const Color(0xFF00B140),
                                                  ),
                                                  borderRadius:BorderRadius.circular(20),
                                                ),
                                                alignment: Alignment.center,
                                                child:const Text("accept",style: TextStyle(color: Color(0xFF00B140),),),
                                              ),
                                            ),
                                            const SizedBox(width: 20,),
                                            InkWell(
                                              onTap: ()async{
                                                showDialog(
                                                    context: context,
                                                    builder: (context) => AlertDialog(
                                                      title:const Text(" reject"),
                                                      actions: [
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            TextField(
                                                              decoration:const InputDecoration(
                                                                  label: Text("add reject")),
                                                              controller: Controllers.userNameController,
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.only(left: 60.0,top:20),
                                                              child: InkWell(
                                                                onTap: () async{
                                                                  print(cubit.profileId[i]);
                                                                  await cubit.addRegctedData(cubit.profileId[i],{"status":"rejected","massege":Controllers.userNameController.text,"request_name":cubit.updateDataCard[i]["request_name"],},"my_cards", cubit.requestId[i],);
                                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                                    SnackBar(
                                                                      content: const Text('done'),
                                                                      action: SnackBarAction(
                                                                        label: '',
                                                                        onPressed: () {
                                                                        },
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                                child: Container(
                                                                  width: 100,
                                                                  height: 40,
                                                                  decoration: BoxDecoration(
                                                                      color: Color(0xFF800f2f),
                                                                      borderRadius: BorderRadius.circular(12)
                                                                  ),
                                                                  alignment: Alignment.center,
                                                                  child:const Text(" reject",style: TextStyle(
                                                                      color: Colors.white
                                                                  ),),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ));
                                              },
                                              child: Container(
                                                width: 100,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.red,
                                                  ),
                                                  borderRadius:BorderRadius.circular(20),
                                                ),
                                                alignment: Alignment.center,
                                                child:const Text("reject",style: TextStyle(color: Colors.red,),),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}
