import 'package:e_commerce_app/features/cart/model/cart_model.dart';
import 'package:e_commerce_app/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CartTile extends StatelessWidget {
  final CartModel cartProduct;
  const CartTile({
    super.key,
    required this.cartProduct,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(),
        ),
        // height: 100,
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
                          onPressed: () {},
                          icon: const Icon(Icons.delete_outline_rounded),
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
                          "\$${cartProduct.price.toString()}",
                          style: TextStyle(
                            color: AppColors.backgroundColor.withOpacity(0.7),
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                  Icons.remove_circle_outline_rounded),
                            ),
                            Text(cartProduct.totalItemCount.toString()),
                            IconButton(
                              onPressed: () {},
                              icon:
                                  const Icon(Icons.add_circle_outline_rounded),
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
