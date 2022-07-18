import 'package:boat_rent/data/boats_data.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../constants.dart';
import '../widgets/widgets.dart';
import 'home_page_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late PageController pageController;
  late AnimationController animationController;

  double rotation = 0;
  double scrollStartAt = 0;
  bool flagInit = false;
  double pageValue = 0.0;
  int currentPage = 0;

  @override
  void initState() {
    pageController = PageController(viewportFraction: 0.43)
      ..addListener(() {
        for (pageValue = pageController.page!; pageValue > 1;) {
          (pageValue--);
        }
        currentPage = pageController.page!.truncate();
        double dy = pageController.offset - scrollStartAt;
        setState(() {
          rotation = dy / 100;
          if (rotation > 1) {
            rotation = 1;
          } else if (rotation < -1) {
            rotation = -1;
          }
        });
      });

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    animationController.addListener(() {
      setState(() {
        rotation = animationController.value;
      });
    });
    initializeColor();
    super.initState();
  }

 Future initializeColor() async {
    for (int i = 0; i < boats.length; i++) {
      PaletteGenerator colors =
          await PaletteGenerator.fromImageProvider(AssetImage(boats[i].image));
      boats[i].background = colors.dominantColor!.color.withOpacity(1);
      boats[i].textTitleColor = colors.dominantColor!.bodyTextColor;
      boats[i].textPriceColor = colors.dominantColor!.titleTextColor;
    }
    setState(() {
      flagInit = true;
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    if (!flagInit) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: size.height * 0.3,
            bottom: 0,
            left: 0,
            right: 0,
            child: NotificationListener(
              onNotification: (notification) {
                if (notification is ScrollEndNotification) {
                  animationController.reverse(from: rotation.abs());
                }
                if (notification is ScrollStartNotification) {
                  scrollStartAt = pageController.offset;
                }
                return true;
              },
              child: PageView.builder(
                padEnds: false,
                physics: const BouncingScrollPhysics(),
                controller: pageController,
                scrollDirection: Axis.vertical,
                itemCount: boats.length,
                itemBuilder: (BuildContext context, int index) {
                  return VisibilityDetector(
                      key: Key(boats[index].image),
                      onVisibilityChanged: (info) {
                        if (info.visibleFraction < 0.9 && pageValue > 0.1) {
                          boats[index].trigger = false;
                        } else {
                          boats[index].trigger = true;
                        }
                      },
                      child: AnimatedScale(
                        duration: const Duration(milliseconds: 400),
                        scale: boats[index].trigger
                            ? 1
                            : currentPage != index
                                ? 1
                                : 0,
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 200),
                          opacity: boats[index].trigger
                              ? 1
                              : currentPage != index
                                  ? 1
                                  : 0,
                          child: BoatCard(
                            index: index,
                            rotation: rotation,
                          ),
                        ),
                      ));
                },
              ),
            ),
          ),
          const TopMenu(),
          Positioned(
            left: marginPadding,
            top: MediaQuery.of(context).padding.top + 75,
            child: const Text('Rent a Boat',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.w300)),
          ),
          Positioned(
              left: marginPadding,
              right: marginPadding,
              top: MediaQuery.of(context).padding.top + 120,
              child: const CustomFieldText()),
        ],
      ),
    );
  }
}


