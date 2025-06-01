import 'package:flutter/foundation.dart'
    show immutable;
import 'package:statemanager/models/thing.dart';

enum AnimalType {
  dog,
  cat,
  bird,
  fish,
  reptile,
  amphibian,
  rodent,
  insect,
}

@immutable
class Animal extends Thing {
  final AnimalType type;
  final String habitat;
  final String diet;
  final String lifespan;
  final bool endangered;
  final String image;
  final String conservationStatus;
  final String scientificName;
  final String averageHeight;
  final String averageWeight;
  final String description;

  const Animal({
    required super.name,
    required this.type,
    required this.habitat,
    required this.diet,
    required this.lifespan,
    required this.endangered,
    required this.image,
    required this.conservationStatus,
    required this.scientificName,
    required this.averageHeight,
    required this.averageWeight,
    required this.description,
  });

  @override
  String toString() {
    return 'Animal(name: $name, type: $type, habitat: $habitat, diet: $diet, lifespan: $lifespan, endangered: $endangered, image: $image, conservationStatus: $conservationStatus, scientificName: $scientificName, averageHeight: $averageHeight, averageWeight: $averageWeight, description: $description)';
  }

  factory Animal.fromJson(
      Map<String, dynamic> json) {
    return Animal(
      name: json['name'] as String,
      type: AnimalType.values.firstWhere(
        // should convert to lowercase and trim
        // here we are extracting the type from the json and matching it with the enum
        (e) =>
            e.toString().split('.').last ==
            json['type']
                .toString()
                .toLowerCase()
                .trim(),
      ), // Convert the type from string to AnimalType enum
      habitat: json['habitat'] as String,
      diet: json['diet'] as String,
      lifespan: json['lifespan'] as String,
      endangered: json['endangered'] as bool,
      image: json['image'] as String,
      conservationStatus:
          json['conservationStatus'] as String,
      scientificName:
          json['scientificName'] as String,
      averageHeight:
          json['averageHeight'] as String,
      averageWeight:
          json['averageWeight'] as String,
      description: json['description'] as String,
    );
  }

  @override
  Map<String, dynamic> toSearchableMap() {
    return {
      'name': name,
      'type': type.toString().split('.').last,
      'habitat': habitat,
      'diet': diet,
      'lifespan': lifespan,
      'endangered': endangered.toString(),
      'image': image,
      'conservationStatus': conservationStatus,
      'scientificName': scientificName,
      'averageHeight': averageHeight,
      'averageWeight': averageWeight,
      'description': description,
    };
  }
}
