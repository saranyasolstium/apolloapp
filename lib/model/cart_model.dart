class CartModel {
  int? id;
  int? productId;
  int? frameId;
  int? bookId;
  int? addOnId;

  int? variantId;
  String? name;
  String? productType;
  String? variantName;
  double? unitPrice;
  int? quantity;
  double? total;
  int? isSync;
  String? imageUrl;
  int? inventoryQuantity;

  String? lens_type;
  String? product_title;

  String? priscription;
  String? frame_name;
  double? frame_price;
  int? frame_qty;
  double? frame_total;

  String? trialRequestType;
  String? clinicName;
  String? clientName;
  String? relation;
  String? mobile;
  String? mail;
  String? houseNo;
  String? location;
  String? pincode;
  String? addressType;
  String? appointmentDate;
  String? appointmentTime;
  String? productName2;

  int? bookQty;
  double? bookPrice;
  double? bookTotal;
  String? type;

  String? rdSph;
  String? rdCyl;
  String? rdAxis;
  String? rdBcva;

  String? raSph;
  String? raCyl;
  String? raAxis;
  String? raBcva;

  String? ldSph;
  String? ldCyl;
  String? ldAxis;
  String? ldBcva;

  String? laSph;
  String? laCyl;
  String? laAxis;
  String? laBcva;

  double? addOnPrice;
  int? addOnQty;
  String? addOnTitle;
  double? addOnTotal;

  String? re;
  String? le;
  String? prType;
  String? createdAt;
  String? updatedAt;
  String? priscription2;

  CartModel(
      {this.id,
      this.productId,
      this.frameId,
      this.bookId,
      this.addOnId,
      this.variantId,
      this.name,
      this.productType,
      this.variantName,
      this.unitPrice,
      this.quantity,
      this.total,
      this.isSync,
      this.imageUrl,
      this.inventoryQuantity,
      this.lens_type,
      this.product_title,
      this.priscription,
      this.frame_name,
      this.frame_price,
      this.frame_qty,
      this.frame_total,
      this.trialRequestType,
      this.clientName,
      this.clinicName,
      this.relation,
      this.mobile,
      this.mail,
      this.houseNo,
      this.location,
      this.pincode,
      this.addressType,
      this.appointmentDate,
      this.appointmentTime,
      this.productName2,
      this.bookQty,
      this.bookPrice,
      this.bookTotal,
      this.type,
      this.rdSph,
      this.rdCyl,
      this.rdAxis,
      this.rdBcva,
      this.raSph,
      this.raCyl,
      this.raAxis,
      this.raBcva,
      this.ldSph,
      this.ldCyl,
      this.ldAxis,
      this.ldBcva,
      this.laSph,
      this.laCyl,
      this.laAxis,
      this.laBcva,
      this.le,
      this.re,
      this.addOnQty,
      this.addOnPrice,
      this.addOnTitle,
      this.addOnTotal,
      this.prType,
      this.createdAt,
      this.updatedAt,
      this.priscription2});

  factory CartModel.fromJson(Map<String, dynamic> json) {
    int id = json['id'];
    int productId = json['product_id'];
    int frameId = json['frame_id'];
    int bookId = json['book_id'];
    int addOnId = json['addon_id'];
    int variantId = json['variant_id'];
    String name = json['name'];
    String productType = json['product_type'];
    String variantName = json['variant_name'];
    double unitPrice = json['unit_price'];
    int quantity = json['quantity'];
    double total = json['total'];
    int isSync = json['is_sync'];
    String imageUrl = json['image_url'];
    int inventoryQuantity = json['inventory_quantity'];
    String lens_type = json['lens_type'];
    String product_title=json['product_title'];

    String priscription = json['priscription'];
    String frame_name = json['frame_name'];
    double frame_price = json['frame_price'];
    int frame_qty = json['frame_qty'];
    double frame_total = json['frame_total'];

    String trialRequestType = json['trial_request_type'];
    String clientName = json['client_name'];
    String relation = json['relation'];
    String clinicName = json['clinic_name'];
    String mobile = json['mobile'];
    String mail = json['mail'];
    String houseNo = json['house_no'];
    String location = json['location'];
    String pincode = json['pincode'];
    String addressType = json['address_type'];
    String appointmentDate = json['appointment_time'];
    String appointmentTime = json['appointment_date'];
    String productName2 = json['name'];
    int bookQty = json['book_qty'];
    double bookPrice = json['book_price'];
    double bookTotal = json['book_total'];
    String type = json['type'];

    String rdSph = json['rd_sph'];
    String rdCyl = json['rd_cyl'];
    String rdAxis = json['rd_axis'];
    String rdBcva = json['rd_bcva'];

    String raSph = json['ra_sph'];
    String raCyl = json['ra_cyl'];
    String raAxis = json['ra_axis'];
    String raBcva = json['ra_bcva'];

    String ldSph = json['ld_sph'];
    String ldCyl = json['ld_cyl'];
    String ldAxis = json['ld_axis'];
    String ldBcva = json['ld_bcva'];

    String laSph = json['la_sph'];
    String laCyl = json['la_cyl'];
    String laAxis = json['la_axis'];
    String laBcva = json['la_bcva'];

    String re = json['re'];
    String le = json['le'];

    String addOnTitle = json['addon_title'];
    double addOnPrice = json['addon_price'];
    double addOnTotal = json['addon_total'];
    int addOnQty = json['addon_qty'];

    String prType = json['pr_type'];
    String createdAt = json['created_at'];
    String updatedAt = json['updated_at'];
    String priscription2 = json['priscription'];

    return CartModel(
        id: id,
        productId: productId,
        frameId: frameId,
        bookId: bookId,
        addOnId: addOnId,
        variantId: variantId,
        name: name,
        productType: productType,
        variantName: variantName,
        unitPrice: unitPrice,
        quantity: quantity,
        total: total,
        isSync: isSync,
        imageUrl: imageUrl,
        inventoryQuantity: inventoryQuantity,
        lens_type: lens_type,
        product_title: product_title,
        priscription: priscription,
        frame_name: frame_name,
        frame_price: frame_price,
        frame_qty: frame_qty,
        frame_total: frame_total,
        trialRequestType: trialRequestType,
        clientName: clientName,
        relation: relation,
        clinicName: clinicName,
        mobile: mobile,
        mail: mail,
        houseNo: houseNo,
        location: location,
        pincode: pincode,
        addressType: addressType,
        appointmentDate: appointmentDate,
        appointmentTime: appointmentTime,
        productName2: productName2,
        bookQty: bookQty,
        bookPrice: bookPrice,
        bookTotal: bookTotal,
        type: type,
        rdSph: rdSph,
        rdCyl: rdCyl,
        rdAxis: rdAxis,
        rdBcva: rdBcva,
        raSph: raSph,
        raCyl: raCyl,
        raAxis: raAxis,
        raBcva: raBcva,
        ldSph: ldSph,
        ldCyl: ldCyl,
        ldAxis: ldAxis,
        ldBcva: ldBcva,
        laSph: laSph,
        laCyl: laCyl,
        laAxis: laAxis,
        laBcva: laBcva,
        re: re,
        le: le,
        addOnPrice: addOnPrice,
        addOnQty: addOnQty,
        addOnTitle: addOnTitle,
        addOnTotal: addOnTotal,
        prType: prType,
        createdAt: createdAt,
        updatedAt: updatedAt,
        priscription2: priscription2);
  }
}
