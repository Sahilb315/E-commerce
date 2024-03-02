part of 'shipping_bloc.dart';

@immutable
sealed class ShippingEvent {}

class ShippingFetchEvent extends ShippingEvent {}

class ShippingAddAddressEvent extends ShippingEvent {
  final AddressModel address;
  ShippingAddAddressEvent({required this.address});
}

class ShippingDeleteAddressEvent extends ShippingEvent {
  final AddressModel address;
  ShippingDeleteAddressEvent({required this.address});
}

class ShippingEditAddressEvent extends ShippingEvent {
  final AddressModel updateAddress;
  final AddressModel oldAddress;
  ShippingEditAddressEvent(
      {required this.oldAddress, required this.updateAddress});
}

class ShippingEditBottomSheetEvent extends ShippingEvent {
  final AddressModel address;
  ShippingEditBottomSheetEvent({required this.address});
}

class ShippingOnTapAddressTileEvent extends ShippingEvent{
  final AddressModel address;

  ShippingOnTapAddressTileEvent({required this.address});
}

class ShippingNavigateToAddNewAddressPageEvent extends ShippingEvent {}

class ShippingNavigateToPaymentPageEvent extends ShippingEvent {}

class ShippingNewAddressInvalidTypeEvent extends ShippingEvent {}
