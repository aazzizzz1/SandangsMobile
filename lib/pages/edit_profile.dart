import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sandangs/constant.dart';
import 'package:sandangs/models/user_model.dart';
import 'package:sandangs/pages/my_profile.dart';
import 'package:sandangs/widget/bottom_menu/bottom_menu.dart';
import 'dart:io';
import 'dart:async';


import 'package:sandangs/widget/db_helper/db_user.dart';

class EditMyProfile extends StatefulWidget {
  const EditMyProfile({Key? key}) : super(key: key);

  @override
  State<EditMyProfile> createState() => _EditMyProfileState();
}

class _EditMyProfileState extends State<EditMyProfile> {
  File? image;
  final username = TextEditingController();
  final email = TextEditingController();
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  DbHelperUser db = DbHelperUser();
  List<UserList> listUser = [];

  @override
  void initState(){
    _getUser();
    super.initState();
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if(image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          color: secondaryColor,
          onPressed: (){Navigator.pop(context);},
        ),
        title: Text(
          'Edit Profile',
          style: tittleDark,
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: size.height*0.5,
              child: Stack(
                  children : [
                    Image(
                      image: AssetImage('lib/assets/images/bg-profile.jpg'),
                      fit: BoxFit.cover,
                      height: size.height*0.25,
                      width: size.width,
                    ),
                  ]
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: size.height*0.2),
              width: size.width,
              height: MediaQuery.of(context).size.height * 0.68,
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(
                  blurRadius: 1,
                  color: Colors.grey,
                )],
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                ),
                color: Colors.white,
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15
                    ),
                    margin: EdgeInsets.only(top: 60),
                    child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        key: globalFormKey,
                        children: [
                          TextFormField(
                              controller: username,
                              cursorColor: secondaryColor,
                              style: TextStyle(color: secondaryColor),
                              showCursor: true,
                              keyboardType: TextInputType.text,
                              decoration: customFormInputUsername.copyWith(labelText: "Username"),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 15
                            ),
                          ),
                          TextField(
                              cursorColor: secondaryColor,
                              style: TextStyle(color: secondaryColor),
                              showCursor: true,
                              decoration: customFormInputUsername.copyWith(labelText: "Nama"),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 15
                            ),
                          ),
                          TextFormField(
                              controller: email,
                              cursorColor: secondaryColor,
                              style: TextStyle(color: secondaryColor),
                              showCursor: true,
                              //cursorColor: mainColor,
                              keyboardType: TextInputType.text,
                              decoration: customFormInputUsername.copyWith(labelText: "Email"),
                          ),
                        ]
                    ),
                  ),
                  Container(
                    width: size.width-50,
                    height: 37,
                    margin: EdgeInsets.only(top:10, bottom: 30),
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
                            fontWeight:
                            FontWeight.w700,
                            fontFamily: 'Poppins'
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          updateUser();
                        });
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return BottomMenu(
                                  currentTab: 3,
                                  currentScreen: MyProfile(),
                              );
                            })
                        );},
                      child: Text('Save'),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                top: MediaQuery.of(context).size.height * 0.08,
                left: MediaQuery.of(context).size.width * 0.25,
                right: MediaQuery.of(context).size.width * 0.25,
                child: CircleAvatar(
                  radius: 88,
                  backgroundColor: const Color(0xFFFFFFFF),
                  child: CircleAvatar(
                    backgroundImage: AssetImage('lib/assets/images/profil.jpg'),
                    radius: 80,
                  ),
                )
            ),
            Positioned(
                top: MediaQuery.of(context).size.height * 0.22,
                right: MediaQuery.of(context).size.width * 0.22,
                child: RawMaterialButton(
                  onPressed: () {
                    pickImage();
                  },
                  elevation: 1.0,
                  fillColor: secondaryColor,
                  child: Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.white
                  ),
                  padding: EdgeInsets.all(15.0),
                  shape: CircleBorder(),
                )
            ),
          ],
        ),
      ),
    );
  }

  Future<void> updateUser() async{
    await db.updateUser(UserList.fromMap({
      'id' : listUser[0].id,
      'idUser' : listUser[0].idUser,
      'username' : username.text,
      'email' : email.text,
      'level' : listUser[0].level,
    }));
  }

  Future<void> _getUser() async {
    var list = await db.getUser();
    listUser.clear();
    setState(() {
      list!.forEach((user) {
        listUser.add(UserList.fromMap(user));
      });
    });
  }
}