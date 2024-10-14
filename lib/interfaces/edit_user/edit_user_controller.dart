import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:irroba/core/libs/geo_locator.dart';
import 'package:irroba/core/models/async_state.dart';
import 'package:irroba/core/models/user.dart';
import 'package:irroba/core/repositories/users_repository.dart';
import 'package:irroba/core/utils/identify_error.dart';
import 'package:irroba/interfaces/edit_user/edit_user_dto.dart';

abstract class EditUserController extends ChangeNotifier {
  AsyncState asyncState = AsyncState.initial;
  bool obscurePassword = true;

  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  int step = 1;

  TextEditingController email = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController phone = TextEditingController();

  TextEditingController street = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController zipcode = TextEditingController();
  TextEditingController latitude = TextEditingController();
  TextEditingController longitude = TextEditingController();

  Future<void> init();
  Future<void> saveUser();
  Future<void> getLocation();

  void setStep(int newStep);
  void setState(AsyncState state);
  void setObsecurePassword(bool value);
}

class EditUserImpl extends EditUserController {
  final UsersRepository usersRepository;
  final Function(String message, Color color) onSnackBarService;
  final UserModel user;
  Function sucessSave;

  EditUserImpl({
    required this.usersRepository,
    required this.onSnackBarService,
    required this.user,
    required this.sucessSave,
  }) {
    init();
  }

  @override
  Future<void> init() async {
    setState(AsyncState.loading);
    email.text = user.email;
    username.text = user.username;
    password.text = user.password;
    confirmPassword.text = user.password;
    firstName.text = user.name.firstName;
    lastName.text = user.name.lastName;
    phone.text = user.phone;
    street.text = user.address.street;
    number.text = user.address.number.toString();
    city.text = user.address.city;
    zipcode.text = user.address.zipcode;
    latitude.text = user.address.geolocation.lat;
    longitude.text = user.address.geolocation.long;
    setState(AsyncState.initial);
  }

  @override
  Future<void> saveUser() async {
    if (formKey2.currentState!.validate()) {
      final objectName = NameModel(firstName: firstName.text, lastName: lastName.text);
      final geoLocation = GeoModel(lat: latitude.text, long: longitude.text);

      final address = AddressModel(
        city: city.text,
        street: street.text,
        number: int.parse(number.text),
        zipcode: zipcode.text,
        geolocation: geoLocation,
      );
      try {
        setState(AsyncState.loading);
        final user = EditUserDto(
          email: email.text,
          username: username.text,
          password: password.text,
          name: objectName,
          address: address,
          phone: phone.text,
        );
        final response = await usersRepository.update(user, this.user.id);
        if (response.statusCode == 200) {
          onSnackBarService('Usuário editado com sucesso', Colors.green);
        }
        sucessSave();
      } catch (error) {
        log(error.toString());
        onSnackBarService(identifyError(error: error, message: 'Erro ao editar o usuário'), Colors.red);
        setState(AsyncState.initial);
      }
    }
  }

  @override
  Future<void> getLocation() async {
    try {
      setState(AsyncState.loading);
      final geoLocation = await getLagLong();
      latitude.text = geoLocation.lat;
      longitude.text = geoLocation.long;
    } catch (error) {
      log(error.toString());
    } finally {
      setState(AsyncState.initial);
    }
  }

  @override
  void setStep(int newStep) {
    step = newStep;
    notifyListeners();
  }

  @override
  void setState(AsyncState state) {
    asyncState = state;
    notifyListeners();
  }

  @override
  void setObsecurePassword(bool value) {
    obscurePassword = value;
    notifyListeners();
  }
}
