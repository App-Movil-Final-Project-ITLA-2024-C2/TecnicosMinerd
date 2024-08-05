class User {
  final String id;
  final String nombre;
  final String apellido;
  final String correo;
  final String telefono;
  final String fechaNacimiento;
  final String token;

  User({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.correo,
    required this.telefono,
    required this.fechaNacimiento,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      nombre: json['nombre'],
      apellido: json['apellido'],
      correo: json['correo'],
      telefono: json['telefono'],
      fechaNacimiento: json['fecha_nacimiento'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'apellido': apellido,
      'correo': correo,
      'telefono': telefono,
      'fecha_nacimiento': fechaNacimiento,
      'token': token,
    };
  }
}
