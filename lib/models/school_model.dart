class School {
  final String? idx;
  final String? codigo;
  final String? nombre;
  final String? coordenadas;
  final String? distrito;
  final String? regional;
  final String? dMunicipal;

  School({
    this.idx,
    this.codigo,
    this.nombre,
    this.coordenadas,
    this.distrito,
    this.regional,
    this.dMunicipal,
  });

  factory School.fromJson(Map<String, dynamic> json) {
    return School(
      idx: json['idx']?.toString(),
      codigo: json['codigo']?.toString(),
      nombre: json['nombre']?.toString(),
      coordenadas: json['coordenadas']?.toString(),
      distrito: json['distrito']?.toString(),
      regional: json['regional']?.toString(),
      dMunicipal: json['d_dmunicipal']?.toString(),
    );
  }
}