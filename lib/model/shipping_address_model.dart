class ShippingAddressModel {
  String firstName;
  String address1;
  String phone;
  String city;
  String zip;
  String province;
  String country;
  String lastName;
  String address2;
  String company;
  double latitude;
  double longitude;
  String name;
  String countryCode;
  String provinceCode;

  ShippingAddressModel(
      {required this.firstName,
      required this.address1,
      required this.phone,
      required this.city,
      required this.zip,
      required this.province,
      required this.country,
      required this.lastName,
      required this.address2,
      required this.company,
      required this.latitude,
      required this.longitude,
      required this.name,
      required this.countryCode,
      required this.provinceCode});

  factory ShippingAddressModel.fromJson(Map<String, dynamic> json) {
    String firstName = json['first_name'] ?? '';
    String address1 = json['address1'] ?? '';
    String phone = json['phone'] ?? '';
    String city = json['city'] ?? '';
    String zip = json['zip'] ?? '';
    String province = json['province'] ?? '';
    String country = json['country'] ?? '';
    String lastName = json['last_name'] ?? '';
    String address2 = json['address2'] ?? '';
    String company = json['company'] ?? '';
    double latitude = json['latitude'] ?? 0;
    double longitude = json['longitude'] ?? 0;
    String name = json['name'];
    String countryCode = json['country_code'];
    String provinceCode = json['province_code']??'';

    return ShippingAddressModel(
        firstName: firstName,
        address1: address1,
        phone: phone,
        city: city,
        zip: zip,
        province: province,
        country: country,
        lastName: lastName,
        address2: address2,
        company: company,
        latitude: latitude,
        longitude: longitude,
        name: name,
        countryCode: countryCode,
        provinceCode: provinceCode);
  }

  /*Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['address1'] = address1;
    data['phone'] = phone;
    data['city'] = city;
    data['zip'] = zip;
    data['province'] = province;
    data['country'] = country;
    data['last_name'] = lastName;
    data['address2'] = address2;
    data['company'] = company;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['name'] = name;
    data['country_code'] = countryCode;
    data['province_code'] = provinceCode;
    return data;
  }*/
}
