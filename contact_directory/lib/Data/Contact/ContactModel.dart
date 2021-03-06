class ContactModel {
  final String name, email, phone;

  ContactModel({
    required this.name,
    required this.email,
    required this.phone,
  });

  ContactModel.fromJson(Map<String, dynamic> json)
      : name = json['name'].toString(),
        email = json['email'].toString(),
        phone = json['phone'].toString();

  Map<String, dynamic> toJson() =>
      {'name': name, 'email': email, 'phone': phone};
}
