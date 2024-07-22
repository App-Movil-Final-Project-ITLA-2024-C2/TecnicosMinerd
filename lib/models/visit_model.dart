class Visit {
  int? id;
  String directorId;
  String schoolCode;
  String visitReason;
  String? photo;
  String? comment;
  String? audio;
  double latitude;
  double longitude;
  String date;
  String time;

  Visit({
    this.id,
    required this.directorId,
    required this.schoolCode,
    required this.visitReason,
    this.photo,
    this.comment,
    this.audio,
    required this.latitude,
    required this.longitude,
    required this.date,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'director_id': directorId,
      'school_code': schoolCode,
      'visit_reason': visitReason,
      'photo': photo,
      'comment': comment,
      'audio': audio,
      'latitude': latitude,
      'longitude': longitude,
      'date': date,
      'time': time,
    };
  }

  factory Visit.fromMap(Map<String, dynamic> map) {
    return Visit(
      id: map['id'],
      directorId: map['director_id'],
      schoolCode: map['school_code'],
      visitReason: map['visit_reason'],
      photo: map['photo'],
      comment: map['comment'],
      audio: map['audio'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      date: map['date'],
      time: map['time'],
    );
  }
}
