class Language {
  final String code;
  final String name;
  final int id;

  const Language({
    this.code,
    this.name,
    this.id,
  });

  static const system = Language(
    id: 0,
    code: '',
    name: 'system',
  );

  factory Language.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return Language(
      id: json['id'],
      code: json['code'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'code': code, 'name': name};
  }
}
