//cai 2 thu vien: Equatable, flutter bloc
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:myapp/models/models.dart';
abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}
class AuthenticationEventLogin extends Equatable {
  //tham so
  final String email;
  final String password;
  AuthenticationEventLogin({
    @required this.email,
    @required this.password});
  @override
  // TODO: implement props
  List<Object> get props => [email, password];
}
class AuthenticationEventRegister extends Equatable {
  //tham so
  final String email;
  final String password;
  AuthenticationEventRegister({
    @required this.email,
    @required this.password});
  @override
  // TODO: implement props
  List<Object> get props => [email, password];
}
class AuthenticationEventLogout extends Equatable {
  List<Object> get props => [];
}
//State
abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}
class AuthenticationStateInitial extends AuthenticationState {
  @override
  List<Object> get props => [];
}
class AuthenticationStateSuccess extends AuthenticationState {
  final User user;
  AuthenticationStateSuccess({this.user});
  @override
  List<Object> get props => [user.email, user.tokenKey];
}