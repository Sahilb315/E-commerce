import 'package:e_commerce_app/features/home/model/product_model.dart';
import 'package:e_commerce_app/utils/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FavouriteTile extends StatelessWidget {
  final ProductModel productModel;
  final void Function() onTap;
  final void Function() onDeleteTap;
  const FavouriteTile({
    super.key,
    required this.productModel,
    required this.onTap,
    required this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        padding: const EdgeInsets.all(1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              height: 120,
              child: Image.network(
                productModel.imgUrl.toString(),
                scale: 3,
                fit: BoxFit.scaleDown,
              ),
            ),
            Text(
              productModel.title.toString(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color:
                    MyColorSchemes.primaryColorScheme.onPrimary.withOpacity(1),
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
              ),
            ),
            RatingBar.builder(
              itemPadding: const EdgeInsets.all(0),
              allowHalfRating: true,
              maxRating: 5,
              minRating: 1,
              ignoreGestures: true,
              onRatingUpdate: (value) {},
              initialRating:
                  double.parse(productModel.stars.toString()).toDouble(),
              itemBuilder: (context, index) => const Icon(
                Icons.star_rate_rounded,
                color: Colors.amber,
              ),
              itemSize: 20,
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "\$${productModel.price}",
              style: TextStyle(
                color: AppColors.backgroundColor.withOpacity(1),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Row(
              children: [
                Text(
                  productModel.listPrice == 0
                      ? ""
                      : "\$${productModel.listPrice}",
                  style: const TextStyle(
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                Text(
                  productModel.listPrice == 0
                      ? ""
                      : "  ${(((productModel.listPrice - productModel.price) / productModel.listPrice) * 100).round()}% off",
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: onDeleteTap,
                  icon: const Icon(CupertinoIcons.delete),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
