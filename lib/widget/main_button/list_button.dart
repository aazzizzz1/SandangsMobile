import 'package:sandangs/pages/desainer_explore.dart';
import 'package:sandangs/pages/konveksi_explore.dart';
import 'package:sandangs/pages/mall.dart';

class ListButton{
  List<Map<String, dynamic>> role = [
    {"icon" : "lib/assets/svg/desainer", "text" : "Desainer", "route" : DesainerExplore()},
    {"icon" : "lib/assets/svg/mall", "text" : "Mall", "route" : const Mall()},
    {"icon" : "lib/assets/svg/konveksi", "text" : "Konveksi", "route" : KonveksiExplore()},
  ];
}