import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tiranga/res/media_query.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiranga/generated/assets.dart';
import 'package:tiranga/res/aap_colors.dart';
import '../../utils/routes/routes_name.dart';

class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  State<splash> createState() => _loginState();
}

class _loginState extends State<splash> {
  @override
  void initState() {
    super.initState();
    harsh();
  }

  harsh() async{
    final prefs = await SharedPreferences.getInstance();
    final userid=prefs.getString("token")??'0';

    Timer(const Duration(seconds: 3),
            ()=>userid !='0'? Navigator.pushNamed(context, RoutesName.bottomNavBar)
            : Navigator.pushNamed(context, RoutesName.loginScreen)
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = ScreenSize.height(context);
    double width = ScreenSize.width(context);
    return SafeArea(
        child: Scaffold(
          body:Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: AppColors.primaryGradient,
            ),
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: height*0.4,
                  ),
                  Container(
                    height: height * 0.1,
                    width: width*0.5,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(Assets.imagesSplashImage),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height*0.05,
                  ),
                  // Text('Tiranga',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 25),)

                ],
              ),
            ),
          ),
        ));
  }
}

