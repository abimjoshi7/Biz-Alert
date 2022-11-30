part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {}

class GoogleSignInRequested extends AuthenticationEvent {
  @override
  List<Object?> get props => [];
}

class FacebookSignInRequested extends AuthenticationEvent {
  @override
  List<Object?> get props => [];
}

class SignOutRequested extends AuthenticationEvent {
  @override
  List<Object?> get props => [];
}
