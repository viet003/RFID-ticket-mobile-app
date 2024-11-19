class SignInModelResponse {
  final String token;
  final int err;
  final String msg;

  SignInModelResponse({
    this.token = '',
    this.err = -1,
    this.msg = ''
  });

  factory SignInModelResponse.fromJson(Map<String, dynamic> json) {
    return SignInModelResponse(
      token: json["token"] != null ? json["token"] : "",
      err: json["err"] != null ? json["err"] : "",
      msg: json["msg"] != null ? json["msg"] : "",
    );
  }
}

class SignInModelRequest {
  String email;
  String password;

  SignInModelRequest({
    this.email = '',
    this.password = '',
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'email': email.trim(),
      'pass_word': password.trim(),
    };

    return map;
  }
}