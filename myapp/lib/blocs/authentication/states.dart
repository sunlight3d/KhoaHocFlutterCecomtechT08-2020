//State
import 'package:equatable/equatable.dart';
import 'package:myapp/models/models.dart';

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
class AuthenticationStateLoggingIn extends AuthenticationState {
  const AuthenticationStateLoggingIn();
  @override
  // TODO: implement props
  List<Object> get props => [];
}
class AuthenticationStateFailed extends AuthenticationState {
  final String message;
  AuthenticationStateFailed({this.message});
  @override
  List<Object> get props => [message];
}
class AuthenticationStateNotLogin extends AuthenticationState {
  AuthenticationStateNotLogin();
  @override
  List<Object> get props => [];
}