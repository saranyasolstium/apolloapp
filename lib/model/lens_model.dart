class LensModel{
  int? id;
  String? title;
  LensModel({this.id, this.title});

  factory LensModel.fromJson(Map<String, dynamic> json){
    int id= json['id'];
    String title=json['title'];
    return LensModel(id: id,title: title);

  }
}