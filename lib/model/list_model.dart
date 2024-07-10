
class ListModel {
  int id;
  String product;
  List<Map<String, dynamic>>? variants;

// List<Map<String, dynamic>>? images;
  Map<String, dynamic>? image2;
  String srcname;

  ListModel(
      {required this.id,
      required this.product,
      required this.variants,
      // required this.images,
      required this.image2,
      required this.srcname
      //required this.variants,
      //required this.options, required this. images
      });

  factory ListModel.fromJson(Map<String, dynamic> json) {

    int id = json['id'];
    String product = json['title'] ?? '';
    var data = json['variants'] as List;
    // List<Map<String, dynamic>> variants = json['variants'];
    List<Map<String, dynamic>> variantList = [];
    for (var d in data) {
      Map<String, dynamic> map = <String, dynamic>{};
      map['title'] = d['title'];
      map['price'] = d['price'];

      variantList.add(map);
    }
//   var imagedata= json['images'] as List;
//   List<Map<String,dynamic>> imageList=[];
//   for(var img in imagedata){
//     Map<String, dynamic> imgmap=<String,dynamic>{};
//     imgmap['src']= img['src'];
//     imageList.add(imgmap);
//   }
    Map<String, dynamic> image2 = json['image'] ?? {};
    String srcname = image2['src'] ?? '';
    return ListModel(
        id: id,
        product: product,
        variants: variantList,
        // images: imageList,
        image2: image2,
        srcname: srcname
        //    variants: variants
        );
  }
}
