class Kategori{
  String name;
  String img;
  String id;

  Kategori({
    required this.name,
    required this.img,
    required this.id
  });
}

var kategoriList = [
  Kategori(
    id : '1',
    name : 'Kemeja',
    img : 'lib/assets/images/kemeja.png',
  ),
  Kategori(
    id : '6',
    name : 'Kaos',
    img : 'lib/assets/images/kaos.png',
  ),
  Kategori(
    id : '5',
    name : 'Jaket',
    img : 'lib/assets/images/jaket.png',
  ),
  Kategori(
    id : '3',
    name : 'Celana',
    img : 'lib/assets/images/celana.png',
  ),
  Kategori(
    id : '2',
    name : 'Rok',
    img : 'lib/assets/images/rok.png',
  ),
  Kategori(
    id : '7',
    name : 'Jeans',
    img : 'lib/assets/images/jeans.png',
  ),
];