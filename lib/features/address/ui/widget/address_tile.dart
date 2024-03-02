import 'package:e_commerce_app/features/address/model/address_model.dart';
import 'package:e_commerce_app/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AddressTile extends StatelessWidget {
  final AddressModel addressModel;
  final void Function() onEditTap;
  final void Function() onDeleteTap;
  final void Function() onAddressTap;

  const AddressTile(
      {super.key,
      required this.addressModel,
      required this.onEditTap,
      required this.onDeleteTap,
      required this.onAddressTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GestureDetector(
        onTap: onAddressTap,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            border: Border.all(
              color: addressModel.isSelected
                  ? AppColors.backgroundColor
                  : Colors.grey.shade300,
              width: addressModel.isSelected ? 1.5 : 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              Text(
                addressModel.name,
                style: MyTextThemes.myTextTheme().titleSmall,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                addressModel.address,
                style: TextStyle(
                  color: AppColors.blueGray300,
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                addressModel.phoneNumber,
                style: TextStyle(
                  color: AppColors.blueGray300,
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: onEditTap,
                    child: Text(
                      "Edit",
                      style: TextStyle(
                        color: MyColorSchemes.primaryColorScheme.primary
                            .withOpacity(1),
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  GestureDetector(
                    onTap: onDeleteTap,
                    child: Text(
                      "Delete",
                      style: TextStyle(
                        color: AppColors.pink300,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
