import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:http/testing.dart';
import 'package:login_bloc/src/models/login_model.dart';
import 'package:login_bloc/src/resources/login_api_provider.dart';

void main() {
  test(
    'Fetech user with user name and password',
    () async {
      final userApi = LoginAPIProvider();
      userApi.client = MockClient(
        (request) async {
          final jsonMap = {'token': 'QpwL5tke4Pnpja7X4'};
          return Response(
            json.encode(jsonMap),
            200,
          );
        },
      );
      final message = await userApi.login(
        LoginRequestModel(
          email: 'eve.holt@reqres.in',
          password: 'cityslicka',
        ),
      );
      expect(message.token, 'QpwL5tke4Pnpja7X4');
    },
  );
}
