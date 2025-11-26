class RegistrationRequest {
  final String firstname;
  final String lastname;
  final String email;
  final String password;

  const RegistrationRequest({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'customer': {
        'firstname': firstname,
        'lastname': lastname,
        'email': email,
      },
      'password': password,
    };
  }
}
