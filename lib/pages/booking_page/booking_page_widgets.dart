import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import '../../data/boats_data.dart';
import '../../models/provider_models.dart';


class BoatNameAndCounter extends StatelessWidget {
  const BoatNameAndCounter({
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
        builder: (BuildContext context, Widget? child) {
          return Positioned(
              left: 0.0,
              right: 0.0,
              bottom: size.height * 0.3 * animation.value - 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    boats[index].name,
                    style: const TextStyle(
                        color: Colors.white, fontSize: 35),
                  ),
                  const SizedBox(height: 20),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: animation.value == 1.0 ? 1.0 : 0.0,
                    child: CountContainer(index: index),
                  )
                ],
              ));
        });
  }
}

class RedPaddle extends StatelessWidget {
  const RedPaddle({
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
        builder: (BuildContext context, Widget? child) {
          return Positioned(
            left: 0.0,
            right: 0.0,
            bottom: animation.value * size.height * 0.97 -
                500,
            child: Transform.scale(
              scale: animation.value * 1.3,
              child: Transform.rotate(
                angle: animation.value * math.pi-0.4,
                child: Opacity(
                  opacity: animation.value,
                  child: Image.asset(
                    'lib/assets/images/red.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          );
        });
  }
}

class BlackPaddle extends StatelessWidget {
  const BlackPaddle({
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
        builder: (BuildContext context, Widget? child) {
          return Positioned(
            left: 0.0,
            right: 0.0,
            bottom:
            animation.value * size.height * 0.97 - 500,
            child: Transform.scale(
              scale: animation.value * 1.3,
              child: Transform.rotate(
                angle: animation.value * math.pi / 2,
                child: Opacity(
                  opacity: animation.value,
                  child: Image.asset(
                    'lib/assets/images/black.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          );
        });
  }
}

class CountContainer extends StatelessWidget {
  const CountContainer({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    int count = Provider.of<BookingItemCount>(context).count;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 120),
      height: size.height * 0.07,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.white,
            blurRadius: 20,
            offset: Offset(0, 0),
          ),
        ],
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () {
                count =
                    Provider.of<BookingItemCount>(context, listen: false).count;
                if (count <= 1) {
                  Provider.of<BookingItemCount>(context, listen: false).count =
                  1;
                } else {
                  Provider.of<BookingItemCount>(context, listen: false).count--;
                }
              },
              icon: Icon(
                Icons.remove,
                color: boats[index].background,
                size: 30,
              )),
          Text(
            '$count',
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
          ),
          IconButton(
              onPressed: () {
                count = Provider.of<BookingItemCount>(context, listen: false)
                    .count++;
              },
              icon: Icon(
                Icons.add,
                color: boats[index].background,
                size: 30,
              )),
        ],
      ),
    );
  }
}
