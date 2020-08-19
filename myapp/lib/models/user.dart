import 'package:meta/meta.dart';
class User {
  final int id;
  final String email;
  final String fullName;
  final DateTime createdDate;
  final DateTime expiredDate;
  final String tokenKey;
  final int role;
  final int isActive;

  User({
    @required this.id,
    @required this.email,
    this.fullName,
    this.createdDate,
    this.expiredDate,
    @required this.tokenKey,
    this.role,
    this.isActive
    }):
        assert(id > 0),
        assert(email != null),
        assert(tokenKey != null);

  factory User.fromJSON({Map<String, dynamic> data}) {
    return User(
        id: data['id'] ?? 0,
        email: data['email'] ?? '',
        tokenKey: data['tokenKey'] ?? '',
        role: data['role'] ?? 1,
    );
  }
  Map<String, dynamic> get toMap => {
    'id': this.id ?? 0,
    'email': this.email ?? '',
    'tokenKey': this.tokenKey ?? ''
  };
}