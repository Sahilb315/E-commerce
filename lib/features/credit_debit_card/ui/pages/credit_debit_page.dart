// ignore_for_file: type_literal_in_constant_pattern

import 'package:e_commerce_app/features/credit_debit_card/bloc/credit_debit_card_bloc.dart';
import 'package:e_commerce_app/features/credit_debit_card/ui/pages/add_credit_debit_card_page.dart';
import 'package:e_commerce_app/helper/helper_functions.dart';
import 'package:e_commerce_app/utils/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class CreditDebitPage extends StatefulWidget {
  const CreditDebitPage({super.key});

  @override
  State<CreditDebitPage> createState() => _CreditDebitPageState();
}

class _CreditDebitPageState extends State<CreditDebitPage> {
  final cardBloc = CreditDebitCardBloc();

  @override
  void initState() {
    cardBloc.add(CreditDebitFetchCardsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Your Cards",
          style: MyTextThemes.myTextTheme().titleMedium,
        ),
        actions: [
          /// To obscure the card details
          // IconButton(
          //   onPressed: () {},
          //   icon: const Icon(Icons.credit_card_off_rounded),
          // ),
          IconButton(
            onPressed: () {
              cardBloc.add(CreditDebitNavigateToAddNewCardPageEvent());
            },
            icon: Icon(
              CupertinoIcons.add,
              color: AppColors.backgroundColor,
            ),
          ),
        ],
      ),
      body: BlocConsumer<CreditDebitCardBloc, CreditDebitCardState>(
        bloc: cardBloc,
        listener: (context, state) {
          if (state is CreditDebitNavigateToAddNewCardPageActionState) {
            HelperFunctions.pushReplacementNavigateToScreenUpDownAnimation(
              context,
              AddCreditDebitCardPage(),
            );
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case CreditCardLoadingState:
              return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: AppColors.backgroundColor.withOpacity(0.7),
                  strokeCap: StrokeCap.round,
                ),
              );
            case CreditCardLoadedState:
              final cardsList = (state as CreditCardLoadedState).cardsList;
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cardsList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: GestureDetector(
                            onTap: () {
                              cardBloc.add(CreditDebitUpdateCardEvent(
                                cardModel: cardsList[index],
                              ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: cardsList[index].isSelected
                                      ? AppColors.backgroundColor
                                      : Colors.grey.shade300,
                                  width: cardsList[index].isSelected ? 1.5 : 1,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: CreditCardWidget(
                                cardNumber: cardsList[index].cardNumber,
                                expiryDate: cardsList[index].expiryDate,
                                cardHolderName: cardsList[index].cardHolderName,
                                cvvCode: cardsList[index].cvvCode,
                                showBackView: true,
                                onCreditCardWidgetChange: (creditCardModel) {},
                                bankName: cardsList[index].bankName,
                                isHolderNameVisible: true,
                                obscureCardCvv: true,
                                obscureCardNumber: true,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            case CreditCardErrorState:
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
