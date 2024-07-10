
class AddressModel {
  int? id;
  int? customerId;
  String? address1;
  String? address2;
  String? pincode;
  String? company;
  bool? defaultValue;
  AddressModel({
    this.id, this.customerId,this.address1, this.address2, this.pincode, this.company, this.defaultValue});

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    int id = json['id']??0;
    int customerId = json['customer_id']??0;
    String address1= json['address1']??'';
    String address2= json['address2']??'';
    String pincode= json['zip']??'';
    String company= json['company']??'';
    bool defaultValue= json['default'];

    return AddressModel(
        id:id, customerId: customerId, address1:address1, address2: address2, pincode: pincode, company: company, defaultValue: defaultValue);
  }
}