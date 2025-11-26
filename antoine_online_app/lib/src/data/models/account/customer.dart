class Customer {
  final int id;
  final String firstname;
  final String lastname;
  final String email;

  Customer({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
    );
  }
}
