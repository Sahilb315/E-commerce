import 'package:e_commerce_app/features/cart/model/cart_model.dart';
import 'package:e_commerce_app/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CartTile extends StatelessWidget {
  final CartModel cartProduct;
  final void Function() onDeleteAllTap;
  final void Function() onDecrementTap;
  final void Function() onIncrementTap;
  const CartTile({
    super.key,
    required this.cartProduct, required this.onDeleteAllTap, required this.onDecrementTap, required this.onIncrementTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              height: 90,
              width: MediaQuery.sizeOf(context).width * 0.26,
              child: Image.network(
                cartProduct.imgUrl.toString(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.625,
                    // Title & Delete Button
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            cartProduct.title.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: MyColorSchemes.primaryColorScheme.onPrimary
                                  .withOpacity(1),
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: onDeleteAllTap,
                          icon: Icon(
                            Icons.delete_outline_rounded,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width *
                        0.625, // Price & Products Add & Decrease Button
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\$${cartProduct.price * cartProduct.totalItemCount}",
                          style: TextStyle(
                            color: AppColors.backgroundColor.withOpacity(0.7),
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: onDecrementTap,
                              icon: Icon(
                                Icons.remove_circle_outline_rounded,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            Text(cartProduct.totalItemCount.toString()),
                            IconButton(
                              onPressed: onIncrementTap,
                              icon: Icon(
                                Icons.add_circle_outline_rounded,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
