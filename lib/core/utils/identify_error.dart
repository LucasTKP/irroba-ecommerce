import 'dart:io';

import 'package:dio/dio.dart';

String identifyError({required dynamic error, required String message}) {
  String messageError = message;
  if (error is DioException && error.error is SocketException) {
    messageError = 'Sem internet, por favor reconecte';
  }

  return messageError;
}
