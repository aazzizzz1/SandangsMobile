import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:sandangs/api/api_project_order.dart';
import 'package:sandangs/constant.dart';
import 'package:sandangs/models/project_model.dart';
import 'package:sandangs/widget/card/project_card.dart';

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

  @override
  void initState() {
    loadingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() { setState(() {}); });

    projectApi = ApiServiceProjectAll().topHeadlines();
    super.initState();
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
              Navigator.pop(context);
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
                        }
                      },
                      maxLength: 25,
                      maxLines: 1,
                      // controller: judul,
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
                        }
                      },
                      // controller: kebutuhan,
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
                                  }
                                },
                                // controller: budget,
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
                                    return 'jumlah kosong';
                                  }
                                },
                                // controller: budget,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
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
                    ): SizedBox(height: 5),
                    Container(
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
                            print('Haloo cuy');
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
                                        return Container();
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
                                  image: AssetImage('lib/Assets/images/empty_preorder.png'),
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
}

