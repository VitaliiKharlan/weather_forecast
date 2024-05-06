import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieAnimationWidget extends StatefulWidget {
  const LottieAnimationWidget({super.key});

  @override
  State<LottieAnimationWidget> createState() => _LottieAnimationWidgetState();
}

class _LottieAnimationWidgetState extends State<LottieAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;


  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Column(
            children: [
              SizedBox(
                height: 320,
                child: Lottie.asset(
                  height: 200,
                  'assets/lottie_animation/hare.json',
                  controller: _animationController,
                  onLoaded: (comp) {
                    _animationController.duration = comp.duration;
                    _animationController.forward();
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 320,
          child: InkWell(
            onTap: () {
              _animationController.reset();
              _animationController.forward(from: 0);
            },
            child: Lottie.asset(
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width,
              fit: BoxFit.cover,
              controller: _animationController,
              'assets/lottie_animation/confetti.json',
              repeat: false,
              onLoaded: (comp) {
                _animationController.duration = comp.duration;
                _animationController.forward();
              },
            ),
          ),
        ),
      ],
    );
  }

}
