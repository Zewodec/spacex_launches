// To parse this JSON data, do
//
//     final launchpadsModel = launchpadsModelFromJson(jsonString);

import 'dart:convert';

List<LaunchpadsModel> launchpadsModelFromJson(String str) =>
    List<LaunchpadsModel>.from(
        json.decode(str).map((x) => LaunchpadsModel.fromJson(x)));

String launchpadsModelToJson(List<LaunchpadsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LaunchpadsModel {
  Images images;
  String name;
  String fullName;
  String locality;
  String region;
  double latitude;
  double longitude;
  int launchAttempts;
  int launchSuccesses;
  List<String> rockets;
  String timezone;
  List<String> launches;
  String status;
  String details;
  String id;

  LaunchpadsModel({
    required this.images,
    required this.name,
    required this.fullName,
    required this.locality,
    required this.region,
    required this.latitude,
    required this.longitude,
    required this.launchAttempts,
    required this.launchSuccesses,
    required this.rockets,
    required this.timezone,
    required this.launches,
    required this.status,
    required this.details,
    required this.id,
  });

  factory LaunchpadsModel.fromJson(Map<String, dynamic> json) =>
      LaunchpadsModel(
        images: Images.fromJson(json["images"]),
        name: json["name"],
        fullName: json["full_name"],
        locality: json["locality"],
        region: json["region"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        launchAttempts: json["launch_attempts"],
        launchSuccesses: json["launch_successes"],
        rockets: List<String>.from(json["rockets"].map((x) => x)),
        timezone: json["timezone"],
        launches: List<String>.from(json["launches"].map((x) => x)),
        status: json["status"],
        details: json["details"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "images": images.toJson(),
        "name": name,
        "full_name": fullName,
        "locality": locality,
        "region": region,
        "latitude": latitude,
        "longitude": longitude,
        "launch_attempts": launchAttempts,
        "launch_successes": launchSuccesses,
        "rockets": List<dynamic>.from(rockets.map((x) => x)),
        "timezone": timezone,
        "launches": List<dynamic>.from(launches.map((x) => x)),
        "status": status,
        "details": details,
        "id": id,
      };
}

class Images {
  List<String> large;

  Images({
    required this.large,
  });

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        large: List<String>.from(json["large"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "large": List<dynamic>.from(large.map((x) => x)),
      };
}
