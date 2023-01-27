import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sandangs/api/api_get_user.dart';
import 'package:sandangs/constant.dart';
import 'package:sandangs/pages/home_page.dart';
import 'package:sandangs/pages/sign_up.dart';
import 'package:sandangs/widget/authentication/auth_service.dart';
import 'package:sandangs/widget/authentication/shared_preferences.dart';
import 'package:sandangs/widget/bottom_menu/bottom_menu.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool hidePassword = true;
  final _email = TextEditingController();
  final _emailForgot = TextEditingController();
  final _pass = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  User? user;
  List? dataUser;
  final PrefServices _prefService = PrefServices();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Image(
              image: const AssetImage('lib/assets/images/bg-profile.jpg'),
              height: size.height*0.3,
              fit: BoxFit.cover,
            ),
            Container(
              margin: EdgeInsets.only(top: size.height*0.22),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                color: Colors.white,
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: secondaryColor,
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        // key: globalFormKey,
                        children: [
                          TextFormField(
                            controller: _email,
                            cursorColor: secondaryColor,
                            style: TextStyle(color: secondaryColor),
                            showCursor: true,
                            keyboardType: TextInputType.emailAddress,
                            decoration: customFormInputEmail,
                            validator: (value){
                              if(value == null || value.isEmpty){
                                return 'please input your email';
                              }
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _pass,
                            cursorColor: secondaryColor,
                            style: TextStyle(color: secondaryColor),
                            showCursor: true,
                            keyboardType: TextInputType.text,
                            obscureText: hidePassword,
                            validator: (value){
                              if(value == null || value.isEmpty){
                                return 'Silahkan masukkan password anda';
                              } else if(value.length < 8){
                                return 'Harus terdiri dari 8 karakter atau lebih';
                              }
                            },
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: secondaryColor),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: secondaryColor, width: 2),
                              ),
                              labelText: "Password",
                              labelStyle: TextStyle(
                                  color: secondaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    hidePassword = !hidePassword;
                                  });
                                },
                                color: secondaryColor.withOpacity(0.4),
                                icon: Icon(hidePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                              ),
                            ),
                          ),
                          Container(
                            width: size.width - 40,
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    showModalBottomSheet<void>(
                                      context: context,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(25),
                                          topRight: Radius.circular(25),
                                        ),
                                      ),
                                      isScrollControlled: true,
                                      builder: (context) {
                                        return Padding(
                                          padding: EdgeInsets.only(top: 20, right: 20,left: 20, bottom: MediaQuery.of(context).viewInsets.bottom),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Text(
                                                'Forgot Password',
                                                style: tittleDark,
                                              ),
                                              SizedBox(height: 10,),
                                              Text(
                                                "Masukkan email anda untuk pengiriman link reset password",
                                              ),
                                              SizedBox(height: 10,),
                                              TextFormField(
                                                decoration: InputDecoration(
                                                  hintText: "example@example.com",
                                                  border: OutlineInputBorder(),
                                                ),
                                                maxLines: 1,
                                                keyboardType: TextInputType.emailAddress,
                                                validator: (value){
                                                  if(value!.isEmpty){
                                                    return 'Please input your email';
                                                  }
                                                },
                                                controller: _emailForgot,
                                              ),
                                              Container(
                                                width: size.width-40,
                                                margin: EdgeInsets.symmetric(vertical: 20),
                                                height: 37,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [thirdColor,secondaryColor],
                                                    begin: Alignment.centerLeft,
                                                    end: Alignment.centerRight,
                                                  ),
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: TextButton(
                                                  onPressed: () async {
                                                    var status = await AuthService().checkEmail(email: _emailForgot.text);
                                                    if(status == true){
                                                      AuthService().resetPassword(_emailForgot.text);
                                                      Fluttertoast.showToast(
                                                        msg: "Please check your email to reset password",
                                                        toastLength: Toast.LENGTH_SHORT,
                                                        gravity: ToastGravity.TOP,
                                                        timeInSecForIosWeb: 1,
                                                        backgroundColor: Colors.white,
                                                        fontSize: 15,
                                                        textColor: secondaryColor,
                                                      );
                                                      Navigator.pop(context);
                                                    } else {
                                                      Fluttertoast.showToast(
                                                        msg: "Your email invalid or user not found",
                                                        toastLength: Toast.LENGTH_SHORT,
                                                        gravity: ToastGravity.TOP,
                                                        timeInSecForIosWeb: 1,
                                                        backgroundColor: Colors.white,
                                                        fontSize: 15,
                                                        textColor: secondaryColor,
                                                      );
                                                    }
                                                  },
                                                  child: Text(
                                                    'Reset Password',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Text(
                                    "Forgot password?",
                                    style: TextStyle(
                                        color: secondaryColor,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: size.width-80,
                                height: 37,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [thirdColor,secondaryColor],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.all(5.0),
                                    primary: Colors.white,
                                    shadowColor: Colors.black,
                                    textStyle: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Poppins'),
                                  ),
                                  onPressed: () async {
                                    if(_formKey.currentState!.validate()){
                                      try{
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return Center(child: CircularProgressIndicator());
                                            }
                                        );
                                        user = await AuthService().signIn(email: _email.text, password: _pass.text);
                                      } finally{
                                        if(user != null){
                                          if(user!.emailVerified){
                                            Fluttertoast.showToast(
                                              msg: "Login Successfull",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.TOP,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.white,
                                              fontSize: 15,
                                              textColor: secondaryColor,
                                            );
                                            dataUser = await ApiServiceGetUser().topHeadLines(email: _email.text);
                                            _prefService.createCache(dataUser!);

                                            Navigator.push(context,
                                                MaterialPageRoute(builder: (context) => BottomMenu(currentScreen: HomePages(),currentTab: 0,))
                                            );
                                          } else {
                                            Navigator.pop(context);
                                            Fluttertoast.showToast(
                                              msg: "Please verify your email first",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.TOP,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.white,
                                              fontSize: 15,
                                              textColor: secondaryColor,
                                            );
                                          }
                                        } else {
                                          Navigator.pop(context);
                                          Fluttertoast.showToast(
                                            msg: "Username or Password Incorrect",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.TOP,
                                            timeInSecForIosWeb: 3,
                                            backgroundColor: Colors.white,
                                            fontSize: 15,
                                            textColor: secondaryColor,
                                          );
                                        }
                                      }
                                    }
                                  },
                                  child: const Text('Login'),
                                ),
                              )
                            ], // <Widget>[]
                          ),

                          Container(
                            height: MediaQuery.of(context).size.height * 0.35,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Don't have an Account ?",
                                style: TextStyle(color: secondaryColor),
                              ),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                        return const SignUp();
                                      })
                                  );
                                },
                                child: Text(
                                  " Sign Up",
                                  style: TextStyle(
                                      color: secondaryColor,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              )
                            ], // <Widget>[]
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
