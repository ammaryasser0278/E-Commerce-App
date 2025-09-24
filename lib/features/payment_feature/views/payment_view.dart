import 'package:flutter/material.dart';
import 'package:supplements_app/core/common_widgets/app_bar_title.dart';
import 'package:supplements_app/core/common_widgets/leading_button.dart';
import 'package:supplements_app/features/payment_feature/views/widgets/payment_progress_indicator.dart';
import 'package:supplements_app/features/payment_feature/views/widgets/security_badge.dart';
import 'package:supplements_app/features/payment_feature/views/widgets/payment_method_selector.dart';
import 'package:supplements_app/features/payment_feature/views/widgets/payment_form.dart';
import 'package:supplements_app/features/payment_feature/views/widgets/order_review_section.dart';
import 'package:supplements_app/features/payment_feature/views/widgets/payment_success_screen.dart';

/// Main payment screen with multi-step payment process
class PaymentView extends StatefulWidget {
  final double totalAmount;
  final List<Map<String, dynamic>> cartItems;

  const PaymentView({
    super.key,
    required this.totalAmount,
    required this.cartItems,
  });

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final TextEditingController cardNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  int currentStep = 0;
  String selectedPaymentMethod = 'card';
  bool isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const AppBarTitle(title: 'Secure Payment'),
        centerTitle: true,
        leading: LeadingButton(),
      ),
      body: Column(
        children: [
          // Progress Indicator
          PaymentProgressIndicator(currentStep: currentStep),

          // Security Badge
          const SecurityBadge(),

          const SizedBox(height: 20),

          // Payment Content
          Expanded(child: _buildCurrentStep()),

          // Bottom Action Button
          if (currentStep < 2)
            Container(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isProcessing ? null : _handleNextStep,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: isProcessing
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          currentStep == 0
                              ? (selectedPaymentMethod == 'cash'
                                    ? 'Confirm Order'
                                    : 'Review Payment')
                              : (selectedPaymentMethod == 'cash'
                                    ? 'Place Order'
                                    : 'Complete Payment'),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (currentStep) {
      case 0:
        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PaymentMethodSelector(
                selectedMethod: selectedPaymentMethod,
                onMethodSelected: (method) {
                  setState(() {
                    selectedPaymentMethod = method;
                  });
                },
              ),
              const SizedBox(height: 24),
              if (selectedPaymentMethod == 'card')
                PaymentForm(
                  cardNumberController: cardNumberController,
                  expiryDateController: expiryDateController,
                  cvvController: cvvController,
                  cardNameController: cardNameController,
                  emailController: emailController,
                  formKey: _formKey,
                ),
            ],
          ),
        );
      case 1:
        return OrderReviewSection(
          cartItems: widget.cartItems,
          totalAmount: widget.totalAmount,
          selectedPaymentMethod: selectedPaymentMethod,
          cardNumber: cardNumberController.text,
        );
      case 2:
        return const PaymentSuccessScreen();
      default:
        return const SizedBox();
    }
  }

  void _handleNextStep() {
    if (currentStep == 0) {
      if (selectedPaymentMethod == 'cash') {
        // Skip form validation and review; go straight to success
        setState(() {
          currentStep = 2;
        });
        return;
      }
      // card flow requires form validation then review
      if (_formKey.currentState!.validate()) {
        setState(() {
          currentStep = 1;
        });
      }
    } else if (currentStep == 1) {
      // card processing simulation
      setState(() {
        isProcessing = true;
      });
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          isProcessing = false;
          currentStep = 2;
        });
      });
    }
  }
}
