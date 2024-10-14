import 'package:irroba/interfaces/register_user/register_user_dto.dart';

class EditUserDto extends RegisterUserDto {
  EditUserDto({
    required super.email,
    required super.username,
    required super.password,
    required super.name,
    required super.address,
    required super.phone,
  });

  @override
  String toString() {
    return 'EditUserDto(email: $email, username: $username, password: $password, name: $name, address: $address, phone: $phone)';
  }
}
