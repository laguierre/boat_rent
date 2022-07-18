import 'package:boat_rent/pages/booking_page/booking_page.dart';
import 'package:boat_rent/pages/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'models/provider_models.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OpacityListItem()),
        ChangeNotifierProvider(create: (_) => BookingItemCount()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Boat Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: GoogleFonts.notoSans().fontFamily,
        ),
        home: HomePage(),
      ),
    );
  }
}
