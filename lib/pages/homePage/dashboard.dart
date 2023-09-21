import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kheloo/app_configs/app_assets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Dashboard extends StatefulWidget {
  static const routeName = "/dashboard";

  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final CarouselController _carouselController = CarouselController();
  int currentIndex = 0;
  int startingCount = 1000000;
  late Stream<int> countStream;
  int currentCount = 1000000;
  int _selectedIndex = 0;
  bool isExpanded = false;

  void toggleNameVisibility() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  final List<Color> itemColors = [Colors.blue, Colors.green, Colors.orange];
  static const List<Widget> _widgetOptions = <Widget>[
    Dashboard(),
    Text('Live Casino'),
    Text('Register'),
  ];
  List imageList = [
    {"id": 1, "image_path": AppAssets.slider1},
    {"id": 2, "image_path": AppAssets.slider2},
    {"id": 3, "image_path": AppAssets.slider3},
    {"id": 4, "image_path": AppAssets.slider4},
  ];

  final String videoUrl = "https://player.vimeo.com/759401631?h=27f2be5876";

  final Shader linearGradient = const LinearGradient(
    colors: <Color>[Color(0xffffd370), Color(0xfff7ad07)],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
  late VideoPlayerController controller;
  late ChewieController chewieController;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.networkUrl(Uri.parse(
        "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4"))
      ..initialize().then((value) => controller.play());
// Create a Stream that emits values starting from 10000 and incrementing by 1 every second
    countStream = Stream<int>.periodic(const Duration(seconds: 1), (count) {
      return startingCount + count;
    });

    // Listen to the stream and update the currentCount variable
    countStream.listen((count) {
      setState(() {
        currentCount = count;
      });
    });
    chewieController = ChewieController(
        videoPlayerController: controller, aspectRatio: 16 / 9);
  }

  @override
  void dispose() {
    controller.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: MyFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .centerDocked, // Specify the position here
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.asset(
          AppAssets.mainLogo,
          width: 90,
          height: 100,
        ),
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppAssets.promotionIcon,
                width: 25,
              ),
              Text(
                AppLocalizations.of(context)!.promotions,
                style: const TextStyle(
                    fontSize: 9,
                    color: Color(0xFFf6c859),
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFffd370),
                  Color(0xFFf7ad07),
                ],
              ),
            ),
            child: Center(child: Text(AppLocalizations.of(context)!.login)),
          )
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white, // Background color of the entire bar
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(children: [
          Expanded(
            child: Container(
              color: const Color(0xFFf4ad09),
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    AppAssets.support,
                    color: Colors.white,
                    width: 30,
                  ),
                  Text(
                    AppLocalizations.of(context)!.support,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    AppAssets.sports,
                    width: 30,
                  ),
                  Text(
                    AppLocalizations.of(context)!.sports,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    AppAssets.casino,
                    width: 30,
                  ),
                  Text(
                    AppLocalizations.of(context)!.liveCasino,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: const Color(0xFFf4ad09),
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    AppAssets.register,
                    color: Colors.white,
                    width: 30,
                  ),
                  Text(
                    AppLocalizations.of(context)!.register,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
        ]),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: imageList
                  .map(
                    (item) => Image.asset(
                      item['image_path'],
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  )
                  .toList(),
              carouselController: _carouselController,
              options: CarouselOptions(
                scrollPhysics: const BouncingScrollPhysics(),
                autoPlay: false,
                aspectRatio: 2,
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imageList.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _carouselController.animateToPage(entry.key),
                  child: Container(
                    width: 20,
                    height: currentIndex == entry.key ? 4 : 2,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 3.0,
                    ),
                    decoration: BoxDecoration(
                        color: currentIndex == entry.key
                            ? const Color(0xFFf4ad09)
                            : Colors.grey),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            Container(
              height: 50,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      AppAssets.langStrip), // Replace with your image path
                  fit: BoxFit.cover, // Adjust the fit as needed
                ),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        var locale = const Locale("en");
                        Get.updateLocale(locale);
                      },
                      child: const Text(
                        "English",
                        style: TextStyle(color: Color(0xFFf6c553)),
                      ),
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        var locale = const Locale("hi");
                        Get.updateLocale(locale);
                      },
                      child: const Text(
                        "हिन्दी",
                        style: TextStyle(color: Color(0xFFf6c553)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Stack(
                alignment:
                    Alignment.center, // Center alignment for the image and text
                children: [
                  // Image widget as the background
                  Image.asset(
                    AppAssets.jackpot, // Set the height of the image
                    fit: BoxFit.cover, // Adjust the fit as needed
                  ),
                  // Text widget overlaid on top of the image
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0, left: 45),
                    child: Text(
                      "$currentCount",
                      style: const TextStyle(
                          color: Color(0xFFbe1e2d), // Text color
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 20),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!.liveWithdrawal,
                    style: TextStyle(
                        fontFamily: "Anton",
                        fontSize: 28,
                        fontWeight: FontWeight.w400,
                        foreground: Paint()..shader = linearGradient),
                  ),
                  Container(
                    width: 200,
                    height: 3,
                    decoration: BoxDecoration(
                        color: const Color(0xFFfdc600),
                        borderRadius: BorderRadius.circular(10.0)),
                  )
                ],
              ),
            ),
            const SizedBox(height: 15),
            Center(
              child: Stack(
                alignment:
                    Alignment.center, // Center alignment for the image and text
                children: [
                  // Image widget as the background
                  Image.asset(
                    AppAssets.withdrawal, // Set the height of the image
                    fit: BoxFit.cover, // Adjust the fit as needed
                  ),
                  // Text widget overlaid on top of the image
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            _card(title: "Navya ₹17955", time: "2 sec ago"),
                            _card(title: "Bishal ₹34955", time: "5 sec ago"),
                          ],
                        ),
                        Column(
                          children: [
                            _card(title: "Rakesh ₹16955", time: "6 sec ago"),
                            _card(title: "Anisha ₹15455", time: "9 sec ago"),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 25),
            AspectRatio(
                aspectRatio: 16 / 9,
                child: Chewie(controller: chewieController)),
            const SizedBox(height: 25),
            Center(
              child: Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!.games,
                    style: TextStyle(
                        fontFamily: "Anton",
                        fontSize: 28,
                        fontWeight: FontWeight.w400,
                        foreground: Paint()..shader = linearGradient),
                  ),
                  Container(
                    width: 100,
                    height: 3,
                    decoration: BoxDecoration(
                        color: const Color(0xFFfdc600),
                        borderRadius: BorderRadius.circular(10.0)),
                  )
                ],
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.mostPopular,
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
                InkWell(
                  onTap: () {
                    toggleNameVisibility();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    width: 100,
                    height: 38,
                    decoration: BoxDecoration(
                        color: const Color(0xFFf4ad09),
                        borderRadius: BorderRadius.circular(4.0)),
                    child: Center(
                      child: Text(
                        isExpanded
                            ? AppLocalizations.of(context)!.showLess
                            : AppLocalizations.of(context)!.showMore,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            SizedBox(height: 300, child: ImageGrid()),
            isExpanded
                ? SizedBox(height: 300, child: ImageGrid())
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}

// Floating button for bottombar
class MyFloatingActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Color(0xFFf4b429),
      onPressed: () {
        // Add your FAB button functionality here
        // This function will be called when the FAB is pressed.
      },
      child: Icon(Icons.add),
      mini: true,
    );
  }
}

//Used in image grid view
class ImageGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        List<String> imageUrls = [
          AppAssets.aviator,
          AppAssets.thumb,
          AppAssets.thumb1,
          AppAssets.thumb2,
        ];

        return Container(
          clipBehavior: Clip.antiAlias,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
              color: const Color(0xFFf4ad09),
              borderRadius: BorderRadius.circular(10)),
          child: Image.asset(
            imageUrls[index], width: 150,
            height: 150,
            fit: BoxFit.cover, // Adjust the BoxFit as needed
          ),
        );
      },
    );
  }
}

// used in live withdrawal gridview
Widget _card({required String title, required String time}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 5),
    child: Row(
      children: [
        Container(
          width: 50.0, // Set the width and height as needed
          height: 50.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle, // Create a circular container
            border: Border.all(
              color: const Color(0xFFd57f23), // Set the border color
              width: 3.0, // Set the border width
            ),
          ),
          child: CircleAvatar(
            radius: 48.0, // Set the radius as needed
            backgroundColor: Colors
                .transparent, // Set the background color of the CircleAvatar
            child: SvgPicture.asset(
              AppAssets.userList,
              width: 30,
            ), // Replace with your image path
          ),
        ),
        const SizedBox(width: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 14, color: Colors.white),
            ),
            Text(
              time,
              style: const TextStyle(fontSize: 10, color: Colors.grey),
            )
          ],
        )
      ],
    ),
  );
}
