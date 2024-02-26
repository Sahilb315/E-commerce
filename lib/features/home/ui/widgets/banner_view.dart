import 'dart:async';

import 'package:flutter/material.dart';

class HomeBannerView extends StatefulWidget {
  const HomeBannerView({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  State<HomeBannerView> createState() => _HomeBannerViewState();
}

class _HomeBannerViewState extends State<HomeBannerView> {
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    Timer.periodic(
      const Duration(seconds: 4),
      (Timer timer) {
        if (currentIndex < 2) {
          currentIndex++;
          widget.pageController.animateToPage(
            currentIndex,
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeIn,
          );
        } else {
          currentIndex = -1;
        }
      },
    );
  }

  @override
  void dispose() {
    widget.pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      onPageChanged: (index) {
        currentIndex = index;
      },
      controller: widget.pageController,
      children: [
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
                  "https://images.unsplash.com/flagged/photo-1556637640-2c80d3201be8?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8c25lYWtlcnxlbnwwfHwwfHx8MA%3D%3D",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
