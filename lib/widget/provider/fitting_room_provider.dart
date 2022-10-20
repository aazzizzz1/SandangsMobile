import 'package:flutter/cupertino.dart';

class FittingRoomProv with ChangeNotifier{
  int status = 0;
  int indexKategori = 0;
  int swap = 0;
  int fitur = 0;
  String busanaAtasan = "lib/assets/images/iconAtasan.png";
  String busanaBawahan = "lib/assets/images/iconBawahan.png";


  setBusana(String atas, String bawah){
    busanaAtasan = atas;
    busanaBawahan = bawah;
  }
  setFitur(int kode){
    fitur = kode;
  }
  setStatus(int kode){
    status = kode;
  }
  setSwap(int kode){
    swap = kode;
  }
  setIndexKategori(int index) => indexKategori = index;
  int getIndexKategori() => indexKategori;
  String getAtasan() => busanaAtasan;
  String getBawahan() => busanaBawahan;
  int getSwap() => swap;
  int getFitur() => fitur;
  int getStatus() => status;
}