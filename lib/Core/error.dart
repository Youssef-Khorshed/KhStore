import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class InternetFailure extends Failure {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class ApiFailure extends Failure {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class AuthFailure extends Failure {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class CashFailure extends Failure {
  @override
  List<Object?> get props => throw UnimplementedError();
}
