import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingPage1 extends StatelessWidget {
  const OnboardingPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return _OnboardingPageTemplate(
      image: 'assets/images/undraw_job-hunt_5umi.svg',
      title: 'Discover Top Supplements',
      description:
          'Explore high-quality supplements to boost your health and performance.',
    );
  }
}

class OnboardingPage2 extends StatelessWidget {
  const OnboardingPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return _OnboardingPageTemplate(
      image: 'assets/images/undraw_favourite-item_kv86.svg',
      title: 'Personalized Favorites',
      description: 'Save your favorite products for quick access.',
    );
  }
}

class OnboardingPage3 extends StatelessWidget {
  const OnboardingPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return _OnboardingPageTemplate(
      image: 'assets/images/undraw_online-payments_p97e.svg',
      title: 'Easy Checkout',
      description: 'Shop and checkout seamlessly with secure payments.',
    );
  }
}

class _OnboardingPageTemplate extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  const _OnboardingPageTemplate({
    required this.image,
    required this.title,
    required this.description,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          SvgPicture.asset(
            image,
            fit: BoxFit.cover,
            height: 250.0,
            // loadingBuilder: (context, child, progress) {
            //   if (progress == null) return child;
            //   return Center(child: CircularProgressIndicator());
            // },
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.broken_image, size: 80, color: Colors.grey),
          ),
          const SizedBox(height: 32),
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
