import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sandangs/models/project_model.dart';

class ApiServiceProjectAll{
  Future<Project> topHeadlines() async {
    final response = await http.post(
        Uri.parse('https://fashionizt.yufagency.com/projectlist.php'));
    if (response.statusCode == 200) {
      return Project.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }
}