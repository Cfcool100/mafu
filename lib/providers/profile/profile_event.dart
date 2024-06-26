part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class PickedImageFromGallery extends ProfileEvent {}

class ProfileFirstNameChangedEvent extends ProfileEvent {
  const ProfileFirstNameChangedEvent(this.firstname);

  final String firstname;
}

class ProfilePhoneNumberChangedEvent extends ProfileEvent {
  const ProfilePhoneNumberChangedEvent(this.phoneNumber);

  final String phoneNumber;
}

class ProfileLastNameChangedEvent extends ProfileEvent {
  const ProfileLastNameChangedEvent(this.lastname);

  final String lastname;
}

class ProfileUpdateEvent extends ProfileEvent {
  const ProfileUpdateEvent();
}

class SubmitForm extends ProfileEvent {}
