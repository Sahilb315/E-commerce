// ignore_for_file: type_literal_in_constant_pattern

import 'package:e_commerce_app/features/home/model/product_model.dart';
import 'package:e_commerce_app/features/home/ui/widgets/product_tile.dart';
import 'package:e_commerce_app/features/product_detail/ui/product_details_page.dart';
import 'package:e_commerce_app/features/search/bloc/search_bloc.dart';
import 'package:e_commerce_app/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchPage extends StatelessWidget {
  final List<ProductModel> products;
  SearchPage({
    super.key,
    required this.products,
  });

  final searchController = TextEditingController();
  final List<ProductModel> searchedProducts = [];
  final searchBloc = SearchBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: SizedBox(
          height: 45,
          child: TextFormField(
            controller: searchController,
            textAlignVertical: TextAlignVertical.top,
            autofocus: true,
            style: TextStyle(
              color: Colors.grey.shade500,
              fontWeight: FontWeight.w600,
            ),
            cursorColor: AppColors.backgroundColor.withOpacity(0.7),
            decoration: InputDecoration(
              labelText: "Search Products",
              labelStyle: TextStyle(
                color: Colors.grey.shade500,
                fontWeight: FontWeight.w400,
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  searchController.clear();
                },
                icon: Icon(
                  Icons.clear,
                  color: AppColors.blueGray300,
                ),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            onFieldSubmitted: (value) {
              searchedProducts.clear();
              for (var element in products) {
                if (element.title!
                    .toLowerCase()
                    .contains(value.toLowerCase())) {
                  if (searchedProducts.contains(element)) return;
                  searchedProducts.add(element);
                }
              }
              searchBloc.add(SearchTextFieldSubmittedEvent(
                searchedProducts: searchedProducts,
              ));
            },
          ),
        ),
      ),
      body: BlocConsumer<SearchBloc, SearchState>(
        bloc: searchBloc,
        listenWhen: (previous, current) => current is SearchActionState,
        buildWhen: (previous, current) => current is! SearchActionState,
        listener: (context, state) {
          if (state is SearchNavigateToProductDetailsPageActionState) {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    ProductDetailsPage(
                  productModel: state.product,
                ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  var begin = const Offset(1.0, 0.0);
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
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case SearchInitialState:
              return const SizedBox();
            case SearchResultsLoadingState:
              return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: AppColors.backgroundColor.withOpacity(0.7),
                  strokeCap: StrokeCap.round,
                ),
              );
            case SearchResultsState:
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 8,
                    mainAxisExtent: MediaQuery.sizeOf(context).height * 0.3,
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                  ),
                  itemCount: searchedProducts.length,
                  itemBuilder: (context, index) {
                    return ProductTile(
                      onTap: () {
                        searchBloc.add(
                          SearchNavigateToProductDetailsPageEvent(
                            product: searchedProducts[index],
                          ),
                        );
                      },
                      productModel: searchedProducts[index],
                    );
                  },
                ),
              );
            case SearchNoResultsFoundState:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/cross.svg",
                      height: 80,
                    ),
                    Text(
                      "Product Not Found",
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              );

            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
