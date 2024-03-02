// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'shipping_bloc.dart';

@immutable
sealed class ShippingState {}

abstract class ShippingActionState extends ShippingState {}

final class ShippingInitial extends ShippingState {}

class ShippingLoadingState extends ShippingState {}

class ShippingLoadedState extends ShippingState {
  final List<AddressModel> addresses;

  ShippingLoadedState({required this.addresses});
}

class ShippingErrorState extends ShippingState {}

class ShippingEmptyAddressListState extends ShippingState {}

class ShippingEditAddressBottomSheetActionState extends ShippingActionState {
  final AddressModel address;

  ShippingEditAddressBottomSheetActionState({required this.address});
}

class ShippingNavigateToPaymentPageActionState extends ShippingActionState {}

class ShippingAddressEditedSuccessfullyActionState
    extends ShippingActionState {}

class ShippingNavigateToAddNewAddressPageActionState
    extends ShippingActionState {}

class ShippingNewAddressAddedSuccessfullyActionState
    extends ShippingActionState {}

class ShippingNewAddressInvalidTypeActionState extends ShippingActionState {}
