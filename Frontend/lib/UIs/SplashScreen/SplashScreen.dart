import 'package:flutter/material.dart';
import 'package:redact/utils/helper/helper_functions.dart';

import '../HomeScreen/HomeScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  // Initializing Controllers Variables  : late because we will assign it later in initializer function or somewhere
  late AnimationController _controller;
  late AnimationController _colorController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _gradientAnimation;

  @override
  void initState() {
    super.initState();  // Assigning Animation Controller to get the control of Animation
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
                    // Assigning Animation Color Controller to get the control of Color Animation
    _colorController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _rotationAnimation = Tween<double>(begin: 0.0, end: 2.0 * 3.14).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _gradientAnimation = CurvedAnimation(parent: _colorController, curve: Curves.easeInOut);

    _controller.forward();

    // Using it to get shift from the Splash Screen to the HomeScreen after 4  Sec
    Future.delayed(const Duration(seconds: 4), (){
      HelperFunctions.shiftToScreen(context, HomeScreen());
    });
  }

  @override  // Disposing Controllers after using
  void dispose() {
    _controller.dispose();
    _colorController.dispose();
    super.dispose();
  }

  // It Builds Gradient Function which will make linear gradient with color mixes and return it
  LinearGradient _buildGradient() {
    // Before Animation First Color List
    final List<Color> colors1 = [
      Colors.white,
      Colors.lightBlueAccent.shade100,
      Colors.blue.shade50,
      Colors.grey.shade200,
    ];

    // After Animation Last Color List
    final List<Color> colors2 = [
      Colors.blue,
      Colors.grey.shade200,
      Colors.white,
      Colors.lightBlue,
    ];

    return LinearGradient(
      colors: List<Color>.generate(  // Generating Gradient
        colors1.length,
            (int index) {
          return ColorTween(   // Making it as Animation
            begin: colors1[index],
            end: colors2[index],
          ).lerp(_gradientAnimation.value)!;
        },
      ),
      begin: Alignment.bottomRight,
      end: Alignment.topLeft,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _colorController,
        builder: (BuildContext context, Widget? child) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: _buildGradient(),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Transform.scale(  // Transition to scale up or down the logo
                //   scale: _scaleAnimation.value,
                //   child: Transform.rotate(  // Transition to rotate the logo
                //     angle: _rotationAnimation.value,
                //     child: Image.asset(FImages.loginImage,
                //       width: DeviceUtils.getScreenSize(context).width*0.1,
                //     ),
                //   ),
                // ),
                // const SizedBox(height: 15),
                Text(
                  'RE-DACT',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
