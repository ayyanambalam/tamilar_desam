import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../core/widgets/glass_card.dart';
import '../../core/widgets/primary_button.dart';

class MembershipScreen extends StatefulWidget {
  const MembershipScreen({super.key});

  @override
  State<MembershipScreen> createState() => _MembershipScreenState();
}

class _MembershipScreenState extends State<MembershipScreen> {
  final _formKey = GlobalKey<FormState>();

  final _name = TextEditingController();
  final _mobile = TextEditingController();
  final _district = TextEditingController();
  final _constituency = TextEditingController();
  final _age = TextEditingController();
  final _occupation = TextEditingController();
  final _aadhaar = TextEditingController();
  String _gender = 'ஆண்';

  File? _photo;

  String? _memberId;
  bool _generatingPdf = false;

  @override
  void dispose() {
    _name.dispose();
    _mobile.dispose();
    _district.dispose();
    _constituency.dispose();
    _age.dispose();
    _occupation.dispose();
    _aadhaar.dispose();
    super.dispose();
  }

  Future<void> _pickPhoto() async {
    final picker = ImagePicker();
    final x = await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (x == null) return;
    setState(() => _photo = File(x.path));
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _memberId = _generateMembershipId();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('உறுப்பினர் பதிவு சேமிக்கப்பட்டது (MVP stub)')),
    );

    // TODO:
    // - Save membership application to Firestore: memberships collection
    // - Upload photo to Firebase Storage, store URL
    // - OTP verification workflow (can reuse Login OTP)
    // - Admin approval flow via Firebase Console (status field)
  }

  String _generateMembershipId() {
    // Simple unique ID for MVP: TD-YYYYMMDD-XXXX
    final now = DateTime.now();
    final y = now.year.toString();
    final m = now.month.toString().padLeft(2, '0');
    final d = now.day.toString().padLeft(2, '0');
    final short = const Uuid().v4().split('-').first.toUpperCase();
    return 'TD-$y$m$d-$short';
  }

  Future<void> _downloadPdf() async {
    if (_memberId == null) return;
    setState(() => _generatingPdf = true);
    try {
      final doc = pw.Document();
      final logo = await imageFromAssetBundle('assets/images/td_logo.jpg');

      doc.addPage(
        pw.Page(
          margin: const pw.EdgeInsets.all(18),
          build: (ctx) {
            return pw.Container(
              decoration: pw.BoxDecoration(
                borderRadius: pw.BorderRadius.circular(16),
                border: pw.Border.all(width: 2),
              ),
              padding: const pw.EdgeInsets.all(16),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Row(
                    children: [
                      pw.Image(logo, width: 54, height: 54),
                      pw.SizedBox(width: 12),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            'தமிழர் தேசம்',
                            style: pw.TextStyle(
                              fontSize: 18,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                          pw.Text(
                            'மக்களுக்கான அரசியல்',
                            style: const pw.TextStyle(fontSize: 11),
                          ),
                        ],
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 14),
                  pw.Text('Membership ID: $_memberId',
                      style: pw.TextStyle(
                        fontSize: 12,
                        fontWeight: pw.FontWeight.bold,
                      )),
                  pw.SizedBox(height: 10),
                  _row('பெயர்', _name.text),
                  _row('மொபைல்', _mobile.text),
                  _row('மாவட்டம்', _district.text),
                  _row('தொகுதி', _constituency.text),
                  _row('வயது', _age.text),
                  _row('பாலினம்', _gender),
                  _row('தொழில்', _occupation.text),
                  if (_aadhaar.text.trim().isNotEmpty) _row('ஆதார்', _aadhaar.text),
                  pw.Spacer(),
                  pw.Text(
                    'QR code மூலம் உறுப்பினர் சரிபார்ப்பு (MVP).',
                    style: const pw.TextStyle(fontSize: 10),
                  ),
                ],
              ),
            );
          },
        ),
      );

      await Printing.sharePdf(
        bytes: await doc.save(),
        filename: 'TamilarDesam_Membership_${_memberId!}.pdf',
      );
    } finally {
      if (mounted) setState(() => _generatingPdf = false);
    }
  }

  pw.Widget _row(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 6),
      child: pw.Row(
        children: [
          pw.SizedBox(
            width: 90,
            child: pw.Text(
              '$label:',
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 11),
            ),
          ),
          pw.Expanded(child: pw.Text(value, style: const pw.TextStyle(fontSize: 11))),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('உறுப்பினர் பதிவு')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 110),
        children: [
          GlassCard(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'உறுப்பினர் விவரங்கள்',
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _name,
                    decoration: const InputDecoration(labelText: 'பெயர்'),
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? 'பெயர் தேவை' : null,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _mobile,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(labelText: 'மொபைல் எண்'),
                    validator: (v) =>
                        (v == null || v.trim().length < 10) ? 'சரியான எண்' : null,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _district,
                    decoration: const InputDecoration(labelText: 'மாவட்டம்'),
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? 'மாவட்டம் தேவை' : null,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _constituency,
                    decoration: const InputDecoration(labelText: 'தொகுதி'),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _age,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(labelText: 'வயது'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _gender,
                          decoration: const InputDecoration(labelText: 'பாலினம்'),
                          items: const [
                            DropdownMenuItem(value: 'ஆண்', child: Text('ஆண்')),
                            DropdownMenuItem(value: 'பெண்', child: Text('பெண்')),
                            DropdownMenuItem(value: 'மற்றது', child: Text('மற்றது')),
                          ],
                          onChanged: (v) => setState(() => _gender = v ?? 'ஆண்'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _occupation,
                    decoration: const InputDecoration(labelText: 'தொழில்'),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _aadhaar,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'ஆதார் (விருப்பம்)'),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _pickPhoto,
                          icon: const Icon(Icons.photo_library_rounded),
                          label: Text(_photo == null ? 'புகைப்படம்' : 'மாற்றவும்'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      if (_photo != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Image.file(_photo!, width: 56, height: 56, fit: BoxFit.cover),
                        )
                      else
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.black.withOpacity(0.06),
                          ),
                          child: const Icon(Icons.person_rounded),
                        ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  PrimaryButton(
                    label: 'சமர்ப்பிக்கவும்',
                    icon: Icons.check_circle_rounded,
                    onPressed: _submit,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          if (_memberId != null) _membershipCardPreview(context),
        ],
      ),
    );
  }

  Widget _membershipCardPreview(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final memberId = _memberId!;
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('உறுப்பினர் அட்டை', style: TextStyle(fontWeight: FontWeight.w900)),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  scheme.primary.withOpacity(0.95),
                  scheme.secondary.withOpacity(0.90),
                ],
              ),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: _photo == null
                      ? Image.asset('assets/images/td_logo.jpg',
                          width: 64, height: 64, fit: BoxFit.cover)
                      : Image.file(_photo!, width: 64, height: 64, fit: BoxFit.cover),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'தமிழர் தேசம்',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'ID: $memberId',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Colors.black.withOpacity(0.8),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _name.text,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.black.withOpacity(0.8),
                        ),
                      ),
                      Text(
                        _district.text,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.black.withOpacity(0.75),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: QrImageView(
                    data: memberId,
                    size: 72,
                    backgroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          PrimaryButton(
            label: 'PDF பதிவிறக்கம்',
            icon: Icons.picture_as_pdf_rounded,
            isLoading: _generatingPdf,
            onPressed: _downloadPdf,
          ),
          const SizedBox(height: 8),
          Text(
            'குறிப்பு: MVP-ல் PDF “Share” ஆகும். நீங்கள் “Save” வேண்டுமெனில் file picker சேர்க்கலாம்.',
            style: TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.7)),
          ),
        ],
      ),
    );
  }
}

