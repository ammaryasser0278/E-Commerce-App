import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  final VoidCallback onFinish;
  const SplashView({super.key, required this.onFinish});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  bool _showLogo = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _scaleAnim = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.forward();
    Future.delayed(const Duration(milliseconds: 1400), () {
      setState(() => _showLogo = true);
    });
    Future.delayed(const Duration(seconds: 3), widget.onFinish);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF228B22), Color(0xFFB2EBF2)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 700),
            child: _showLogo
                ? RippleLogo()
                : ScaleTransition(
                    scale: _scaleAnim,
                    child: SupplementBottleIcon(),
                  ),
          ),
        ),
      ),
    );
  }
}

class SupplementBottleIcon extends StatelessWidget {
  const SupplementBottleIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.fitness_center,
      size: 90,
      color: Colors.white.withAlpha(0xE6),
    );
  }
}

class RippleLogo extends StatefulWidget {
  const RippleLogo({super.key});

  @override
  State<RippleLogo> createState() => _RippleLogoState();
}

class _RippleLogoState extends State<RippleLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _scaleAnim = Tween<double>(begin: 0.8, end: 1.0).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnim,
      child: ScaleTransition(
        scale: _scaleAnim,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.local_florist_rounded, size: 80, color: Colors.white),
            const SizedBox(height: 12),
            Text(
              'SUPPLEMENTS Store',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
