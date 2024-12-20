class CountryFlag {
  final String name;
  final String emoji;
  final String unicode;
  final String image;

  CountryFlag({
    this.name,
    this.emoji,
    this.unicode,
    this.image,
  });

  factory CountryFlag.fromJson(Map<String, dynamic> json) {
    return CountryFlag(
      name: json['name'],
      emoji: json['emoji'],
      unicode: json['unicode'],
      image: json['image'],
    );
  }
}