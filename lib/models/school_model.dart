class School {
  int? id;
  String code;
  String name;
  String address;
  String phoneNumber;

  School({
    this.id,
    required this.code,
    required this.name,
    required this.address,
    required this.phoneNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'address': address,
      'phone_number': phoneNumber,
    };
  }

  factory School.fromMap(Map<String, dynamic> map) {
    return School(
      id: map['id'],
      code: map['code'],
      name: map['name'],
      address: map['address'],
      phoneNumber: map['phone_number'],
    );
  }
}
