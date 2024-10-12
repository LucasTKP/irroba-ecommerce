import 'package:irroba/core/models/user.dart';

class RegisterUserDto {
  final String email;
  final String username;
  final String password;
  final NameModel name;
  final AddressModel address;
  final String phone;

  RegisterUserDto({
    required this.email,
    required this.username,
    required this.password,
    required this.name,
    required this.address,
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'username': username,
      'password': password,
      'name': name.toJson(),
      'address': address.toJson(),
      'phone': phone
    };
  }

  @override
  String toString() {
    return 'RegisterUserDto(email: $email, username: $username, password: $password, name: $name, address: $address, phone: $phone)';
  }
}
