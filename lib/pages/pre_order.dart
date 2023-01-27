import 'dart:convert';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sandangs/api/api_project_order.dart';
import 'package:sandangs/constant.dart';
import 'package:sandangs/models/project_model.dart';
import 'package:sandangs/pages/detail_project.dart';
import 'package:sandangs/pages/home_page.dart';
import 'package:sandangs/variables.dart';
import 'package:sandangs/widget/card/project_card.dart';
import 'package:http/http.dart' as http;
import '../widget/bottom_menu/bottom_menu.dart';

class PreOrder extends StatefulWidget {
  const PreOrder({Key? key}) : super(key: key);

  @override
  State<PreOrder> createState() => _PreOrderState();
}

class _PreOrderState extends State<PreOrder> with SingleTickerProviderStateMixin{
  File? _file;
  PlatformFile? _platformFile;
  late AnimationController loadingController;
  late Future<Project> projectApi;
  final _formKey = GlobalKey<FormState>();
  final _judul = new TextEditingController();
  final _kebutuhan = new TextEditingController();
  final _biaya = new TextEditingController();
  final _jumlah = new TextEditingController();

  @override
  void initState() {
    loadingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() { setState(() {}); });
    projectApi = ApiServiceProject().topHeadlines();
    super.initState();
    print(idUserGlob);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded),
            color: secondaryColor,
            onPressed: (){
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    child: AlertDialog(
                      title: Text('Keluar'),
                      content: Text('Anda yakin ingin meninggalkan page ini?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('CANCEL', style: TextStyle(
                              color: secondaryColor
                          ),),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => BottomMenu(currentTab: 0,currentScreen: HomePages()))
                            );
                          },
                          child: Text('YES',
                            style: TextStyle(
                                color: Colors.red
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
          title: Text(
            "Pre Order",
            style: tittleDark,
          ),
          bottom: TabBar(
            indicatorColor: secondaryColor,
            labelColor: secondaryColor,
            tabs: <Widget>[
              Tab(
                child: Text(
                  "Form",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "Riwayat",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            SingleChildScrollView(
              padding: EdgeInsets.only(left: 20,right: 20,top: 10),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Judul',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Masukkan judul project anda",
                      ),
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return 'Silahkan masukkan judul projek';
                        }else if(value.contains("'") || value.contains('"')){
                          return "Judul tidak boleh ada symbol petik";
                        }
                      },
                      maxLength: 25,
                      maxLines: 1,
                      controller: _judul,
                    ),
                    Text(
                      'Spesifikasi Busana',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Masukkan kebutuhan busana anda disini ...",
                      ),
                      maxLength: 255,
                      maxLines: 4,
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return 'Silahkan masukkan spesifikasi busana';
                        }else if(value.contains("'") || value.contains('"')){
                          return "Spesifikasi tidak boleh ada symbol petik";
                        }
                      },
                      controller: _kebutuhan,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Budget',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: "Rp. xxxxxx",
                                  border: OutlineInputBorder(),
                                ),
                                maxLines: 1,
                                keyboardType: TextInputType.number,
                                validator: (value){
                                  if(value == null || value.isEmpty){
                                    return 'budget projek  kosong';
                                  }else if(value.contains(".") || value.contains(',')){
                                    return "budget tanpa koma/titik";
                                  }
                                },
                                controller: _biaya,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 110,
                          margin: EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Jumlah',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: "xxx pcs",
                                  border: OutlineInputBorder(),
                                ),
                                maxLines: 1,
                                keyboardType: TextInputType.number,
                                validator: (value){
                                  if(value == null || value.isEmpty){
                                    return 'kosong';
                                  }else if(value.contains(".") || value.contains(',')){
                                    return "tanpa ' . ' / ' , '";
                                  }
                                },
                                controller: _jumlah,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Lampiran',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: selectFile,
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: Radius.circular(6),
                            dashPattern: [10, 4],
                            strokeCap: StrokeCap.round,
                            color: Colors.blue.shade400,
                            child: Container(
                              width: double.infinity,
                              height: 100,
                              decoration: BoxDecoration(
                                  color: Colors.blue.shade50.withOpacity(.3),
                                  borderRadius: BorderRadius.circular(6)
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.folder_open, color: Colors.blue, size: 40,),
                                  SizedBox(height: 15,),
                                  Text('Tambahkan File Desain Anda', style: TextStyle(fontSize: 15, color: Colors.grey.shade400),),
                                ],
                              ),
                            ),
                          )
                      ),
                    ),
                    _platformFile != null
                        ? Container(
                        padding: EdgeInsets.all(5),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Desain Anda',
                                style: TextStyle(color: Colors.grey.shade600, fontSize: 15, ),),
                              SizedBox(height: 10,),
                              Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.shade200,
                                          offset: Offset(0, 1),
                                          blurRadius: 3,
                                          spreadRadius: 2,
                                        )
                                      ]
                                  ),
                                  child: Row(
                                      children: [
                                        ClipRRect(
                                            borderRadius: BorderRadius.circular(6),
                                            child: Image.file(_file!, width: 70,)
                                        ),
                                        SizedBox(width: 10,),
                                        Expanded(
                                            child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(_platformFile!.name,
                                                    style: TextStyle(fontSize: 13, color: Colors.black),),
                                                  SizedBox(height: 5,),
                                                  Text('${(_platformFile!.size / 1024).ceil()} KB',
                                                    style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
                                                  ),
                                                  SizedBox(height: 5,),
                                                  Container(
                                                    height: 5,
                                                    clipBehavior: Clip.hardEdge,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(6),
                                                      color: Colors.blue.shade50,
                                                    ),
                                                    child: LinearProgressIndicator(
                                                      value: loadingController.value,
                                                    ),
                                                  ),
                                                ]
                                            )
                                        )
                                      ]
                                  )
                              )
                            ]
                        )
                    ): SizedBox(height: 10),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      height: 40,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [thirdColor,secondaryColor],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextButton(
                        onPressed: (){
                          if(_formKey.currentState!.validate()){
                            print(_kebutuhan.text);
                            submit();
                          }
                        },
                        child: Center(
                          child: Text("Submit", style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.only(top: 5),
                child: FutureBuilder(
                  future: projectApi,
                  builder: (context, AsyncSnapshot<Project> snapshot) {
                    var state = snapshot.connectionState;
                    if (state != ConnectionState.done) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data?.project.length,
                          itemBuilder: (context, index) {
                            var project = snapshot.data?.project[index];
                            return InkWell(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                        return DetailProject(project: project!);
                                        // return DetailProjectUser(project :project!);
                                      }));
                                },
                                child: CardProject(project: project!)
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * 0.5,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage('lib/assets/images/empty-preorder.png'),
                                ),
                              ),
                            ),
                            Text(
                              'Pre-Order Is Empty',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: secondaryColor,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Sepertinya anda belum melakukan Pre Order sama sekali',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                          ],
                        );
                      } else {
                        return Text('');
                      }
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  selectFile() async {
    final file = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['png', 'jpg', 'jpeg', 'pdf']
    );

    if (file != null) {
      setState(() {
        _file = File(file.files.single.path!);
        _platformFile = file.files.first;
      });
    } else {
      print('no image selected');
    }
    loadingController.forward();
  }

  Future submit() async {
    final uri = Uri.parse("https://fashionizt.yufagency.com/order.php");
    var request = http.MultipartRequest('POST',uri);
    request.fields['judul'] = _judul.text;
    request.fields['kebutuhan'] = _kebutuhan.text;
    request.fields['biaya'] = _biaya.text;
    request.fields['id_user'] = idUserGlob ;
    var pic = await http.MultipartFile.fromPath('lampiran', _file!.path);
    request.files.add(pic);
    showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        }
    );

    await request.send().then((result) {
      http.Response.fromStream(result).then((response) {
        var message = jsonDecode(response.body);
        if (message == "Error") {
          Navigator.pop(context);
          Fluttertoast.showToast(
            msg: "Data Input Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            fontSize: 15,
            textColor: secondaryColor,
          );
          Navigator.push(context,
              MaterialPageRoute(builder: (context) {
                return PreOrder();
              })
          );
        } else if (message == "Blank")  {
          Navigator.pop(context);
          Fluttertoast.showToast(
            msg: "Please Fill Out The Entire Form",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            fontSize: 15,
            textColor: secondaryColor,
          );
          Navigator.push(context,
              MaterialPageRoute(builder: (context) {
                return PreOrder();
              })
          );
        } else {
          Navigator.pop(context);
          Fluttertoast.showToast(
            msg: "Preorder Successful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            fontSize: 15,
            textColor: secondaryColor,
          );
          Navigator.push(context,
              MaterialPageRoute(builder: (context) {
                return PreOrder();
              })
          );
        }
      });
    }).catchError((e) {
      print(e);
    });
  }
}

