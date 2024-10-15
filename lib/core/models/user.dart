class UserModel {
  final String id;
  final String email;
  final String username;
  final String password;
  final NameModel name;
  final AddressModel address;
  final String phone;

  UserModel({
    required this.id,
    required this.email,
    required this.username,
    required this.password,
    required this.name,
    required this.address,
    required this.phone,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      email: map['email'] as String,
      username: map['username'] as String,
      password: map['password'] as String,
      name: NameModel.fromMap(map['name'] as Map<String, dynamic>),
      address: AddressModel.fromMap(map['address'] as Map<String, dynamic>),
      phone: map['phone'] as String,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'].toString(),
      email: json['email'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
      name: NameModel.fromMap(json['name'] as Map<String, dynamic>),
      address: AddressModel.fromMap(json['address'] as Map<String, dynamic>),
      phone: json['phone'] as String,
    );
  }

  @override
  String toString() {
    return 'RegisterUserDto(email: $email, username: $username, password: $password, name: $name, address: $address, phone: $phone)';
  }
}

class NameModel {
  final String firstName;
  final String lastName;

  NameModel({
    required this.firstName,
    required this.lastName,
  });

  factory NameModel.fromMap(Map<String, dynamic> map) {
    return NameModel(
      firstName: map['firstname'] as String,
      lastName: map['lastname'] as String,
    );
  }

  toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
    };
  }

  @override
  String toString() => 'NameModel(firstName: $firstName, lastName: $lastName)';
}

class AddressModel {
  final String city;
  final String street;
  final int number;
  final String zipcode;
  final GeoModel geolocation;

  AddressModel({
    required this.city,
    required this.street,
    required this.number,
    required this.zipcode,
    required this.geolocation,
  });

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      city: map['city'] as String,
      street: map['street'] as String,
      number: map['number'] as int,
      zipcode: map['zipcode'] as String,
      geolocation: GeoModel.fromMap(map['geolocation'] as Map<String, dynamic>),
    );
  }

  toJson() {
    return {
      'city': city,
      'street': street,
      'number': number,
      'zipcode': zipcode,
      'geolocation': geolocation,
    };
  }

  @override
  String toString() {
    return 'AddressModel(city: $city, street: $street, number: $number, zipcode: $zipcode, geolocation: $geolocation)';
  }
}

class GeoModel {
  final String lat;
  final String long;

  factory GeoModel.fromMap(Map<String, dynamic> map) {
    return GeoModel(
      lat: map['lat'] as String,
      long: map['long'] as String,
    );
  }

  toJson() {
    return {
      'lat': lat,
      'long': long,
    };
  }

  GeoModel({
    required this.lat,
    required this.long,
  });
}
