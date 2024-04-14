import 'package:flutter/material.dart';

import 'cubit/cubit.dart';

class RequestPage extends StatelessWidget {
  const RequestPage({super.key,required this.cubit,
    required this.requestType,
    required this.name,
    required this.national,
    required this.massegge,
    required this.image,
  });
    final String ? requestType;
    final String ? name;
    final String ? national;
    final String ? massegge;
    final String ? image;
    final MainCubit ? cubit;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: requestType!.isEmpty|| name!.isEmpty|| national!.isEmpty|| image!.isEmpty ? Center(child: CircularProgressIndicator(),) : SizedBox(
        height:800 ,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 500,
              width: 400,
              decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(image!),
                fit: BoxFit.cover
              ),
            ),),
            Padding(
              padding: const EdgeInsets.only(left: 600.0),
              child: Row(
                children: [
                  Text("name :",style: TextStyle(
                      color: Color(0xFF800f2f),
                      fontWeight: FontWeight.bold
                  ),),
                  Text("${name!}"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 600.0),
              child: Row(
                children: [
                  Text("request type:",style: TextStyle(
                      color: Color(0xFF800f2f),
                      fontWeight: FontWeight.bold
                  ),),
                  Text("${requestType!}"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 600.0),
              child: Row(
                children: [
                  Text("national id:",style: TextStyle(
                      color: Color(0xFF800f2f),
                      fontWeight: FontWeight.bold
                  ),),
                  Text("${national!}"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 600.0),
              child: Row(
                children: [
                  Text("massegge:",style: TextStyle(
                  color: Color(0xFF800f2f),
                  fontWeight: FontWeight.bold
              )),
                  Text(massegge!.isEmpty?"no masege":"${massegge!}"),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}