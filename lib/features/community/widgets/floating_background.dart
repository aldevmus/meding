import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';

class FloatingBackground extends StatefulWidget {
  const FloatingBackground({super.key});

  @override
  State<FloatingBackground> createState() => _FloatingBackgroundState();
}

class _FloatingBackgroundState extends State<FloatingBackground> {
  late Timer _timer;
  double _top1 = -0.1, _left1 = -0.2;
  double _bottom2 = -0.15, _right2 = -0.15;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 7), (timer) {
      if (mounted) {
        setState(() {
          _top1 = (_top1 == -0.1) ? 0.05 : -0.1;
          _left1 = (_left1 == -0.2) ? -0.05 : -0.2;
          _bottom2 = (_bottom2 == -0.15) ? -0.05 : -0.15;
          _right2 = (_right2 == -0.15) ? -0.0 : -0.15;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(seconds: 7),
            curve: Curves.easeInOut,
            top: size.height * _top1,
            left: size.width * _left1,
            child: _buildBlob(
              const Color(0x333B82F6), // Blue with 20% opacity
              300,
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(seconds: 7),
            curve: Curves.easeInOut,
            bottom: size.height * _bottom2,
            right: size.width * _right2,
            child: _buildBlob(
              const Color(0x26EC4899), // Pink with 15% opacity
              250,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBlob(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 90, sigmaY: 90),
        child: Container(
          decoration: const BoxDecoration(color: Colors.transparent),
        ),
      ),
    );
  }
}
