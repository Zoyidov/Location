class Location {
  final double latitude;
  final double longitude;

  Location({required this.latitude, required this.longitude});
}

class Address {
  final int? id;
  final String name;
  final String title;
  final double lat;
  final double long;

  Address({
    required this.id,
    required this.name,
    required this.title,
    required this.lat,
    required this.long,
  });

  Address copyWith({
    int? id,
    String? name,
    String? title,
    double? lat,
    double? long,
  }) =>
      Address(
        id: id ?? this.id,
        name: name ?? this.name,
        title: title ?? this.title,
        lat: lat ?? this.lat,
        long: long ?? this.long,
      );

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    id: json["id"],
    name: json["name"],
    title: json["title"],
    lat: json["latitude"]?.toDouble(),
    long: json["longitude"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    // "id": id,
    "name": name,
    "title": title,
    "latitude": lat,
    "longitude": long,
  };
}