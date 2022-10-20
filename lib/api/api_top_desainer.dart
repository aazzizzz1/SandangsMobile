import 'dart:convert';
import 'package:sandangs/models/desainer_model.dart';
import 'package:http/http.dart'as http;

class ApiServiceTopDesainer{
  Future<Desainer> topHeadLines() async{
    final response = await http.get(
      Uri.parse('https://api.yufagency.com/desainer_desc_rating')
    );

    if(response.statusCode == 200){
      return Desainer.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failer to load top headlines');
    }
  }
}