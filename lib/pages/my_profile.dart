import 'package:flutter/material.dart';
import 'package:sandangs/constant.dart';
import 'package:sandangs/models/user_model.dart';
import 'package:sandangs/pages/login.dart';
import 'package:sandangs/widget/authentication/auth_service.dart';
import 'package:sandangs/widget/db_helper/db_user.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  List<UserList> listUser = [];
  DbHelperUser db = DbHelperUser();

  @override
  initState() {
    _getUser();
    super.initState();
  }

  void _launchURL(String _url) async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        title: Text(
          'My Profile',
          style: tittleDark,
        ),
        automaticallyImplyLeading: false,
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
              height: size.height*0.6,
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(
                  blurRadius: 2,
                  color: Colors.grey,
                )],
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                ),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height*0.11,
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        listUser.length == 1 ? listUser[0].username : 'Customer',
                        // 'Haidar',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 1, bottom: 1, right: 7, left: 7),
                        margin: EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          border: Border.all(color: secondaryColor),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          listUser.length == 1 ? listUser[0].level : 'Customer',
                          // 'Customer',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12.0,
                            color: secondaryColor,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                      Container(
                        width: size.width*0.5,
                        height: 37,
                        margin: EdgeInsets.symmetric(vertical: 10),
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
                          onPressed: () {},
                          child: const Text('Edit Profile'),
                        ),
                      ),
                      Container(
                        width: size.width-40,
                        height: 38,
                        margin: EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                          // border: Border.all(color: greyCustom),
                          boxShadow: [BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 3,
                          )]
                        ),
                        child: TextButton(
                          onPressed: (){
                            _launchURL('https://play.google.com/store/apps/details?id=com.fashionizt.cloths');
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.star,color: secondaryColor,size: 25,),
                              Text(
                                '  Beri Rating',
                                style: TextStyle(
                                  color: blackColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: size.width-40,
                        height: 38,
                        margin: EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                            // border: Border.all(color: greyCustom),
                            boxShadow: [BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 3,
                            )]
                        ),
                        child: TextButton(
                          onPressed: () {
                            Share.share(
                              'Yuk Customize busanamu dan temukan partnermu di Sandangs\n https://play.google.com/store/apps/details?id=com.fashionizt.cloths ',
                              subject: 'Sandangs Apps',
                            );
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.send,color: secondaryColor,size: 25,),
                              Text(
                                '  Undang Teman',
                                style: TextStyle(
                                  color: blackColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: size.width-40,
                        height: 38,
                        margin: EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                            // border: Border.all(color: greyCustom),
                            boxShadow: [BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 3,
                            )]
                        ),
                        child: TextButton(
                          onPressed: (){
                            AuthService.signOut();
                            _deleteUser();
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => const LoginScreen())
                            );
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.logout,color: Colors.red,size: 25,),
                              Text(
                                '  Log Out',
                                style: TextStyle(
                                  color: blackColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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

          ],
        ),
      ),
    );
  }

  Future<void> _getUser() async{
    var list = await db.getUser();
    listUser.clear();
    setState(() {
      list!.forEach((user) {
        listUser.add(UserList.fromMap(user));
      });
    });
  }

  Future<void> _deleteUser() async{
    await db.clearUser();
  }

}
