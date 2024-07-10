class ProductDetails{
  String title;

  ProductDetails(
  {required this.title

}
      );
  factory ProductDetails.fromJson(Map<String, dynamic> json) {
    String title=json['title']?? '';

    return ProductDetails(title: title);
  }
}