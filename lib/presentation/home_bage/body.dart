import 'package:flutter/material.dart';
import '../../utils/var/controllers.dart';
import 'cubit/cubit.dart';
class BodyHome extends StatelessWidget {
  const BodyHome({super.key});
  @override
  Widget build(BuildContext context) {
    MainCubit cubit=MainCubit.get(context);
    return   cubit.requestData.isEmpty ? const Center(child: CircularProgressIndicator(),) : Padding(
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
            const Text("       update card"),
            const SizedBox(height: 40,),
            ListView.builder(
                shrinkWrap: true,
                itemCount: cubit.requestData.length,
                itemBuilder: (context,i) {
                  return Container(
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
                                Text("name :${cubit.requestData[i]["name"]}"),
                                Text(" request type :${cubit.requestData[i]["request_name"]}"),
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
                                    onTap: (){
                                      cubit.addAcptedData(cubit.profileId[i],{"status":"accepted"},cubit.requestData[i],"my_cards", cubit.requestId[i],);
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
                                      child:const Text("accepted",style: TextStyle(color: Color(0xFF00B140),),),
                                    ),
                                  ),
                                  const SizedBox(width: 20,),
                                  InkWell(
                                    onTap: (){
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title:const Text("add rejected"),
                                            actions: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  TextField(
                                                    decoration:const InputDecoration(
                                                        label: Text("add rejected")),
                                                    controller: Controllers.userNameController,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 60.0),
                                                    child: InkWell(
                                                      onTap: () async{
                                                        cubit.addRegctedData(cubit.profileId[i],{"status":"rejected"},"my_cards", cubit.requestId[i],);
                                                      },
                                                      child: Container(
                                                        width: 100,
                                                        height: 40,
                                                        decoration: BoxDecoration(
                                                            color: Color(0xFF00B140),
                                                            borderRadius: BorderRadius.circular(12)
                                                        ),
                                                        alignment: Alignment.center,
                                                        child:const Text("add rejected",style: TextStyle(
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
                                      child:const Text("rejected",style: TextStyle(color: Colors.red,),),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
            ),
          ],
        ),
      ),
    );
  }
}
