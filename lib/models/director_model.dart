class Director {
  int? id;
  String identification;
  String photo;
  String firstName;
  String lastName;
  String birthDate;
  String address;
  String phoneNumber;

  Director({
    this.id,
    required this.identification,
    required this.photo,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.address,
    required this.phoneNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'identification': identification,
      'photo': photo,
      'first_name': firstName,
      'last_name': lastName,
      'birth_date': birthDate,
      'address': address,
      'phone_number': phoneNumber,
    };
  }

  factory Director.fromMap(Map<String, dynamic> map) {
    return Director(
      id: map['id'],
      identification: map['identification'],
      photo: map['photo'],
      firstName: map['first_name'],
      lastName: map['last_name'],
      birthDate: map['birth_date'],
      address: map['address'],
      phoneNumber: map['phone_number'],
    );
  }
}
