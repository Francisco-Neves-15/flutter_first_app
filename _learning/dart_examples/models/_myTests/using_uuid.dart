import 'package:uuid/uuid.dart';

class UserModel {
  final String id;
  final String name;
  final String email;

  // Initialize Uuid as a constant instance
  static const _uuid = Uuid();

  // Constructor: Generates a random v4 UUID if none is provided
  UserModel({
    required String? id,
    required this.name,
    required this.email,
  }) : id = id ?? _uuid.v4();

  // Helper for JSON parsing (e.g., when fetching from a database/API)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }

  // CopyWith for state updates
  UserModel copyWith({
    String? name,
    String? email,
  }) {
    return UserModel(
      id: this.id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }
}
