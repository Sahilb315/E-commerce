// ignore_for_file: type_literal_in_constant_pattern

import 'package:e_commerce_app/features/address/bloc/address_bloc.dart';
import 'package:e_commerce_app/features/address/model/address_model.dart';
import 'package:e_commerce_app/features/address/ui/pages/add_address_account_page.dart';
import 'package:e_commerce_app/features/address/ui/widget/address_text_field.dart';
import 'package:e_commerce_app/features/address/ui/widget/address_tile.dart';
import 'package:e_commerce_app/features/product_detail/ui/widgets/custom_button.dart';
import 'package:e_commerce_app/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final addressBloc = AddressBloc();
  @override
  void initState() {
    addressBloc.add(AddressFetchAddressEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text(
          "Address",
          style: MyTextThemes.myTextTheme().titleMedium,
        ),
      ),
      bottomNavigationBar: Container(
        height: MediaQuery.sizeOf(context).height * 0.1,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Column(
            children: [
              CustomButton(
                heading: "Add Address",
                onTap: () {
                  addressBloc.add(AddressNavigateToAddAddressPageEvent());
                },
              ),
            ],
          ),
        ),
      ),
      body: BlocConsumer<AddressBloc, AddressState>(
        bloc: addressBloc,
        listenWhen: (previous, current) => current is AddressActionState,
        buildWhen: (previous, current) => current is! AddressActionState,
        listener: (context, state) {
          if (state is AddressNavigateToAddAddressPageActionState) {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    AddAddressAccountPage(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  var begin = const Offset(0.0, 1.0);
                  var end = Offset.zero;
                  var curve = Curves.easeIn;

                  var tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));
                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                },
              ),
            );
          } else if (state is AddressEditAddressBottomSheetActionState) {
            final address = state.address;

            final nameController = TextEditingController(text: address.name);
            final phoneNumberController =
                TextEditingController(text: address.phoneNumber);
            final addressController =
                TextEditingController(text: address.address);

            editAccountAddressBottomSheet(context, nameController,
                phoneNumberController, addressController, address);
          } else if (state is AddressAddNewAddressInvalidActionState) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Please fill all the fields"),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 1),
              ),
            );
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case AddressLoadingState:
              return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: AppColors.backgroundColor.withOpacity(0.7),
                  strokeCap: StrokeCap.round,
                ),
              );
            case AddressListEmptyState:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      height: 80,
                      "assets/address.svg",
                    ),
                    Text(
                      "No Address added...",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 20,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              );
            case AddressLoadedState:
              final addressList = (state as AddressLoadedState).addresses;
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: addressList.length,
                      itemBuilder: (context, index) {
                        return AddressTile(
                          addressModel: addressList[index],
                          onDeleteTap: () {
                            addressBloc.add(AddressDeleteAddressEvent(
                              address: addressList[index],
                            ));
                          },
                          onEditTap: () {
                            addressBloc.add(AddressEditBottomSheetEvent(
                              address: addressList[index],
                            ));
                          },
                          onAddressTap: () {
                            addressBloc.add(AddressOnTapAddressTileEvent(
                              address: addressList[index],
                            ));
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            case AddressErrorState:
              return const Center(
                child: Text("Error..."),
              );
            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Future<void> editAccountAddressBottomSheet(
      BuildContext context,
      TextEditingController nameController,
      TextEditingController phoneNumberController,
      TextEditingController addressController,
      AddressModel address) {
    return showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.55,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      AddressTextField(
                        hintText: "Name",
                        controller: nameController,
                        showNumberTypeKeyboard: false,
                        showPhoneNumberTypeKeyboard: false,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AddressTextField(
                        hintText: "Phone Number",
                        controller: phoneNumberController,
                        showNumberTypeKeyboard: false,
                        showPhoneNumberTypeKeyboard: false,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AddressTextField(
                        hintText: "Address",
                        controller: addressController,
                        showNumberTypeKeyboard: false,
                        showPhoneNumberTypeKeyboard: false,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                        heading: "Update Address",
                        onTap: () {
                          if (nameController.text.isEmpty ||
                              phoneNumberController.text.isEmpty ||
                              addressController.text.isEmpty) {
                            addressBloc.add(AddressAddNewAddressInvalidEvent());
                            return;
                          }
                          addressBloc.add(
                            AddressEditAddressEvent(
                              updatedAddress: AddressModel(
                                name: nameController.text,
                                phoneNumber: phoneNumberController.text,
                                address: addressController.text,
                                isSelected: false,
                              ),
                              previousAddress: address,
                            ),
                          );
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}


///  If want to display the snackbar that tells the user that the fields are empty then use this but in this the when the focus is on the textfield
///  the keyboard will be displayed above the bottomsheet and the bottomsheet will not be displayed on top of the keyboard.
/// SizedBox(
//   height: MediaQuery.sizeOf(context).height * 0.55,
//   child: Scaffold(
//     backgroundColor: Colors.white,
//     body: SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.all(8),
//         child: Container(
//           padding: EdgeInsets.only(
//             bottom: MediaQuery.of(context).viewInsets.bottom,
//           ),
//           child: Column(
//             children: [
//               const SizedBox(
//                 height: 15,
//               ),
//               AddressTextField(
//                 hintText: "Name",
//                 controller: nameController,
//                 showNumberTypeKeyboard: false,
//                 showPhoneNumberTypeKeyboard: false,
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               AddressTextField(
//                 hintText: "Phone Number",
//                 controller: phoneNumberController,
//                 showNumberTypeKeyboard: false,
//                 showPhoneNumberTypeKeyboard: false,
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               AddressTextField(
//                 hintText: "Address",
//                 controller: addressController,
//                 showNumberTypeKeyboard: false,
//                 showPhoneNumberTypeKeyboard: false,
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               CustomButton(
//                 heading: "Update Address",
//                 onTap: () {
//                   if (nameController.text.isEmpty ||
//                       phoneNumberController.text.isEmpty ||
//                       addressController.text.isEmpty) {
//                     addressBloc.add(
//                         AddressAddNewAddressInvalidEvent());
//                     return;
//                   }
//                   addressBloc.add(
//                     AddressEditAddressEvent(
//                       address: AddressModel(
//                         name: nameController.text,
//                         phoneNumber: phoneNumberController.text,
//                         address: addressController.text,
//                         isSelected: false,
//                       ),
//                     ),
//                   );
//                 },
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//             ],
//           ),
//         ),
//       ),
//     ),
//   ),
// );