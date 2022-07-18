import 'package:boat_rent/data/boats_data.dart';
import 'package:boat_rent/pages/payment_page/payment_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/provider_models.dart';
import '../widgets/widgets.dart';
import 'dart:math' as math;

import 'booking_page_widgets.dart';


class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  late PageController pageController;
  double pageValue = 0.0;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.decelerate);
    animationController.forward();
    pageController = PageController(
        initialPage: Provider.of<OpacityListItem>(context, listen: false).index)
      ..addListener(() {
        for (pageValue = pageController.page!; pageValue > 1;) {
          pageValue--;
        }
        if (pageValue >= 1) pageValue = 1;
        setState(() {});
      });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    int index = Provider.of<OpacityListItem>(context).index;
    return Scaffold(
      body: Stack(
        children: [
          CustomAnimatedContainer(
            animation: animation,
            size: size,
            index: index,
          ),
          PageView.builder(
              physics: const BouncingScrollPhysics(),
              reverse: true,
              scrollDirection: Axis.vertical,
              controller: pageController,
              itemCount: boats.length,
              onPageChanged: (page) {
                Provider.of<OpacityListItem>(context, listen: false).index =
                    page;
              },
              itemBuilder: (context, i) {
                int index =
                    Provider.of<OpacityListItem>(context, listen: false).index;
                return Opacity(
                  opacity: index == i
                      ? pageValue > 0.5
                          ? pageValue * pageValue
                          : 1 - pageValue
                      : 1 - pageValue,
                  child: Transform.scale(
                    scale: index == i
                        ? pageValue > 0.5
                            ? pageValue * pageValue
                            : 1 - pageValue
                        : 1 - pageValue,
                    child: GestureDetector(
                      onTap: () {
                        Provider.of<OpacityListItem>(context, listen: false)
                            .index = i;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PaymentPage()));
                      },
                      child: Stack(children: [
                        AnimatedBuilder(
                            animation: animation,
                            builder: (BuildContext context, Widget? child) {
                              return Positioned(
                                left: 0.0,
                                right: 0.0,
                                bottom:
                                    animation.value * size.height * 0.97 - 400,
                                child: Transform.scale(
                                  scale: animation.value * 1.3,
                                  child: Transform.rotate(
                                    angle: animation.value * math.pi / 2,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        boxShadow: const [
                                          BoxShadow(
                                            spreadRadius: 0,
                                            color: Colors.white,
                                            blurRadius: 70,
                                            offset: Offset(0, 0),
                                          ),
                                        ],
                                      ),
                                      child: Image.asset(
                                        boats[i].image,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                        BlackPaddle(animation: animation, size: size),
                        if (boats[i].seats == 2)
                          RedPaddle(animation: animation, size: size),
                      ]),
                    ),
                  ),
                );
              }),
          BoatNameAndCounter(animation: animation, size: size, index: index),
          const TopMenu(isBackIcon: true),
        ],
      ),
    );
  }
}
