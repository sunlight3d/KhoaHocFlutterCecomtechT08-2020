//cai 2 thu vien: Equatable, flutter bloc
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
//Bloc
class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState>{
  final UserRepository userRepository;
  AuthenticationBloc({this.userRepository}):super(AuthenticationStateInitial());
  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent authenticationEvent)
    async *{
    if(authenticationEvent is AuthenticationStateLoggingIn) {
      return;
    }
    try {
      if(authenticationEvent is AuthenticationEventLogin) {
        yield AuthenticationStateLoggingIn();
        final response = await this.userRepository.login(
            email: authenticationEvent.email,
            password: authenticationEvent.password
        );
        if(response.error == null) {
          if(authenticationEvent.isRemember == true) {
            await SQLiteDatabase.sharedInstance.insertUser(user: response.result);
          }
          yield AuthenticationStateSuccess(user: response.result);
        } else {
          yield AuthenticationStateFailed(message: response.error);
        }
      } else if(authenticationEvent is AuthenticationEventRegister){
        final response = await this.userRepository.register(
            email: authenticationEvent.email,
            password: authenticationEvent.password
        );
        if(response.error == null) {
          if(authenticationEvent.isRemember == true) {
            await SQLiteDatabase.sharedInstance.insertUser(user: response.result);
          }
          yield AuthenticationStateSuccess(user: response.result);
        } else {
          yield AuthenticationStateFailed(message: response.error);
        }
      } else if(authenticationEvent is AuthenticationEventLogout) {
        final user = authenticationEvent.user;
        if(user != null) {
          await userRepository.logout(tokenKey: user.tokenKey);
          SQLiteDatabase.sharedInstance.deleteUser(user: user);
        }
      } else if(authenticationEvent is AuthenticationEventCheckToken) {
        final user = await SQLiteDatabase.sharedInstance.getUser();
        if(user != null) {
          String email = user.email;
          String tokenKey = user.tokenKey;
          final response = await userRepository
              .checkToken(tokenKey: tokenKey, email: email);
          if(response.error == null) {
            yield AuthenticationStateSuccess(user: user);
          } else {
            yield AuthenticationStateFailed(message: response.error);
          }
        } else {
          yield AuthenticationStateNotLogin();
        }
      }
    }catch(exception){
      yield AuthenticationStateFailed(message: exception.toString());
    }
  }
}
