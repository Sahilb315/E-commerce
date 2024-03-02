part of 'address_bloc.dart';

@immutable
sealed class AddressEvent {}

class AddressFetchAddressEvent extends AddressEvent {}

class AddressAddNewAddressEvent extends AddressEvent {
  final AddressModel address;

  AddressAddNewAddressEvent({required this.address});
}

class AddressAddNewAddressInvalidEvent extends AddressEvent {}

class AddressNavigateToAddAddressPageEvent extends AddressEvent {}

class AddressEditBottomSheetEvent extends AddressEvent {
  final AddressModel address;

  AddressEditBottomSheetEvent({required this.address});
}

class AddressEditAddressEvent extends AddressEvent {
  final AddressModel updatedAddress;
  final AddressModel previousAddress;

  AddressEditAddressEvent({
    required this.previousAddress,
    required this.updatedAddress,
  });
}

class AddressDeleteAddressEvent extends AddressEvent {
  final AddressModel address;

  AddressDeleteAddressEvent({required this.address});
}

class AddressOnTapAddressTileEvent extends AddressEvent {
  final AddressModel address;

  AddressOnTapAddressTileEvent({required this.address});
}
