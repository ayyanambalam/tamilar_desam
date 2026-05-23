import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/widgets/glass_card.dart';
import '../../core/widgets/primary_button.dart';

class DonationScreen extends StatefulWidget {
  const DonationScreen({super.key});

  @override
  State<DonationScreen> createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> {
  final _amount = TextEditingController(text: '100');

  // TODO: Move these to Firebase settings collection.
  final String upiId = 'tamilar.desam@upi';
  final String payeeName = 'Tamilar Desam';

  String get upiUri {
    final amt = _amount.text.trim();
    return 'upi://pay?pa=$upiId&pn=$payeeName&am=$amt&cu=INR&tn=Donation';
  }

  @override
  void dispose() {
    _amount.dispose();
    super.dispose();
  }

  Future<void> _payNow() async {
    final uri = Uri.parse(upiUri);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('UPI app not found on this device')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('நன்கொடை')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 110),
        children: [
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'UPI மூலம் நன்கொடை',
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 8),
                Text(
                  'UPI ID: $upiId',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _amount,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'தொகை (₹)',
                    prefixText: '₹ ',
                  ),
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: 14),
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: Colors.black.withOpacity(0.08)),
                    ),
                    child: QrImageView(
                      data: upiUri,
                      size: 220,
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                PrimaryButton(
                  label: 'UPI App திறக்கவும்',
                  icon: Icons.open_in_new_rounded,
                  onPressed: _payNow,
                ),
                const SizedBox(height: 10),
                Text(
                  'குறிப்பு: Production-க்கு payment verification/receipt க்காக server-side validation தேவை.',
                  style: TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.7)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const GlassCard(
            child: Text(
              'நன்கொடை வரலாறு & ரசீது பதிவிறக்கம் (MVP stub)\n\nFirestore: donations collection-ல் log செய்யலாம்.',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}

