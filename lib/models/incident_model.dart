class Incident {
  int? id;
  String title;
  String schoolName;
  String regional;
  String district;
  String date;
  String description;
  String? photo;
  String? audio;

  Incident({
    this.id,
    required this.title,
    required this.schoolName,
    required this.regional,
    required this.district,
    required this.date,
    required this.description,
    this.photo,
    this.audio,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'schoolName': schoolName,
      'regional': regional,
      'district': district,
      'fecha': date,
      'descripcion': description,
      'foto': photo,
      'audio': audio,
    };
  }

  factory Incident.fromMap(Map<String, dynamic> map) {
    return Incident(
      id: map['id'],
      title: map['title'],
      schoolName: map['schoolName'],
      regional: map['regional'],
      district: map['district'],
      date: map['date'],
      description: map['description'],
      photo: map['photo'],
      audio: map['audio'],
    );
  }
}
