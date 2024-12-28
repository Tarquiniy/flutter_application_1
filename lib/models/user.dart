import 'dart:convert';

class User {
  final String username;
  final String clan;
  final String password;
  final String generation;
  final String nature;
  final List<String> disciplines;

  User({
    required this.username,
    required this.clan,
    required this.password,
    required this.generation,
    required this.nature,
    this.disciplines = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'clan': clan,
      'password': password,
      'generation': generation,
      'nature': nature,
      'disciplines': jsonEncode(disciplines), // Кодируем список в JSON строку
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      username: map['username'],
      clan: map['clan'],
      password: map['password'],
      generation: map['generation'],
      nature: map['nature'],
      disciplines: map['disciplines'] != null
          ? List<String>.from(
              jsonDecode(map['disciplines'])) // Декодируем строку в список
          : [],
    );
  }
}
