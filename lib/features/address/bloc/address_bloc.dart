// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/features/address/model/address_model.dart';
import 'package:e_commerce_app/features/address/repo/address_repo.dart';
import 'package:e_commerce_app/features/shipping/repo/shipping_repo.dart';
import 'package:meta/meta.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressBloc() : super(AddressInitialState()) {
    on<AddressFetchAddressEvent>(addressFetchAddressEvent);
    on<AddressNavigateToAddAddressPageEvent>(
        addressNavigateToAddAddressPageEvent);
    on<AddressAddNewAddressEvent>(addressAddNewAddressEvent);
    on<AddressAddNewAddressInvalidEvent>(addressAddNewAddressInvalidEvent);
    on<AddressDeleteAddressEvent>(addressDeleteAddressEvent);
    on<AddressEditAddressEvent>(addressEditAddressEvent);
    on<AddressEditBottomSheetEvent>(addressEditBottomSheetEvent);
    on<AddressOnTapAddressTileEvent>(addressOnTapAddressTileEvent);
  }

  final addressRepo = AddressRepo();
  final shippingRepo = ShippingRepo();

  FutureOr<void> addressFetchAddressEvent(
      AddressFetchAddressEvent event, Emitter<AddressState> emit) async {
    emit(AddressLoadingState());
    final addressList = await addressRepo.getAddressList();
    addressList.isNotEmpty
        ? emit(AddressLoadedState(addresses: addressList))
        : emit(AddressListEmptyState());
  }

  FutureOr<void> addressNavigateToAddAddressPageEvent(
      AddressNavigateToAddAddressPageEvent event, Emitter<AddressState> emit) {
    emit(AddressNavigateToAddAddressPageActionState());
  }

  FutureOr<void> addressAddNewAddressEvent(
      AddressAddNewAddressEvent event, Emitter<AddressState> emit) async {
    await addressRepo.addNewAddress(event.address);
    emit(AddressAddNewAddressSuccessfulActionState());
  }

  FutureOr<void> addressAddNewAddressInvalidEvent(
      AddressAddNewAddressInvalidEvent event, Emitter<AddressState> emit) {
    emit(AddressAddNewAddressInvalidActionState());
  }

  FutureOr<void> addressDeleteAddressEvent(
      AddressDeleteAddressEvent event, Emitter<AddressState> emit) async {
    // Delete the address
    emit(AddressLoadingState());
    await addressRepo.deleteAddress(event.address);
    final addressList = await addressRepo.getAddressList();
    emit(AddressLoadedState(addresses: addressList));
  }

  FutureOr<void> addressEditAddressEvent(
      AddressEditAddressEvent event, Emitter<AddressState> emit) async {
    //Update the address
    emit(AddressLoadingState());
    await addressRepo.editAddress(event.updatedAddress, event.previousAddress);
    final addressList = await addressRepo.getAddressList();
    emit(AddressLoadedState(addresses: addressList));
  }

  FutureOr<void> addressEditBottomSheetEvent(
      AddressEditBottomSheetEvent event, Emitter<AddressState> emit) {
    //Show Bottom Sheet for editing
    emit(AddressEditAddressBottomSheetActionState(
      address: event.address,
    ));
  }

  FutureOr<void> addressOnTapAddressTileEvent(
      AddressOnTapAddressTileEvent event, Emitter<AddressState> emit) async {
    await shippingRepo.updateSelectedAddress(event.address);
    final addressList = await addressRepo.getAddressList();
    emit(AddressLoadedState(addresses: addressList));
  }
}
