import 'package:boat_rent/pages/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3000));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.decelerate);
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return Positioned(
                  top: 0,
                  left: -50 * animation.value,
                  bottom: -100 * animation.value,
                  child: Image.asset(
                    'lib/assets/images/bg1.jpg',
                    fit: BoxFit.contain,
                  ));
            },
          ),
          AnimatedBuilder(
            animation: animation,
            builder: (_, __) {
              return Positioned(
                  left: 0,
                  right: 0,
                  bottom: 30 + 250,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 1000),
                    opacity: animation.value > 0.5? 1 : 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          'Order Number',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        Text(
                          '#12D347',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 35),
                        ),
                        SizedBox(height: 30),
                        Text(
                          'Your order confirmation has been\nsent to your email',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                  ));
            },
          ),
          Positioned(
            left: kPadding,
            right: kPadding,
            bottom: 30,
            child: RoundedButton(
              label: 'Check email',
              index: -1,
              onTap: () {},
            ),
          )
        ],
      ),
    );
  }
}
