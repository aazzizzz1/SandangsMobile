import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sandangs/models/produk_model.dart';

class ApiServiceProduct{
  Future<Produk> topHeadLines() async {
    final response = await http.get(
        Uri.parse('https://api.yufagency.com/produk_desc_rating')
    );

    if(response.statusCode == 200){
      return Produk.fromJson(json.decode(response.body));
    }else{
      throw Exception('Failed to load top Headlines');
    }
  }
}