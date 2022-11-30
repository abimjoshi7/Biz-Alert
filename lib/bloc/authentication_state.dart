part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {}

class AuthenticationLoading extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class AuthenticationSuccess extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class AuthenticationFailed extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class AuthenticationError extends AuthenticationState {
  final String error;

  AuthenticationError(this.error);
  @override
  List<Object?> get props => [error];
}
