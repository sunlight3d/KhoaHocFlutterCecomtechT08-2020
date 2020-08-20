import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:myapp/local_databases/sqlite_db.dart';
import 'package:myapp/models/models.dart';
import 'package:myapp/repositories/repositories.dart';


abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}
class AuthenticationEventLogin extends AuthenticationEvent {
  //tham so
  final String email;
  final String password;
  final bool isRemember;
  AuthenticationEventLogin({
    @required this.email,
    @required this.isRemember,
    @required this.password});
  @override
  // TODO: implement props
  List<Object> get props => [email, password, isRemember];
}
class AuthenticationEventRegister extends AuthenticationEvent {
  //tham so
  final String email;
  final String password;
  final bool isRemember;
  AuthenticationEventRegister({
    @required this.email,
    @required this.isRemember,
    @required this.password});
  @override
  // TODO: implement props
  List<Object> get props => [email, password,isRemember];
}
class AuthenticationEventCheckToken extends AuthenticationEvent {
  AuthenticationEventCheckToken();
  @override
  // TODO: implement props
  List<Object> get props => [];
}
class AuthenticationEventLogout extends AuthenticationEvent {
  final User user;
  AuthenticationEventLogout({this.user});
  List<Object> get props => [user];
}