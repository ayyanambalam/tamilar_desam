import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/app_router.dart';
import '../../core/constants/app_strings.dart';
import '../../core/widgets/glass_card.dart';
import '../../core/widgets/primary_button.dart';

final _authProvider = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();

  String? _verificationId;
  bool _sending = false;
  bool _verifying = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  Future<void> _sendOtp() async {
    setState(() => _sending = true);
    final auth = ref.read(_authProvider);

    try {
      await auth.verifyPhoneNumber(
        phoneNumber: _phoneController.text.trim(),
        timeout: const Duration(seconds: 60),
        verificationCompleted: (credential) async {
          await auth.signInWithCredential(credential);
          if (mounted) context.go(Routes.home);
        },
        verificationFailed: (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('OTP failed: ${e.message ?? e.code}')),
          );
        },
        codeSent: (verificationId, resendToken) {
          setState(() => _verificationId = verificationId);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('OTP sent')),
          );
        },
        codeAutoRetrievalTimeout: (verificationId) {
          setState(() => _verificationId = verificationId);
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  Future<void> _verifyOtp() async {
    if (_verificationId == null) return;
    setState(() => _verifying = true);
    final auth = ref.read(_authProvider);
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: _otpController.text.trim(),
      );
      await auth.signInWithCredential(credential);
      if (mounted) context.go(Routes.home);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid OTP: $e')),
      );
    } finally {
      if (mounted) setState(() => _verifying = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/tn_outline_bg.jpg', fit: BoxFit.cover),
          Container(color: Colors.white.withOpacity(0.85)),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 520),
                  child: GlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/images/td_logo.jpg',
                              width: 56,
                              height: 56,
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppStrings.partyNameTa,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                Text(
                                  AppStrings.sloganTa,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black.withOpacity(0.7),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        const Text(
                          'மொபைல் எண்',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            hintText: '+91 98765 43210',
                          ),
                        ),
                        const SizedBox(height: 14),
                        PrimaryButton(
                          label: 'OTP அனுப்பவும்',
                          icon: Icons.sms_outlined,
                          isLoading: _sending,
                          onPressed: _sendOtp,
                        ),
                        const SizedBox(height: 18),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child: _verificationId == null
                              ? const SizedBox.shrink()
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    const Text(
                                      'OTP',
                                      style: TextStyle(fontWeight: FontWeight.w800),
                                    ),
                                    const SizedBox(height: 8),
                                    TextField(
                                      controller: _otpController,
                                      keyboardType: TextInputType.number,
                                      decoration:
                                          const InputDecoration(hintText: '123456'),
                                    ),
                                    const SizedBox(height: 14),
                                    PrimaryButton(
                                      label: 'உள்நுழையவும்',
                                      icon: Icons.lock_open_rounded,
                                      isLoading: _verifying,
                                      onPressed: _verifyOtp,
                                    ),
                                  ],
                                ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'குறிப்பு: Phone OTP செயல்பட Firebase-ல் SHA-1 / SHA-256 சேர்க்கவும்.',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

