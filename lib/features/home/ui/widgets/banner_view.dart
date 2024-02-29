import 'dart:async';

import 'package:e_commerce_app/utils/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeBannerView extends StatefulWidget {
  const HomeBannerView({
    super.key,
  });

  @override
  State<HomeBannerView> createState() => _HomeBannerViewState();
}

class _HomeBannerViewState extends State<HomeBannerView> {
  PageController pageController = PageController(initialPage: 0);
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    Timer.periodic(
      const Duration(seconds: 3),
      (Timer timer) {
        if (pageController.hasClients && currentIndex < 2) {
          currentIndex++;
          pageController.animateToPage(
            currentIndex,
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeIn,
          );
        }
        currentIndex = -1;
      },
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.sizeOf(context).width * 1,
          height: MediaQuery.sizeOf(context).height * 0.21,
          child: PageView(
            scrollDirection: Axis.horizontal,
            onPageChanged: (index) {
              currentIndex = index;
            },
            controller: pageController,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: const DecorationImage(
                      image: NetworkImage(
                        "https://images.unsplash.com/photo-1592296240415-b3400ad7adac?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8ZWxlY3Ryb25pY3MlMjBzdG9yZXxlbnwwfHwwfHx8MA%3D%3D",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: const DecorationImage(
                      image: NetworkImage(
                        "https://images.unsplash.com/photo-1602810318383-e386cc2a3ccf?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTI2fHxjbG90aGVzfGVufDB8fDB8fHww",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: const DecorationImage(
                      image: NetworkImage(
                        "https://images.unsplash.com/photo-1552066344-2464c1135c32?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mjd8fHNuZWFrZXJ8ZW58MHx8MHx8fDA%3D",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            height: 0,
            child: SmoothPageIndicator(
              effect: WormEffect(
                dotColor: AppColors.blueGray300.withOpacity(0.5),
                activeDotColor: AppColors.backgroundColor.withOpacity(0.6),
                dotHeight: 10,
                dotWidth: 10,
              ),
              controller: pageController,
              count: 3,
            ),
          ),
        ),
      ],
    );
  }
}
