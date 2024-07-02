import 'package:flutter/material.dart';

class LightsSnackbarContent extends StatefulWidget {
  const LightsSnackbarContent({super.key});

  @override
  LightsSnackbarContentState createState() => LightsSnackbarContentState();
}

class LightsSnackbarContentState extends State<LightsSnackbarContent> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      lowerBound : 0.0,
      upperBound : 1.0,
      animationBehavior: AnimationBehavior.preserve,
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inversePrimary = Theme.of(context).colorScheme.inversePrimary;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return SizedBox(
          height: 20,
          child: ShaderMask(
            shaderCallback: (bounds) {
              return LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  inversePrimary.withOpacity(0.5),
                  inversePrimary.withOpacity(0.3),
                  inversePrimary.withOpacity(0.3),
                  inversePrimary.withOpacity(0.2),
                  inversePrimary.withOpacity(0.2),
                  inversePrimary.withOpacity(1),
                ],
                stops: const [0.0,  0.2, 0.3, 0.4, 0.5, 1.0,],
                tileMode: TileMode.clamp,
              ).createShader(
                Rect.fromLTWH(
                  0,
                  -bounds.height * _controller.value,
                  bounds.width,
                  bounds.height,
                ),
              );
            },
            child: Container(
              color: inversePrimary.withOpacity(0.2),
              alignment: Alignment.center,
              child: Text('Bot X trade...',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  )),
            ),
          ),
        );
      },
    );
  }
}
