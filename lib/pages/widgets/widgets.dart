import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/boats_data.dart';
import '../../models/provider_models.dart';
import '../constants.dart';

class CustomFieldText extends StatelessWidget {
  const CustomFieldText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      height: 45,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.withOpacity(0.5),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: const [
          Padding(
            padding: EdgeInsets.only(left: 8),
            child: Icon(
              Icons.search,
              color: Colors.grey,
              size: 20,
            ),
          ),
          Expanded(
            child: TextField(
              enabled: false,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Search",
                hintStyle: TextStyle(color: Colors.grey),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                isDense: true,
              ),
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class TopMenu extends StatelessWidget {
  const TopMenu({
    Key? key,
    this.isBackIcon = false,
    this.isBooking = true,
  }) : super(key: key);

  final bool isBackIcon;
  final bool isBooking;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 5,
      left: marginPadding - 5,
      right: marginPadding - 5,
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset(
                isBackIcon
                    ? 'lib/assets/icons/left-arrow.png'
                    : 'lib/assets/icons/hamburger.png',
                color: isBooking ? Colors.black : Colors.white),
          ),
          const Spacer(),
          IconButton(
              onPressed: () {},
              icon: Image.asset(
                'lib/assets/icons/user.png',
                color: isBooking ? Colors.black : Colors.white,
              )),
        ],
      ),
    );
  }
}

class CustomAnimatedContainer extends StatelessWidget {
  const CustomAnimatedContainer({
    Key? key,
    required this.animation,
    required this.size,
    required this.index,
    this.isBooking = true,
  }) : super(key: key);

  final Animation<double> animation;
  final Size size;
  final int index;
  final bool isBooking;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          top: isBooking
              ? size.height * (-0.65 * animation.value + 1)
              : size.height * (percentContainerBooking + (1 - animation.value)),
          child: Container(
            decoration: BoxDecoration(
                color: boats[index].background,
                borderRadius: BorderRadius.only(
                    topLeft: !isBooking
                        ? const Radius.circular(40) * (1 - animation.value)
                        : const Radius.circular(40),
                    topRight: !isBooking
                        ? const Radius.circular(40) * (1 - animation.value)
                        : const Radius.circular(40))),
          ),
        );
      },
    );
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

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {Key? key, required this.index, required this.onTap, required this.label})
      : super(key: key);
  final int index;
  final VoidCallback onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: index == -1 ? Colors.redAccent : Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.white,
              blurRadius: 20,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Text(
          label,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: index == -1 ? Colors.white : boats[index].background),
        ),
      ),
    );
  }
}
