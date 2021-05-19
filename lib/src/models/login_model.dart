class LoginResponseModel {
  final String token;
  final String error;
  bool isClicked;
  LoginResponseModel({
    this.token,
    this.error,
    this.isClicked = false,
  });
  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      token: json["token"] != null ? json["token"] : "",
      error: json["error"] != null ? json["error"] : "",
    );
  }
}

class LoginRequestModel {
  final String email;
  final String password;
  LoginRequestModel({
    this.email,
    this.password,
  });
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'email': email.trim(),
      'password': password.trim(),
    };
    return map;
  }
}
