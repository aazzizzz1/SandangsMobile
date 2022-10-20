import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sandangs/models/desainer_model.dart';

class ApiServiceDesainer{
  Future<Desainer> topHeadLines() async {
    final response = await http.get(
      Uri.parse('https://api.yufagency.com/desainer')
    );
    if(response.statusCode == 200){
      return Desainer.fromJson(json.decode(response.body));
    }else{
      throw Exception('Failed to load top headlines');
    }
  }
}