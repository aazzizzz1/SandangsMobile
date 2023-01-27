import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sandangs/pages/login.dart';
import 'package:sandangs/routes.dart';
import 'package:sandangs/widget/provider/cart_provider.dart';
import 'package:sandangs/widget/provider/fitting_room_provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FittingRoomProv()),
        ChangeNotifierProvider(create: (context) => KeranjangProv()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Poppins'
        ),
        initialRoute: splashRoute,
        routes: routes,
        builder: EasyLoading.init(),
        home: const LoginScreen(),
      ),
    );
  }
}

