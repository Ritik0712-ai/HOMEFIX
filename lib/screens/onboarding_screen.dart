import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../core/constants.dart';
import '../providers/auth_provider.dart';
import '../widgets/gradient_button.dart';

/// Beautiful onboarding screens with page indicators
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Map icon strings to IconData
  IconData _getIcon(String iconName) {
    switch (iconName) {
      case 'build':
        return Icons.build_circle_rounded;
      case 'card_membership':
        return Icons.card_membership_rounded;
      case 'speed':
        return Icons.speed_rounded;
      default:
        return Icons.home_rounded;
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNext() {
    if (_currentPage < AppConstants.onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _completeOnboarding() {
    context.read<AuthProvider>().completeOnboarding();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF8FAFF), Color(0xFFE8F0FE)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Skip button
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: _completeOnboarding,
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      color: AppConstants.grey600,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              // Page view
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() => _currentPage = index);
                  },
                  itemCount: AppConstants.onboardingData.length,
                  itemBuilder: (context, index) {
                    final data = AppConstants.onboardingData[index];
                    return _buildOnboardingPage(
                      icon: _getIcon(data['icon']!),
                      title: data['title']!,
                      subtitle: data['subtitle']!,
                      index: index,
                    );
                  },
                ),
              ),

              // Page indicator
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: AppConstants.onboardingData.length,
                  effect: ExpandingDotsEffect(
                    dotWidth: 10,
                    dotHeight: 10,
                    expansionFactor: 3,
                    spacing: 8,
                    activeDotColor: AppConstants.primaryBlue,
                    dotColor: AppConstants.primaryBlue.withAlpha(60),
                  ),
                ),
              ),

              // Action button
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 0, 32, 40),
                child: GradientButton(
                  text: _currentPage == AppConstants.onboardingData.length - 1
                      ? 'Get Started'
                      : 'Next',
                  icon: _currentPage == AppConstants.onboardingData.length - 1
                      ? Icons.arrow_forward_rounded
                      : null,
                  onPressed: _onNext,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOnboardingPage({
    required IconData icon,
    required String title,
    required String subtitle,
    required int index,
  }) {
    // Alternate accent colors per page
    final accentColors = [
      AppConstants.primaryBlue,
      AppConstants.accentOrange,
      AppConstants.successGreen,
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon container with animated decoration
          Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  accentColors[index].withAlpha(30),
                  accentColors[index].withAlpha(15),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
              border: Border.all(
                color: accentColors[index].withAlpha(50),
                width: 2,
              ),
            ),
            child: Icon(
              icon,
              size: 72,
              color: accentColors[index],
            ),
          ),
          const SizedBox(height: 48),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: AppConstants.surfaceDark,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: AppConstants.grey600,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
