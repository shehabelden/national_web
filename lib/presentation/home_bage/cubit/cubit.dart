import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'state.dart';
class MainCubit extends Cubit<MainState> {
  MainCubit() : super(InitMainState());
  static MainCubit get(context) => BlocProvider.of(context);
  List profileId=[];
  List profile=[];
  List requestDataCard=[];
  List requestDataFamily=[];
  List updateDataCard=[];
  List updateDataFamily=[];
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
    print(profile);
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
    emit(UpdateCardEmptyState());
    await getProfile();
    update=updae;
    subId="national_card";
    var parent= FirebaseFirestore.instance.collection("Profile").get();
    parent.then((value){
      updateDataCard=[];
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
                updateDataCard.add(element.data());
                requestId.add(element.id);
                // print(element.data());
              });
            });
          });
        });
      });

    });
    // await  FirebaseFirestore.instance.collectionGroup("update").where("permission",isEqualTo: myProfile["userType"]).get().then((value){
    //   updateDataCard=[];
    //   value.docs.forEach((element) {
    //
    //     if(element.data()["permission"]==myProfile["userType"]){
    //       updateDataCard.add(element.data());
    //       print(element.data());}
    //   });
    // });

    emit(RequestUpdateCardState());
  }
  requestAddCardCubit(updae,myId)async{
    emit(AddCardEmptyState());
    await getProfile();
    update=updae;
    subId="national_card";
    var parent= FirebaseFirestore.instance.collection("Profile").get();
    await FirebaseFirestore.instance.collectionGroup("my_cards").where("permission",isEqualTo: myProfile["userType"]).get().then((value){
      requestDataCard=[];
      value.docs.forEach((element) {

        if(element.data()["permission"]==myProfile["userType"]){
            requestDataCard.add(element.data());
        print(element.data());}
      });
    });
    // print(requestData);
    emit(RequestAddCardState());
  }
  requestAddFamilyCubit(updae)async{
    subId="";
    emit(AddFamilyEmptyState());
    await getProfile();
    update=updae;

    await FirebaseFirestore.instance.collectionGroup("my_family").get().then((value){
      requestDataFamily=[];
      value.docs.forEach((element) {
        if(element.data()["status"] !=null){
        requestDataFamily.add(element.data());
          print(element.data());
        }
      });
    });

    // var parent= FirebaseFirestore.instance.collection("Profile").get();
    // parent.then((value){
    //   requestDataFamily=[];
    //   requestId=[];
    //   value.docs.forEach((element) {
    //     element.reference.collection("my_family").get().then((value){
    //       value.docs.forEach((element) {
    //         if(element.data()["status"]=="in progress") {
    //           requestDataFamily.add(element.data());
    //           requestId.add(element.id);
    //           // print(element.data());
    //         }});
    //     });
    //   });
    //
    // });
    // print(requestData);
    emit(RequestAddFamilyState());
  }
  requestUpdateFamilyCubit(updae)async{
    emit(UpdateFamilyEmptyState());
    update=updae;
    subId="";
    await getProfile();
    await FirebaseFirestore.instance.collectionGroup("my_family_update").get().then((value){
      updateDataFamily=[];
      value.docs.forEach((element) {
        updateDataFamily.add(element.data());
        print(element.data());
      });
    });

    // var parent= FirebaseFirestore.instance.collection("Profile").get();
    // parent.then((value){
    //   updateDataFamily=[];
    //   requestId=[];
    //   value.docs.forEach((element) {
    //     element.reference.collection("my_family_update").get().then((value){
    //       value.docs.forEach((element) {
    //         if(element.data()["status"]=="in progress") {
    //           updateDataFamily.add(element.data());
    //         requestId.add(element.id);
    //         // print(element.data());
    //         print(updateDataFamily);}
    //       });
    //     });
    //   });
    // });
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