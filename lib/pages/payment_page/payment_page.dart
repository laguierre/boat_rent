import 'package:boat_rent/models/provider_models.dart';
import 'package:boat_rent/pages/checkout_page/checkout_page.dart';
import 'package:boat_rent/pages/payment_page/payment_page_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/boats_data.dart';
import '../constants.dart';
import '../widgets/widgets.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage>
    with TickerProviderStateMixin {
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
    var size = MediaQuery.of(context).size;
    var index = Provider.of<OpacityListItem>(context).index;

    return Scaffold(
      body: Stack(
        children: [
          CustomAnimatedContainer(
            animation: animation,
            size: size,
            index: index,
            isBooking: false,
          ),
          BoatNameAndQuantity(animation: animation, size: size, index: index),
          BoatDescription(animation: animation, size: size),
          RentBoatButton(animation: animation, index: index),
          const TopMenu(isBackIcon: true, isBooking: false),
        ],
      ),
    );
  }
}
