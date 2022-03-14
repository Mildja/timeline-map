import 'dart:convert';

class UserModel {
  final String email;
  final String name;
  final String typeuser;
  final String password;
  UserModel({
    required this.email,
    required this.name,
    required this.typeuser,
    required this.password,
  });

  UserModel copyWith({
    String? email,
    String? name,
    String? typeuser,
    String? password,
  }) {
    return UserModel(
      email: email ?? this.email,
      name: name ?? this.name,
      typeuser: typeuser ?? this.typeuser,
      password: typeuser ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'typeuser': typeuser,
      'password': password,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic>? map) {
    return UserModel(
      email: map!['email'] ?? '',
      name: map['name'] ?? '',
      typeuser: map['typeuser'] ?? '',
      password: map['password'] ?? '',
    );
  }
 
  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() => 'UserModel(email: $email, name: $name, typeuser: $typeuser,password: $password)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserModel &&
      other.email == email &&
      other.name == name &&
      other.typeuser == typeuser&&
      other.password == password;
  }

  @override
  int get hashCode => email.hashCode ^ name.hashCode ^ typeuser.hashCode;
}
