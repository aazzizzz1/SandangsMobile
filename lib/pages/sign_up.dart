import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sandangs/constant.dart';
import 'package:sandangs/widget/authentication/auth_service.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool hidePassword = true;
  bool hidePasswordConfirm = true;
  final _username = TextEditingController();
  final _email = TextEditingController();
  final _pass = TextEditingController();
  final _passConfirm = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  User? user;

  Future register() async {
    final response = await http.post(Uri.parse("https://fashionizt.yufagency.com/signup.php"), body: {
      "username": _username.text,
      "email": _email.text,
      "password": _pass.text,
      "cpassword" : _passConfirm.text,
      "level" : "Customer",
    });

    var data = json.decode(response.body);
    if (data == "Blank") {
      print('Data Blank');
    } else if (data == "Error") {
      print('User already exist');
    } else if (data == "Wrong Password") {
      print('Password doesnt Match');
    } else {
      print('Registration succesfull');
    }
  }

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
                      'Sign Up',
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
                        children: [
                          TextFormField(
                            controller: _username,
                            cursorColor: secondaryColor,
                            style: TextStyle(color: secondaryColor),
                            showCursor: true,
                            keyboardType: TextInputType.text,
                            decoration: customFormInputUsername,
                            validator: (value){
                              if(value == null || value.isEmpty){
                                return 'Silahkan masukkan username anda';
                              }else if(value.contains(' ')){
                                return 'Masukkan username tanpa spasi';
                              }
                            },
                          ),
                          TextFormField(
                            controller: _email,
                            cursorColor: secondaryColor,
                            style: TextStyle(color: secondaryColor),
                            showCursor: true,
                            keyboardType: TextInputType.emailAddress,
                            decoration: customFormInputEmail,
                            validator: (value){
                              if(value == null || value.isEmpty){
                                return 'Silahkan masukkan email anda';
                              }
                            },
                          ),
                          TextFormField(
                            controller: _pass,
                            cursorColor: secondaryColor,
                            style: TextStyle(color: secondaryColor),
                            showCursor: true,
                            keyboardType: TextInputType.text,
                            obscureText: hidePassword,
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
                            validator: (value){
                              if(value == null || value.isEmpty){
                                return 'Silahkan Masukkan password anda';
                              }else if(value.length < 8){
                                return 'Harus terdiri dari 8 karakter atau lebih';
                              }
                            },
                          ),
                          TextFormField(
                            controller: _passConfirm,
                            cursorColor: secondaryColor,
                            style: TextStyle(color: secondaryColor),
                            showCursor: true,
                            keyboardType: TextInputType.text,
                            obscureText: hidePasswordConfirm,
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: secondaryColor),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: secondaryColor, width: 2),
                              ),
                              labelText: "Confirm Password",
                              labelStyle: TextStyle(
                                color: secondaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    hidePasswordConfirm = !hidePasswordConfirm;
                                  });
                                },
                                color: secondaryColor.withOpacity(0.4),
                                icon: Icon(hidePasswordConfirm
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                              ),
                            ),
                            validator: (value){
                              if(value == null || value.isEmpty){
                                return 'Silahkan masukkan password anda';
                              }
                              if(value != _pass.text){
                                return 'Password tidak sama';
                              }
                            },
                          ),

                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
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
                                    user = await AuthService().createUser(email: _email.text, password: _pass.text);
                                    if(user!=null){
                                      register();
                                    }
                                  } finally{
                                    if(user != null){
                                      Fluttertoast.showToast(
                                        msg: "Sign Up Successfull, check your email for the next step",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.TOP,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.white,
                                        fontSize: 15,
                                        textColor: secondaryColor,
                                      );
                                      AuthService().verifyEmail();
                                      Navigator.pop(context);
                                    } else{
                                      Fluttertoast.showToast(
                                        msg: "this account already exist",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.TOP,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.white,
                                        fontSize: 15,
                                        textColor: secondaryColor,
                                      );
                                    }
                                  }
                                }
                              },
                              child: const Text('Sign Up'),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          Stack(
                            children: [
                              Divider(
                                height: 25,
                                thickness: 2,
                                indent: 0,
                                endIndent: size.width*0.45,
                              ),
                              Center(
                                child: Text(
                                  'or',
                                  style: TextStyle(
                                    color: secondaryColor,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Divider(
                                height: 25,
                                thickness: 2,
                                indent: size.width*0.45,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          Container(
                            width: size.width-80,
                            margin: EdgeInsets.symmetric(vertical: 5),
                            child: OutlinedButton(
                              onPressed: (){},
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                padding: const EdgeInsets.all(5.0),
                                primary: secondaryColor,
                                backgroundColor: Colors.white,
                                shadowColor: secondaryColor,
                                textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins'
                                ),
                                side: BorderSide(
                                  color: secondaryColor,
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                'Sign Up as Desainer / konveksi',
                              ),
                            ),
                          ),

                          Container(
                            height: MediaQuery.of(context).size.height * 0.11,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Already have an account?",
                                style: TextStyle(color: secondaryColor),
                              ),
                              GestureDetector(
                                onTap: (){
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  " Login",
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