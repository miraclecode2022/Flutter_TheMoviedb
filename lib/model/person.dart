class Person {
  final int id;
  final double popularity;
  final String name;
  final String profileImg;
  final String know;

  Person({
    this.id,
    this.popularity,
    this.name,
    this.profileImg,
    this.know,
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id'],
      popularity: json['popularity'],
      name: json['name'],
      profileImg: json['profile_path'],
      know: json['known_for_department'],
    );
  }
}
