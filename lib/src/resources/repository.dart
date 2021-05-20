import 'package:login_bloc/src/models/login_model.dart';
import 'package:login_bloc/src/resources/login_api_provider.dart';

class Repository {
  List<Author> author = <Author>[
    LoginAPIProvider(),
  ];

  Future<LoginResponseModel> login(LoginRequestModel loginRequestModel) {
    return author[0].loginApi(loginRequestModel);
  }
  
}

abstract class Author {
  Future<LoginResponseModel> loginApi(LoginRequestModel loginRequestModel);
}
