import 'package:boat_rent/pages/booking_page/booking_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/boats_data.dart';
import '../../models/provider_models.dart';
import '../constants.dart';
import 'dart:math' as math;

class BoatCard extends StatelessWidget {
  const BoatCard({Key? key, required this.index, required this.rotation})
      : super(key: key);
  final int index;
  final double rotation;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double sizeContainer = size.height * 0.27;
    double sizeCard = sizeContainer * 0.8;
    double sizeImage = sizeContainer * 0.40;
    const radiusCircular = 20.0;
    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateX(rotation * 0.8),
      alignment: FractionalOffset.center,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: marginPadding),
            height: sizeCard,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(2.5, 5),
                  blurRadius: 2,
                )
              ],
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(radiusCircular),
                topLeft: Radius.circular(radiusCircular),
                bottomLeft: Radius.circular(radiusCircular),
                bottomRight: Radius.circular(radiusCircular),
              ),
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    boats[index].background,
                    boats[index].background.withOpacity(0.85),
                  ]),
            ),
          ),
          Positioned(
              top: 80,
              right: 0,
              child: Transform.rotate(
                angle: 0.7,
                child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    height: sizeImage,
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                        blurRadius: 50,
                        offset: Offset(-20 * rotation, rotation),
                      ),
                    ]),
                    child: Image.asset(boats[index].image, fit: BoxFit.cover)),
              )),
          Positioned(
              top: 30,
              bottom: 10,
              right: 0,
              left: 80,
              child: Image.asset('lib/assets/images/black.png',
                  fit: BoxFit.contain)),
          if (boats[index].seats == 2)
            Positioned(
                top: 30,
                bottom: 10,
                right: 0,
                left: 60,
                child: Transform.rotate(
                  angle: 0.9,
                  child: Image.asset('lib/assets/images/red.png',
                      fit: BoxFit.contain),
                )),
          Positioned(
              left: 13 + marginPadding,
              bottom: 18,
              child: Text(
                boats[index].name,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w300),
              )),
          Positioned(
              left: 10 + marginPadding,
              bottom: 18 + 37,
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: Image.asset('lib/assets/icons/right-arrow.png',
                    height: 35, color: Colors.white),
                onPressed: () {
                  Provider.of<OpacityListItem>(context, listen: false).index =
                      index;
                  Provider.of<OpacityListItem>(context, listen: false).trigger =
                      true;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BookingPage()),
                  );
                },
              ))
        ],
      ),
    );
  }
}
