import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sandangs/models/produk_model.dart';

class ApiServiceKategori {
  ApiServiceKategori({
    required this.namaKategori,
  });

  String namaKategori;

  Future<Produk> topHeadlines() async {
    final response = await http.get(
        Uri.parse('https://api.yufagency.com/product_filter_category/$namaKategori'));
    if (response.statusCode == 200) {
      return Produk.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }
}