// ignore_for_file: type_literal_in_constant_pattern

import 'dart:developer';

import 'package:e_commerce_app/features/address/model/address_model.dart';
import 'package:e_commerce_app/features/cart/model/cart_model.dart';
import 'package:e_commerce_app/features/credit_debit_card/model/card_model.dart';
import 'package:e_commerce_app/features/home/model/product_model.dart';
import 'package:e_commerce_app/features/place_order/bloc/place_order_bloc.dart';
import 'package:e_commerce_app/features/place_order/model/order_model.dart';
import 'package:e_commerce_app/features/place_order/ui/pages/order_success_page.dart';
import 'package:e_commerce_app/features/product_detail/ui/widgets/custom_button.dart';
import 'package:e_commerce_app/helper/helper_functions.dart';
import 'package:e_commerce_app/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class PlaceOrderPage extends StatefulWidget {
  final ProductModel? productModel;
  const PlaceOrderPage({super.key, this.productModel});

  @override
  State<PlaceOrderPage> createState() => _PlaceOrderPageState();
}

class _PlaceOrderPageState extends State<PlaceOrderPage> {
  final placeOrderBloc = PlaceOrderBloc();
  @override
  void initState() {
    placeOrderBloc.add(PlaceOrderFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Order Review",
          style: MyTextThemes.myTextTheme().titleMedium,
        ),
        backgroundColor: Colors.white,
      ),
      body: BlocConsumer<PlaceOrderBloc, PlaceOrderState>(
        bloc: placeOrderBloc,
        listenWhen: (previous, current) => current is PlaceOrderActionState,
        buildWhen: (previous, current) => current is! PlaceOrderActionState,
        listener: (context, state) {
          if (state is PlaceOrderNavigateToOrderSuccessPageActionState) {
            HelperFunctions.pushReplacementNavigateToScreenUpDownAnimation(
              context,
              OrderSuccessPage(),
            );
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case PlaceOrderLoadingState:
              return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: AppColors.backgroundColor.withOpacity(0.7),
                  strokeCap: StrokeCap.round,
                ),
              );
            case PlaceOrderLoadedState:
              final productModel = widget.productModel;
              List<CartModel> cartProducts =
                  (state as PlaceOrderLoadedState).cartList;
              CreditDebitCardModel card = state.cardModel;
              AddressModel address = state.address;
              double itemsPriceTotal = 0;
              int productQuantity = 1;
              for (var i = 0; i < cartProducts.length; i++) {
                productQuantity += cartProducts[i].totalItemCount!;
                itemsPriceTotal += cartProducts[i].price * productQuantity;
              }
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.sizeOf(context).height * 0.75,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade400),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  productModel != null
                                      ? "Items(1)"
                                      : "Items($productQuantity)",
                                  style: TextStyle(
                                    color: AppColors.blueGray300,
                                    fontSize: 15,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  productModel != null
                                      ? "\$${productModel.price}"
                                      : "\$$itemsPriceTotal",
                                  style: MyTextThemes.myTextTheme().labelSmall,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Shipping",
                                  style: TextStyle(
                                    color: AppColors.blueGray300,
                                    fontSize: 15,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  "\$40.00",
                                  style: MyTextThemes.myTextTheme().labelSmall,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Import Charges",
                                  style: TextStyle(
                                    color: AppColors.blueGray300,
                                    fontSize: 15,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  "\$116.00",
                                  style: MyTextThemes.myTextTheme().labelSmall,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Order Total",
                                  style: TextStyle(
                                    color: MyColorSchemes
                                        .primaryColorScheme.onPrimary
                                        .withOpacity(1),
                                    fontSize: 15,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  productModel != null
                                      ? "\$${(productModel.price + 40 + 116).round()}.00"
                                      : "\$${(itemsPriceTotal + 40 + 116).round()}.00",
                                  style: TextStyle(
                                    color: MyColorSchemes
                                        .primaryColorScheme.primary
                                        .withOpacity(1),
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Divider(),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Payment Method",
                              style: MyTextThemes.myTextTheme().titleMedium,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            CreditCardWidget(
                              padding: 0,
                              height: 180,
                              cardNumber: card.cardNumber,
                              expiryDate: card.expiryDate,
                              cardHolderName: card.cardHolderName,
                              cvvCode: card.cvvCode,
                              showBackView: false,
                              onCreditCardWidgetChange: (p0) {},
                              bankName: card.bankName,
                              isHolderNameVisible: true,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Shipping Address",
                              style: MyTextThemes.myTextTheme().titleMedium,
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            Text(
                              address.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Poppins",
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              address.phoneNumber,
                              style: const TextStyle(
                                fontSize: 16,
                                fontFamily: "Poppins",
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              address.address,
                              style: const TextStyle(
                                fontSize: 16,
                                fontFamily: "Poppins",
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    CustomButton(
                      heading: "Place Order",
                      onTap: () {
                        placeOrderBloc.add(PlaceOrderButtonClickedEvent(
                          orderModel: OrderModel(
                            orderId:
                                "#${DateTime.now().millisecondsSinceEpoch.remainder(100000)}",
                            itemsOrdered: productModel != null
                                ? [
                                    CartModel(
                                      stars: productModel.stars,
                                      price: productModel.price,
                                      listPrice: productModel.listPrice,
                                      totalItemCount: 1,
                                      asin: productModel.asin,
                                      title: productModel.title,
                                      reviews: productModel.reviews,
                                      imgUrl: productModel.imgUrl,
                                      category_id: productModel.category_id,
                                      productURL: productModel.productURL,
                                      isBestSeller: productModel.isBestSeller,
                                      boughtInLastMonth:
                                          productModel.boughtInLastMonth,
                                    )
                                  ]
                                : cartProducts,
                            orderedAt: DateTime.now().toString(),
                            address: address,
                            payment: card,
                          ),
                        ));
                        log("Order Model ${OrderModel(
                          orderId:
                              "#${DateTime.now().millisecondsSinceEpoch.remainder(100000)}",
                          itemsOrdered: productModel != null
                              ? [
                                  CartModel(
                                    stars: productModel.stars,
                                    price: productModel.price,
                                    listPrice: productModel.listPrice,
                                    totalItemCount: 1,
                                    asin: productModel.asin,
                                    title: productModel.title,
                                    reviews: productModel.reviews,
                                    imgUrl: productModel.imgUrl,
                                    category_id: productModel.category_id,
                                    productURL: productModel.productURL,
                                    isBestSeller: productModel.isBestSeller,
                                    boughtInLastMonth:
                                        productModel.boughtInLastMonth,
                                  )
                                ]
                              : cartProducts,
                          orderedAt: DateTime.now().toString(),
                          address: address,
                          payment: card,
                        )}");
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              );
            case PlaceOrderErrorState:
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
}
