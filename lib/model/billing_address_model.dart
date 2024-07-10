class BillingAddressModel {
  String? firstName;
  String? address1;
  String? phone;
  String? city;
  String? zip;
  String? province;
  String? country;
  String? lastName;
  String? address2;
  String? company;
  double? latitude;
  double? longitude;
  String? name;
  String? countryCode;
  String? provinceCode;

  BillingAddressModel(
      {this.firstName,
      this.address1,
      this.phone,
      this.city,
      this.zip,
      this.province,
      this.country,
      this.lastName,
      this.address2,
      this.company,
      this.latitude,
      this.longitude,
      this.name,
      this.countryCode,
      this.provinceCode});

  BillingAddressModel.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'] ?? '';
    address1 = json['address1'] ?? '';
    phone = json['phone'] ?? '';
    city = json['city'] ?? '';
    zip = json['zip'] ?? '';
    province = json['province'] ?? '';
    country = json['country'] ?? '';
    lastName = json['last_name'] ?? '';
    address2 = json['address2'] ?? '';
    company = json['company'] ?? '';
    latitude = json['latitude'] ?? 0;
    longitude = json['longitude'] ?? 0;
    name = json['name'];
    countryCode = json['country_code'];
    provinceCode = json['province_code'];
  }

  Map<String, dynamic> toJson() {
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
  }
}
