import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sandangs/constant.dart';
import 'package:another_stepper/another_stepper.dart';

class TrackOrder extends StatefulWidget {
  const TrackOrder({Key? key}) : super(key: key);

  @override
  State<TrackOrder> createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  bool _allProduction= false;
  bool _allTracking= false;

  List<StepperData> stepperProduction = [
    StepperData(
        title: StepperText("Di jahit", textStyle: TextStyle(
          color: secondaryColor,
        )),
        subtitle: StepperText("Pesanan anda sedang dalam proses penjahitan")),
    StepperData(
        title: StepperText("Di sablon", textStyle: const TextStyle(
          color: Colors.grey,
        )),
        subtitle: StepperText("Pesanan anda sedang dalam proses penyablonan")),
    StepperData(
        title: StepperText("Packing", textStyle: const TextStyle(
          color: Colors.grey,
        )),
        subtitle: StepperText(
            "Pesanan anda sedang dipacking")),
  ];

  List<StepperData> stepperTracking = [
    StepperData(
        title: StepperText("Pesanan anda telah di pickup oleh kurir", textStyle: TextStyle(
          color: secondaryColor,
        )),
    ),
    StepperData(
      title: StepperText("Pesanan anda telah dikirim dari gudang sortir", textStyle: const TextStyle(
        color: Colors.grey,)),
    ),
    StepperData(
        title: StepperText("Pesanan anda dalam proses pengiriman menuju lokasi oleh kurir ", textStyle: const TextStyle(
          color: Colors.grey,))
    ),
    StepperData(
      title: StepperText("Pesanan anda telah sampai tujuan ", textStyle: const TextStyle(
        color: Colors.grey,)),
    ),
  ];


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          color: secondaryColor,
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Track Order',
          style: tittleDark,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: 40,
                  child: Row(
                    children: [
                      Text(
                        'Order ID : ',
                        style: TextStyle(
                          color: blackColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "#1287632",
                        style: TextStyle(
                          color: blackColor,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)
                ),
                child: _allProduction == false ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Production',
                              style: TextStyle(
                                color: blackColor,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        child: Icon(
                          Icons.arrow_drop_down,
                          color: secondaryColor,
                          size: 40,
                        ),
                        onTap: (){
                          setState(() {
                            _allProduction = true;
                          });
                        },
                      )
                    ],
                  ),
                ) : Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: 280,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Production',
                                  style: TextStyle(
                                    color: blackColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            child: _allProduction == false ? Icon(
                              Icons.arrow_drop_down,
                              color: secondaryColor,
                              size: 40,
                            ) : Icon(
                              Icons.arrow_drop_up,
                              color: secondaryColor,
                              size: 40,
                            ),
                            onTap: (){
                              setState(() {
                                _allProduction = false;
                              });
                            },
                          )
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5),
                          child: AnotherStepper(
                            activeBarColor: secondaryColor,
                            inActiveBarColor: Colors.grey,
                            stepperList: stepperProduction,
                            stepperDirection: Axis.vertical,
                            inverted: false,
                            activeIndex: 0,
                            gap: 30,
                          ),
                      ),
                    ],
                  ),
                ) ,
              ),
              Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)
                ),
                child: _allTracking == false ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Tracking',
                              style: TextStyle(
                                color: blackColor,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        child: Icon(
                          Icons.arrow_drop_down,
                          color: secondaryColor,
                          size: 40,
                        ),
                        onTap: (){
                          setState(() {
                            _allTracking = true;
                          });
                        },
                      )
                    ],
                  ),
                ) : Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: 280,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Tracking',
                                  style: TextStyle(
                                    color: blackColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            child: _allTracking == false ? Icon(
                              Icons.arrow_drop_down,
                              color: secondaryColor,
                              size: 40,
                            ) : Icon(
                              Icons.arrow_drop_up,
                              color: secondaryColor,
                              size: 40,
                            ),
                            onTap: (){
                              setState(() {
                                _allTracking = false;
                              });
                            },
                          )
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        child: AnotherStepper(
                          activeBarColor: secondaryColor,
                          inActiveBarColor: Colors.grey,
                          stepperList: stepperTracking,
                          stepperDirection: Axis.vertical,
                          inverted: false,
                          activeIndex: 0,
                          gap: 20,
                        ),
                      ),
                    ],
                  ),
                ) ,
              ),
            ],
          ),
        ),
      ),
    );
  }
}