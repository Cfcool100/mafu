part of 'signin_bloc.dart';

enum AuthState { isLogin, isUpdatePass }

class SignInState extends Equatable {
  const SignInState({
    this.email = const Email.pure(),
    this.password = const PasswordValidator.pure(),
    this.newPassword = const PasswordValidator.pure(),
    this.currentPassword = const PasswordValidator.pure(),
    this.newConfirmPassword = const PasswordValidator.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.authState = AuthState.isLogin,
  });

  final Email email;
  final PasswordValidator password;
  final PasswordValidator currentPassword;
  final PasswordValidator newPassword;
  final PasswordValidator newConfirmPassword;
  final FormzSubmissionStatus status;
  final bool isValid;
  final AuthState authState;

  @override
  List<Object> get props {
    return [
      email,
      password,
      currentPassword,
      newPassword,
      newConfirmPassword,
      status,
      isValid,
      authState,
    ];
  }

  factory SignInState.initial() => const SignInState();

  SignInState copyWith({
    Email? email,
    PasswordValidator? password,
    PasswordValidator? currentPassword,
    PasswordValidator? newPassword,
    PasswordValidator? newConfirmPassword,
    FormzSubmissionStatus? status,
    bool? isValid,
    AuthState? authState,
  }) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      currentPassword: currentPassword ?? this.currentPassword,
      newPassword: newPassword ?? this.newPassword,
      newConfirmPassword: newConfirmPassword ?? this.newConfirmPassword,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      authState: authState ?? this.authState,
    );
  }
}
