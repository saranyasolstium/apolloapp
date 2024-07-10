import 'package:get/get.dart';

import '../../utils/packeages.dart';

class SearchControllers extends GetxController {
 
  int? collectionID = 0;
  List<ProductModel> myProductList = [];
  TextEditingController controller2 = TextEditingController();
  List<String> titleList = [];
  String title = '';
  List<ProductModel> list = [];
  int tap = -1;
  int j = 0;
  int s = 0;
  String? category;

  @override
  void onInit() {
    loading = true;

    //getProductList();
    super.onInit();
  }

  void getProductList() {
    try {
      String aUrl =
          "${EndPoints.allProductsList}?limit=250&collection_id=$collectionID&status=active";
      DioClient(myUrl: aUrl).getProductList().then((value) {
        if (value.isNotEmpty) {
          myProductList = [];
          myProductList = value;
          
          for (int i = 0; myProductList.length > i; i++) {
            title = myProductList[i].title.toString();
            titleList.add(myProductList[i].title.toString());
          }
        } else {
          myProductList = [];
        }
        loading = false;
        update();
      });
    } catch (e) {}
  }

  void filterSearchResults(String query) {
    list.clear();
    if (query.toLowerCase().length >= 3) {
      for (ProductModel model in myProductList) {
        if (model.title!.toLowerCase().contains(query.toLowerCase())) {
          print(model.title);
          list.add(model);
        }
      }
    }
    print(list.length);
    update();
  }
}
