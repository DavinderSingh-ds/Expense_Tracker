class Categorymodel {
  int? id;
  String categoryname;
  String type;
  Categorymodel({this.id, required this.categoryname, required this.type});
  factory Categorymodel.fromdatabaseJson(Map<String, dynamic> data) =>
      Categorymodel(
          id: data['id'],
          categoryname: data['categoryname'],
          type: data['type']);
  Map<String, dynamic> todatabaseJson() =>
      // ignore: unnecessary_this
      {'id': this.id, 'categoryname': this.categoryname, 'type': this.type};
}
