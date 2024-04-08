import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'state.dart';
//     "Insurance",
//     "Ministry of Interior",
class MainCubit extends Cubit<MainState> {
  MainCubit() : super(InitMainState());
  static MainCubit get(context) => BlocProvider.of(context);
  List profileId=[];
  List requestData=[];
  List requestId=[];
  String update="";
  Map<String,dynamic>myProfile={};
  String subId="national_card";
  getProfile()async{
    await FirebaseFirestore.instance.collection("Profile").get().then((value) {
      value.docs.forEach((element) {
        profileId.add(element.id);
      });
    });
    emit(ProfileState());
  }
  getMyProfile()async{
    await FirebaseFirestore.instance.collection("Profile").doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) {
      myProfile=value.data()!;
    });
    emit(MyProfileState());
  }

  requestUpdateCardCubit(updae,myId)async{
    update=updae;
    subId="national_card";
    emit(EmptyState());
   var parent= FirebaseFirestore.instance.collection("Profile").get();
    parent.then((value){
      requestData=[];
      value.docs.forEach((element) {
        element.reference.collection("my_cards").where("permission",isEqualTo:myId)
            .get().then((value){
          value.docs.forEach((element) {
            element.reference.collection("update").get().then((value) {
              value.docs.forEach((element) {
                requestData.add(element.data());
                requestId.add(element.id);
                print("update card ${requestData}");
              });
            });
            // print(element.data());
          });
        });
     });

   });
    emit(RequestUpdateCardState());
  }
  requestAddCardCubit(updae,myId)async{
    emit(EmptyState());
    update=updae;
    subId="national_card";
    var parent= FirebaseFirestore.instance.collection("Profile").get();
    parent.then((value){
      requestData=[];
      value.docs.forEach((element) {
        element.reference.collection("my_cards")
            .where("permission",isEqualTo:myId).get().then((value){
          value.docs.forEach((element) {
            requestData.add(element.data());
            requestId.add(element.id);
            print("add card ${element.data()}");
          });
        });
      });
    });
    // print(requestData);
    emit(RequestAddCardState());
  }
  requestAddFamilyCubit(updae)async{
    subId="";
    emit(EmptyState());
    update=updae;
    var parent= FirebaseFirestore.instance.collection("Profile").get();
    parent.then((value){
      requestData=[];
      value.docs.forEach((element) {
        element.reference.collection("my_family").get().then((value){
          value.docs.forEach((element) {
            requestData.add(element.data());
            requestId.add(element.id);
            print(" add family ${element.data()}");
          });
        });
      });

    });
    // print(requestData);
    emit(RequestAddFamilyState());
  }
  requestUpdateFamilyCubit(updae)async{
    emit(EmptyState());
    update=updae;
    subId="";
    var parent= FirebaseFirestore.instance.collection("Profile").get();
    parent.then((value){
      value.docs.forEach((element) {
        requestData=[];
        element.reference.collection("my_family_update").get().then((value){
          value.docs.forEach((element) {
            requestData.add(element.data());
            requestId.add(element.id);
            // print(element.data());
            print("update family ${requestData}");
          });
        });
      });
    });
    emit(RequestUpdateFamilyState());
  }
  addAcptedData(id,data,edit,collection,doc)async{
    requestData=[];
    // print(id);
    if(subId==""){
      if(update =="update"){
        await FirebaseFirestore.instance.collection("Profile")
            .doc(id).collection("my_family_update").doc(doc)
            .update(data);
        FirebaseFirestore.instance.collection("Profile")
            .doc(id).collection("my_family").doc(doc).update(data);}
      else{
        FirebaseFirestore.instance.collection("Profile")
            .doc(id).collection("my_family").doc(doc).update(data);
        FirebaseFirestore.instance.collection("Profile")
            .doc(id).collection("my_family").doc(doc).update(data);
      }
    }else{
      if(update =="update"){
        await FirebaseFirestore.instance.collection("Profile")
            .doc(id).collection(collection).doc(doc)
            .collection("update").doc("update").update(data);
        FirebaseFirestore.instance.collection("Profile")
            .doc(id).collection("my_cards").doc(doc).update(data);}
      else{
        FirebaseFirestore.instance.collection("Profile")
            .doc(id).collection(collection).doc(doc).update(data);
        FirebaseFirestore.instance.collection("Profile")
            .doc(id).collection("my_cards").doc(doc).update(data);
      }

    }
    emit(AddAcptedState());
  }
  addRegctedData(id,data,collection,doc)async{
    if(subId==""){
      if(update =="update"){
        await FirebaseFirestore.instance.collection("Profile")
            .doc(id).collection("my_family_update").doc(doc)
            .update(data);
      }
      else{
        FirebaseFirestore.instance.collection("Profile")
            .doc(id).collection("my_family").doc(doc).update(data);
      }
    }else{
      if(update =="update"){
        await FirebaseFirestore.instance.collection("Profile")
            .doc(id).collection(collection).doc(doc)
            .collection("update").doc("update").update(data);
      }
      else{
        FirebaseFirestore.instance.collection("Profile")
            .doc(id).collection(collection).doc(doc).update(data);
      }
  }
}
}