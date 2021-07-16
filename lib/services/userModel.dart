class User{
  var email, password;

  User({
    this.email,
    this.password
  });

  factory User.fromJson(Map<String, dynamic> json){
    if (json['request']['name'] == 'login') {
      return User(
          email: json['request']['body']['email'],
          password: json['password']
      );
    }
    return User(email: null, password: null);
  }

}