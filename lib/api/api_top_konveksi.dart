import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:sandangs/models/konveksi_model.dart';

class ApiServiceTopKonveksi{
  Future<Konveksi> topHeadLines() async{
    final response = await http.get(
        Uri.parse('https://api.yufagency.com/konveksi_desc_rating')
    );

    if(response.statusCode == 200){
      return Konveksi.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failer to load top headlines');
    }
  }
}