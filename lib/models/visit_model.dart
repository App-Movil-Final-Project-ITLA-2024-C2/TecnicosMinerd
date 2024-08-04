class Visit {
  final int? situacionId; // Opcional para el detalle de visitas
  final String cedulaDirector;
  final String codigoCentro;
  final String motivo;
  final String fotoEvidencia;
  final String comentario;
  final String notaVoz;
  final double latitud;
  final double longitud;
  final String fecha;
  final String hora;
  final String token;

  Visit({
    this.situacionId,
    required this.cedulaDirector,
    required this.codigoCentro,
    required this.motivo,
    required this.fotoEvidencia,
    required this.comentario,
    required this.notaVoz,
    required this.latitud,
    required this.longitud,
    required this.fecha,
    required this.hora,
    required this.token,
  });

  factory Visit.fromJson(Map<String, dynamic> json) {
    return Visit(
      situacionId: json['situacion_id'],
      cedulaDirector: json['cedula_director'],
      codigoCentro: json['codigo_centro'],
      motivo: json['motivo'],
      fotoEvidencia: json['foto_evidencia'],
      comentario: json['comentario'],
      notaVoz: json['nota_voz'],
      latitud: json['latitud'],
      longitud: json['longitud'],
      fecha: json['fecha'],
      hora: json['hora'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'situacion_id': situacionId,
      'cedula_director': cedulaDirector,
      'codigo_centro': codigoCentro,
      'motivo': motivo,
      'foto_evidencia': fotoEvidencia,
      'comentario': comentario,
      'nota_voz': notaVoz,
      'latitud': latitud,
      'longitud': longitud,
      'fecha': fecha,
      'hora': hora,
      'token': token,
    };
  }
}
