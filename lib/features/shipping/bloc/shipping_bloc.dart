// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/features/address/model/address_model.dart';
import 'package:e_commerce_app/features/address/repo/address_repo.dart';
import 'package:e_commerce_app/features/shipping/repo/shipping_repo.dart';
import 'package:meta/meta.dart';

part 'shipping_event.dart';
part 'shipping_state.dart';

class ShippingBloc extends Bloc<ShippingEvent, ShippingState> {
  ShippingBloc() : super(ShippingInitial()) {
    on<ShippingFetchEvent>(shippingFetchEvent);
    on<ShippingAddAddressEvent>(shippingAddAddressEvent);
    on<ShippingDeleteAddressEvent>(shippingDeleteAddressEvent);
    on<ShippingEditAddressEvent>(shippingEditAddressEvent);
    on<ShippingNewAddressInvalidTypeEvent>(shippingNewAddressInvalidTypeEvent);
    on<ShippingEditBottomSheetEvent>(shippingEditBottomSheetEvent);
    on<ShippingNavigateToAddNewAddressPageEvent>(
        shippingNavigateToAddNewAddressPage);
    on<ShippingOnTapAddressTileEvent>(shippingOnTapAddressTileEvent);
    on<ShippingNavigateToPaymentPageEvent>(shippingNavigateToPaymentPageEvent);
  }

  final addressRepo = AddressRepo();
  final shippingRepo = ShippingRepo();

  FutureOr<void> shippingFetchEvent(
      ShippingFetchEvent event, Emitter<ShippingState> emit) async {
    emit(ShippingLoadingState());
    final addressList = await addressRepo.getAddressList();
    addressList.isEmpty
        ? emit(ShippingEmptyAddressListState())
        : emit(ShippingLoadedState(addresses: addressList));
  }

  FutureOr<void> shippingAddAddressEvent(
      ShippingAddAddressEvent event, Emitter<ShippingState> emit) async {
    await addressRepo.addNewAddress(event.address);
    emit(ShippingNewAddressAddedSuccessfullyActionState());
  }

  FutureOr<void> shippingDeleteAddressEvent(
      ShippingDeleteAddressEvent event, Emitter<ShippingState> emit) async {
    emit(ShippingLoadingState());
    await addressRepo.deleteAddress(event.address);
    final addressList = await addressRepo.getAddressList();
    addressList.isEmpty
        ? emit(ShippingEmptyAddressListState())
        : emit(ShippingLoadedState(addresses: addressList));
  }

  FutureOr<void> shippingEditAddressEvent(
      ShippingEditAddressEvent event, Emitter<ShippingState> emit) async {
    emit(ShippingLoadingState());
    await addressRepo.editAddress(event.updateAddress, event.oldAddress);
    final addressList = await addressRepo.getAddressList();
    emit(ShippingLoadedState(addresses: addressList));
  }

  FutureOr<void> shippingNewAddressInvalidTypeEvent(
      ShippingNewAddressInvalidTypeEvent event, Emitter<ShippingState> emit) {
    emit(ShippingNewAddressInvalidTypeActionState());
  }

  FutureOr<void> shippingEditBottomSheetEvent(
      ShippingEditBottomSheetEvent event, Emitter<ShippingState> emit) {
    emit(ShippingEditAddressBottomSheetActionState(address: event.address));
  }

  FutureOr<void> shippingNavigateToAddNewAddressPage(
      ShippingNavigateToAddNewAddressPageEvent event,
      Emitter<ShippingState> emit) {
    emit(ShippingNavigateToAddNewAddressPageActionState());
  }

  FutureOr<void> shippingOnTapAddressTileEvent(
      ShippingOnTapAddressTileEvent event, Emitter<ShippingState> emit) async {
    await shippingRepo.updateSelectedAddress(event.address);
    final addressList = await addressRepo.getAddressList();
    emit(ShippingLoadedState(addresses: addressList));
  }

  FutureOr<void> shippingNavigateToPaymentPageEvent(
      ShippingNavigateToPaymentPageEvent event, Emitter<ShippingState> emit) {
    emit(ShippingNavigateToPaymentPageActionState());
  }
}
