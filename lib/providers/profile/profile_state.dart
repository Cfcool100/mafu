part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.firstName = const Name.pure(),
    this.lastName = const Name.pure(),
    this.phoneNumber = const PhoneNumber.pure(),
    this.file,
    this.pathName,
    this.picture,
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.user,
  });

  final XFile? file;
  final String? pathName;
  final String? picture;
  final PhoneNumber phoneNumber;
  final Name firstName, lastName;
  final FormzSubmissionStatus status;
  final bool isValid;
  final UserModel? user;

  @override
  List<Object?> get props {
    return [
      file,
      pathName,
      picture,
      firstName,
      lastName,
      phoneNumber,
      status,
      isValid,
      user,
    ];
  }

  factory ProfileState.initial() => const ProfileState();

  ProfileState copyWith({
    XFile? file,
    String? pathName,
    String? picture,
    Name? firstName,
    Name? lastName,
    PhoneNumber? phoneNumber,
    FormzSubmissionStatus? status,
    bool? isValid,
    UserModel? user,
  }) {
    return ProfileState(
      file: file ?? this.file,
      pathName: pathName ?? this.pathName,
      picture: picture ?? this.picture,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      user: user ?? this.user,
    );
  }
}
