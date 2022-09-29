import 'package:equatable/equatable.dart';

class UserLoginEntity extends Equatable {
  final String email;
  final String password;

  const UserLoginEntity({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [
        email,
        password,
      ];
}
