class BookCartModel{
  int? id;
  int? productId;
  int? variantId;
  String? productName;
  String? productType;
  String? variantName;
  double? price;
  int? quantity;
  double? total;
  String? imageUrl;


  String? trialRequestType;
  String? clinicName;
  String? clientName;
  int? mobile;
  String? mail;
  String? houseNo;
  String? location;
  int? pincode;
  String? addressType;
  String? appointmentDate;
  String? appointmentTime;

  String? createdAt;
  String? updatedAt;


  BookCartModel({this.id, this.productId, this.variantId,this.variantName, this.productName, this.productType, this.price,
      this.quantity, this.total, this.imageUrl, this.trialRequestType, this.clientName, this.clinicName, this.mobile, this.mail,
      this.houseNo, this.location, this.pincode, this.addressType,
      this.appointmentDate, this.appointmentTime, this.createdAt, this.updatedAt
  }
      );
  factory BookCartModel.fromJson(Map<String, dynamic> json) {
    int id= json['id'];
    int productId = json['product_id3'];
    int variantId = json['variant_id3'];
    String productName = json['product_name3'];
    String productType = json['product_type3'];
    String variantName = json['variant_name3'];
    double price = json['price3'];
    int quantity = json['quantity3'];
    double total = json['total3'];
    String imageUrl = json['image_url3'];

    String trialRequestType = json['trial_request_type'];
    String clientName = json['client_name'];
    String clinicName = json['clinic_name'];
    int mobile = json['mobile'];
    String mail = json['mail'];
    String houseNo = json['house_no'];
    String location = json['location'];
    int pincode=json['pincode'];
    String addressType = json['address_type'];
    String appointmentDate = json['appointment_time'];
    String appointmentTime = json['appointment_date'];
    String createdAt =json['created_at'];
    String updatedAt =json['updated_at'];

    return BookCartModel(id:id, productId:productId, variantId:variantId, variantName:variantName,
        productName:productName, productType:productType, price:price, quantity:quantity, total:total,
        imageUrl:imageUrl,
        trialRequestType:trialRequestType, clientName:clientName,
        clinicName:clinicName, mobile:mobile, mail:mail, houseNo:houseNo, location:location, pincode:pincode,
        addressType:addressType, appointmentDate:appointmentDate, appointmentTime:appointmentTime,
         createdAt: createdAt, updatedAt: updatedAt
    );
  }


}