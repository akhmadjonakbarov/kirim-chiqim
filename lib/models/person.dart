// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/cupertino.dart';

@immutable
class Person {
  String id;
  String name;
  String phoneNumber;
  Person({
    required this.id,
    required this.name,
    required this.phoneNumber,
  });

  Person copyWith({
    String? id,
    String? name,
    String? phoneNumber,
  }) {
    return Person(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
    };
  }

  factory Person.fromMap(Map<String, dynamic> map) {
    return Person(
      id: map['id'] as String,
      name: map['name'] as String,
      phoneNumber: map['phoneNumber'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Person.fromJson(String source) =>
      Person.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Person(id: $id, name: $name, phoneNumber: $phoneNumber)';

  @override
  bool operator ==(covariant Person other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.phoneNumber == phoneNumber;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ phoneNumber.hashCode;
}
