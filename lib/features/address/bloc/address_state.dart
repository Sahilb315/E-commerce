part of 'address_bloc.dart';

@immutable
sealed class AddressState {}

abstract class AddressActionState extends AddressState {}

final class AddressInitialState extends AddressState {}

class AddressLoadingState extends AddressState {}

class AddressLoadedState extends AddressState {
  final List<AddressModel> addresses;

  AddressLoadedState({required this.addresses});
}

class AddressErrorState extends AddressState {}

class AddressListEmptyState extends AddressState {}

class AddressEditAddressBottomSheetActionState extends AddressActionState {
  final AddressModel address;

  AddressEditAddressBottomSheetActionState({required this.address});
}

class AddressDeleteAddressSnackbarActionState extends AddressActionState {}

class AddressNavigateToAddAddressPageActionState extends AddressActionState {}

class AddressAddNewAddressInvalidActionState extends AddressActionState {}

class AddressAddNewAddressSuccessfulActionState extends AddressActionState {}
