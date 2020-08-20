//Bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/blocs/authentication/states.dart';
import 'package:myapp/local_databases/sqlite_db.dart';
import 'package:myapp/repositories/repositories.dart';
import 'events.dart';
class AuthenticationBloc extends
  Bloc<AuthenticationEvent, AuthenticationState>{
  final UserRepository userRepository;
  AuthenticationBloc({this.userRepository})
  //:super(AuthenticationStateSuccess(user: User(email: 'hoang', tokenKey: 'ssss')));
//  :super(AuthenticationStateFailed(message: 'alaoaa'));
      :super(AuthenticationStateInitial());
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
        var user = await SQLiteDatabase.sharedInstance.getUser();
        if(user != null) {
          String email = user.email;
          String tokenKey = user.tokenKey;
          final response = await userRepository
              .checkToken(tokenKey: tokenKey, email: email);
          if(response.error == null) {
            user = response.result;
            await SQLiteDatabase.sharedInstance.updateUser(
                user: user
            );
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