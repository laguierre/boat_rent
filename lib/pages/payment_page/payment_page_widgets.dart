import 'package:flutter/material.dart';

import '../../data/boats_data.dart';
import '../checkout_page/checkout_page.dart';
import '../constants.dart';
import '../widgets/widgets.dart';


class BoatNameAndQuantity extends StatelessWidget {
  const BoatNameAndQuantity({
    Key? key,
    required this.animation,
    required this.size,
    required this.index,
  }) : super(key: key);

  final Animation<double> animation;
  final Size size;
  final int index;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Positioned(
            left: 0.0,
            right: 0.0,
            bottom: (size.height * 0.3 - 200) + 530 * animation.value,
            child: Column(
              children: [
                Text(
                  boats[index].name,
                  style:
                  const TextStyle(color: Colors.white, fontSize: 35),
                ),
                const SizedBox(height: 20),
                CountContainer(index: index),
              ],
            ));
      },
    );
  }
}

class RentBoatButton extends StatelessWidget {
  const RentBoatButton({
    Key? key,
    required this.animation,
    required this.index,
  }) : super(key: key);

  final Animation<double> animation;
  final int index;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Positioned(
          left: kPadding,
          right: kPadding,
          bottom: 30,
          child: AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              opacity: animation.value > 0.8 ? 1 : 0,
              child: RoundedButton(
                  label: 'Rent a boat',
                  index: index,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CheckoutPage()));

                  })),
        );
      },
    );
  }
}

class BoatDescription extends StatelessWidget {
  const BoatDescription({
    Key? key,
    required this.animation,
    required this.size,
  }) : super(key: key);

  final Animation<double> animation;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Positioned(
          left: 0,
          right: 0,
          top: size.height * 0.34,
          bottom: 70,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            opacity: animation.value > 0.8 ? 1 : 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Description',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, \nsed do eiusmod tempor incididunt ut labore.',
                      style: TextStyle(color: Colors.white)),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DateBookingContainer(size: size),
                      const Spacer(),
                      DateBookingContainer(size: size),
                    ],
                  ),
                  const SizedBox(height: 30),
                  const RowDescriptionPrice(
                    title: 'Paddle',
                    cost: '\$28.50',
                  ),
                  const SizedBox(height: 5),
                  const RowDescriptionPrice(
                    title: 'Life Vest',
                    cost: '\$12.50',
                  ),
                  const SizedBox(height: 5),
                  const RowDescriptionPrice(
                    title: 'Pledge',
                    cost: '\$10.25',
                  ),
                  const Spacer(),
                  const RowDescriptionPrice(
                    title: 'Total',
                    cost: '\$51.75',
                    isTotal: true,
                  ),
                  const SizedBox(height: 30),
                  const Spacer(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}



class DateBookingContainer extends StatelessWidget {
  const DateBookingContainer({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      height: 50,
      width: size.width * 0.4,
      decoration: BoxDecoration(boxShadow: const [
        BoxShadow(
          color: Colors.white,
          blurRadius: 20,
          offset: Offset(0, 0),
        ),
      ], borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: const Text(
        'dd/mm/yyyyy',
        style: TextStyle(color: Colors.grey, fontSize: 18),
      ),
    );
  }
}

class RowDescriptionPrice extends StatelessWidget {
  const RowDescriptionPrice({
    Key? key,
    required this.title,
    required this.cost,
    this.isTotal = false,
  }) : super(key: key);
  final String title;
  final String cost;
  final bool isTotal;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        const Spacer(),
        Text(cost,
            style: TextStyle(
                color: Colors.white,
                fontSize: !isTotal ? 28 : 35,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
      ],
    );
  }
}