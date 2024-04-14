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
  List profile=[];
  List requestData=[];
  List requestId=[];
  String update="";
  Map<String,dynamic>myProfile={};
  String subId="national_card";
  getProfile()async{
    await FirebaseFirestore.instance.collection("Profile").where("userType",isEqualTo: null).get().then((value) {
      profileId=[];
      profile=[];
      value.docs.forEach((element) {
        if(element.data()["userType"]==null){
        profile.add(element.data());
        profileId.add(element.id);}
      });
    });
    emit(ProfileState());
  }
  getMyProfile()async{
    emit(EmptyState());
    await FirebaseFirestore.instance.collection("Profile").doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) {
      myProfile=value.data()!;
    });
    emit(MyProfileState());
  }

  requestUpdateCardCubit(updae,myId)async{
    emit(EmptyState());
    await getMyProfile();
    await getProfile();
    update=updae;
    subId="national_card";
    var parent= FirebaseFirestore.instance.collection("Profile").get();
    parent.then((value){
      requestData=[];
      requestId=[];
      value.docs.forEach((element) {
        element.reference.collection("my_cards")
            .where("permission",isEqualTo:myId)
            .get().then((value){
              value.docs.forEach((element) {
                element.reference.collection("update")
                .where("status",isEqualTo:"pending")
                .get().then((value) {
              value.docs.forEach((element) {
                requestData.add(element.data());
                requestId.add(element.id);
                // print(element.data());
              });
            });
          });
        });
      });

    });
    emit(RequestUpdateCardState());
  }
  requestAddCardCubit(updae,myId)async{
    emit(EmptyState());
    await getProfile();
    update=updae;
    subId="national_card";
    var parent= FirebaseFirestore.instance.collection("Profile").get();
    parent.then((value){
      value.docs.forEach((element) {
        requestData=[];
        requestId=[];
        element.reference.collection("my_cards").where("status",isEqualTo: "pending")
            .where("permission",isEqualTo:myId).get().then((value){
          value.docs.forEach((element) {
            if(element.data()["permission"]==myId&&element.data()["status"]=="pending"){
              print(" $myId");
              print(" ${element.data()["permission"]}");
              requestData.add(element.data());
            requestId.add(element.id);}
            // print(element.data());
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
    await getProfile();
    update=updae;

    var parent= FirebaseFirestore.instance.collection("Profile").get();
    parent.then((value){
      requestData=[];
      requestId=[];
      value.docs.forEach((element) {
        element.reference.collection("my_family").get().then((value){
          value.docs.forEach((element) {
            if(element.data()["status"]=="in progress") {
              requestData.add(element.data());
              requestId.add(element.id);
              // print(element.data());
            }});
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
    await getProfile();
    var parent= FirebaseFirestore.instance.collection("Profile").get();
    parent.then((value){
      requestData=[];
      requestId=[];
      value.docs.forEach((element) {
        element.reference.collection("my_family_update").get().then((value){
          value.docs.forEach((element) {
            if(element.data()["status"]=="in progress") {
              requestData.add(element.data());
            requestId.add(element.id);
            // print(element.data());
            print(requestData);}
          });
        });
      });
    });
    emit(RequestUpdateFamilyState());
  }
  addAcptedData(id,data,edit,collection,doc)async{
    // requestData=[];
    // print(id);
    if(subId==""){
      if(update =="update"){
        await FirebaseFirestore.instance.collection("Profile")
            .doc(id).collection("my_family_update").doc(doc).update(data);
        FirebaseFirestore.instance.collection("Profile")
            .doc(id).collection("my_family").doc(doc).update(edit);
        FirebaseFirestore.instance.collection("Profile")
            .doc(id).collection("my_family").doc(doc).update(data);
      }
      else{
        FirebaseFirestore.instance.collection("Profile")
            .doc(id).collection("my_family").doc(doc).update(data);

        FirebaseFirestore.instance.collection("Profile")
            .doc(id).collection("my_family").doc(doc).update(edit);
      }
    }else{
      if(update =="update"){
        await FirebaseFirestore.instance.collection("Profile")
            .doc(id).collection(collection).doc(doc)
            .collection("update").doc("update").update(data);
        FirebaseFirestore.instance.collection("Profile")
            .doc(id).collection("my_cards").doc(doc).update(edit);
        FirebaseFirestore.instance.collection("Profile")
            .doc(id).collection("my_cards").doc(doc).update(data);
      }
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
        await FirebaseFirestore.instance.collection("Profile")
            .doc(id).collection("rejected")
            .add(data);
      }
      else{
        FirebaseFirestore.instance.collection("Profile")
            .doc(id).collection("my_family").doc(doc).update(data);
        await FirebaseFirestore.instance.collection("Profile")
            .doc(id).collection("rejected")
            .add(data);
      }
    }else{
      if(update =="update"){
        await FirebaseFirestore.instance.collection("Profile")
            .doc(id).collection(collection).doc(doc)
            .collection("update").doc("update").update(data);
        await FirebaseFirestore.instance.collection("Profile")
            .doc(id).collection("rejected")
            .add(data);
      }
      else{
        FirebaseFirestore.instance.collection("Profile")
            .doc(id).collection(collection).doc(doc).update(data);
        await FirebaseFirestore.instance.collection("Profile")
            .doc(id).collection("rejected")
            .add(data);
      }
    }
  }
}