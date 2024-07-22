// ignore_for_file: library_private_types_in_public_api


import 'package:flutter/material.dart';
import 'package:tiranga/generated/assets.dart';
import 'package:tiranga/main.dart';
import 'package:tiranga/res/app_constant.dart';
import 'package:tiranga/view/AndarBahar/AndarBaharassets.dart';

class AndarbaharLoading extends StatefulWidget {
  final int time;
  const AndarbaharLoading({super.key,  required this.time});

  @override
  _AndarbaharLoadingState createState() => _AndarbaharLoadingState();
}

class _AndarbaharLoadingState extends State<AndarbaharLoading> {
  int waitingTimeSeconds = 30;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
       image: DecorationImage(
         image: AssetImage(Assets.imagesAdornGift),
           fit: BoxFit.fill,
           ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Image.asset(AndarAssets.andarbaharLoading,height: height*0.40,),
            SizedBox(height: height*0.02,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xffea0b3e), width: 1),
                  ),
                  child: LinearProgressIndicator(
                    value: 1 - (widget.time / waitingTimeSeconds),
                    backgroundColor: Colors.grey,
                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xffea0b3e)),
                    minHeight: 6,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Text(
                  '  ${(100 - ((widget.time / waitingTimeSeconds) * 100)).toStringAsFixed(0)}%',
                  style: TextStyle(
                      fontSize: width*0.02,
                      color: Colors.white
                  ),
                ),
                // Text(' ${_linearProgressAnimation.value.toStringAsFixed(2)}%',style: TextStyle(color: Colors.white),),
              ],
            ),
            SizedBox(height: height*0.02,),
            Text(
              "${AppConstants.headTail} is a verifiable 100% ${AppConstants.appName}",
              style: TextStyle(
                  fontSize: width*0.02,
                  color: Colors.white
              ),
            )
          ],
        ),
      ),
    );
  }
}