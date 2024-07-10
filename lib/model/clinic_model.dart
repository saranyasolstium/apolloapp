
class ClinicModel{
  int? id;
  String? address;
  String? state;
  String? city;
  String? clinicName;
  int? pincode;
  int? phone;
  double? latitude;
  double? longitude;

  ClinicModel({this.id, this.address, this.state,
    this.city, this.clinicName, this.pincode, this.phone, this.latitude, this.longitude});
  factory ClinicModel.fromJson(Map<String, dynamic> json) {
   int id=json['id'];
   String address=json['address'];
   String state=json['state'];
   String city=json['city'];
   String clinicName=json['clinicName'];
   int pincode=json['pincode'];
   int phone=json['phone'];
   double latitude=json['latitude'];
   double longitude=json['longitude'];
   return ClinicModel(id:id, address:address,
   state: state,city: city, clinicName: clinicName,
       pincode: pincode, phone: phone, latitude: latitude, longitude: longitude);
  }
}