
class Registration {
  final String cedula;
  final String nombre;
  final String apellido;
  final String clave;
  final String correo;
  final String telefono;
  final String fechaNacimiento;

  Registration({
    required this.cedula,
    required this.nombre,
    required this.apellido,
    required this.clave,
    required this.correo,
    required this.telefono,
    required this.fechaNacimiento,
  });

  factory Registration.fromJson(Map<String, dynamic> json) {
    return Registration(
      cedula: json['cedula'] as String,
      nombre: json['nombre'] as String,
      apellido: json['apellido'] as String,
      clave: json['clave'] as String,
      correo: json['correo'] as String,
      telefono: json['telefono'] as String,
      fechaNacimiento: json['fecha_nacimiento'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cedula': cedula,
      'nombre': nombre,
      'apellido': apellido,
      'clave': clave,
      'correo': correo,
      'telefono': telefono,
      'fecha_nacimiento': fechaNacimiento,
    };
  }
}
