import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sandangs/pages/login.dart';
import 'package:sandangs/widget/bottom_menu/bottom_menu.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {

    setState(() {
      Timer(
        const Duration(seconds: 3),
          () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context){
                    if(FirebaseAuth.instance.currentUser != null && FirebaseAuth.instance.currentUser!.emailVerified){
                      return const BottomMenu();
                    }else{
                      return const LoginScreen();
                    }
                  }
              ),
          )
      );
    });
    return Scaffold(
      body: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/assets/images/splash.png',
              width: 300,
              height: 300,
            ),
          ],
        ),
      ),
    );
  }
}