import 'package:flutter/material.dart';
import 'package:sandangs/constant.dart';
import 'package:sandangs/pages/home_page.dart';
import 'package:sandangs/pages/pre_order.dart';
import 'package:sandangs/widget/authentication/shared_preferences.dart';
import 'package:sandangs/widget/bottom_menu/list_menu.dart';

class BottomMenu extends StatefulWidget {
  const BottomMenu({Key? key}) : super(key: key);

  @override
  State<BottomMenu> createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  final PageStorageBucket bucket = PageStorageBucket();
  ListMenu statusLayar = ListMenu(0, const HomePages());
  final PrefServices _prefService = PrefServices();

  @override
  void initState() {
    // TODO: implement initState
    _prefService.readCache().then((value) {
      var userData = value;
      print('username : ' + userData.username.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
      body: PageStorage(
        child: statusLayar.screens[statusLayar.currentTab],
        bucket: bucket,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [thirdColor,secondaryColor],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Image.asset(
            'lib/assets/images/logoWhite.png',
            height: 50,
            width: 50,
          ),
        ),
        onPressed: (){
          Navigator.push(
              (context),
              MaterialPageRoute(builder: (context) => const PreOrder())
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 5,
        elevation: 10,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: [
                  SizedBox(
                    width: size.width*0.2,
                    child: MaterialButton(
                      onPressed: () {
                        setState(() {
                          statusLayar.currentTab = 0;
                          statusLayar.screens[0];
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.home_filled,
                            color: statusLayar.currentTab == 0 ? primaryColor : Colors.grey,
                          ),
                          Text(
                            'Home',
                            style: TextStyle(
                              color: statusLayar.currentTab == 0 ? primaryColor : Colors.grey,
                              fontFamily: 'Poppins',
                              fontSize: 10,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width*0.2,
                    child: MaterialButton(
                      onPressed: () {
                        setState(() {
                          statusLayar.currentTab = 1;
                          statusLayar.screens[1];
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.event_note_rounded,
                            color: statusLayar.currentTab == 1 ? primaryColor : Colors.grey,
                          ),
                          Text(
                            'Project',
                            style: TextStyle(
                              color: statusLayar.currentTab == 1 ? primaryColor : Colors.grey,
                              fontFamily: 'Poppins',
                              fontSize: 10,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 25),
                width: size.width*0.2,
                alignment: Alignment.center,
                child: const Text(
                  'Pre Order',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: size.width*0.2,
                    child: MaterialButton(
                      onPressed: () {
                        setState(() {
                          statusLayar.currentTab = 2;
                          statusLayar.screens[2];
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.checkroom,
                            color: statusLayar.currentTab == 2 ? primaryColor : Colors.grey,
                          ),
                          Text(
                            'Room',
                            style: TextStyle(
                              color: statusLayar.currentTab == 2 ? primaryColor : Colors.grey,
                              fontFamily: 'Poppins',
                              fontSize: 10,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width*0.2,
                    child: MaterialButton(
                      minWidth: 10,
                      onPressed: () {
                        setState(() {
                          statusLayar.currentTab = 3;
                          statusLayar.screens[3];
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.account_circle,
                            color: statusLayar.currentTab == 3 ? primaryColor : Colors.grey,
                          ),
                          Text(
                            'Profile',
                            style: TextStyle(
                              color: statusLayar.currentTab == 3 ? primaryColor : Colors.grey,
                              fontFamily: 'Poppins',
                              fontSize: 10,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}