class VisitType {
  int? id;
  String name;
  String description;

  VisitType({
    this.id,
    required this.name,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }

  factory VisitType.fromMap(Map<String, dynamic> map) {
    return VisitType(
      id: map['id'],
      name: map['name'],
      description: map['description'],
    );
  }
}
