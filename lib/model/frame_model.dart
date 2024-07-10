class FrameModel{
 int? id;
 int? product_id;
 String? lens_type;
 String? productName;
 double? productPrice;
 // String? leftEyeVision;
 // String? rightEyeVision;
 String? priscription;
 String? frame_name;
 double? frame_price;
 int? frame_qty;
 double? frame_total;

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
 double? addOnTotal;

 String? addOnTitle;
 int? addOnQty;
 String? re;
 String? le;


 FrameModel({this.id, this.product_id, this.lens_type, this.productName, this.productPrice,
   this.priscription,
 this.frame_name, this.frame_price, this.frame_qty,this.frame_total,
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
   this.addOnTotal

 });

 factory FrameModel.fromJson(Map<String, dynamic> json){
   int id=json['id'];
   int product_id=json['product_id2'];
   String lens_type=json['lens_type'];
   String productName=json['product_name'];
   double productPrice=json['product_price'];
  // String leftEyevision=json['left_eye_vision'];
  // String rightEyevision=json['right_eye_vision'];
   String priscription=json['priscription'];
   String frame_name=json['frame_name'];
   double frame_price=json['frame_price'];
   int frame_qty=json['frame_qty'];
   double frame_total=json['frame_total'];

   String rdSph=json['rd_sph'];
   String rdCyl=json['rd_cyl'];
   String rdAxis=json['rd_axis'];
   String rdBcva=json['rd_bcva'];

   String raSph=json['ra_sph'];
   String raCyl=json['ra_cyl'];
   String raAxis=json['ra_axis'];
   String raBcva=json['ra_bcva'];

   String ldSph=json['ld_sph'];
   String ldCyl=json['ld_cyl'];
   String ldAxis=json['ld_axis'];
   String ldBcva=json['ld_bcva'];

   String laSph=json['la_sph'];
   String laCyl=json['la_cyl'];
   String laAxis=json['la_axis'];
   String laBcva=json['la_bcva'];

   String re=json['re'];
   String le=json['le'];

   int addOnQty=json['addon_qty'];
   String addOnTitle=json['addon_title'];
   double addOnPrice=json['addon_price'];
   double addOnTotal=json['addon_total'];
   return FrameModel(
     id: id,product_id:product_id, lens_type: lens_type,productName: productName, productPrice: productPrice,

       priscription: priscription, frame_name: frame_name, frame_price: frame_price,
     frame_qty: frame_qty, frame_total: frame_total,
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

     addOnQty: addOnQty,
       addOnPrice: addOnPrice,
       addOnTitle: addOnTitle,
     addOnTotal: addOnTotal
   );
 }


}