import 'package:flutter/material.dart';

import '../../core/widgets/glass_card.dart';
import '../../core/widgets/primary_button.dart';

class SurveyFormScreen extends StatefulWidget {
  const SurveyFormScreen({super.key});

  @override
  State<SurveyFormScreen> createState() => _SurveyFormScreenState();
}

class _SurveyFormScreenState extends State<SurveyFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final _name = TextEditingController();
  final _mobile = TextEditingController();
  final _area = TextEditingController();
  final _caste = TextEditingController();
  final _religion = TextEditingController();
  final _issues = TextEditingController();
  String _votePref = 'தமிழர் தேசம்';
  String _satisfaction = 'நல்லது';

  @override
  void dispose() {
    _name.dispose();
    _mobile.dispose();
    _area.dispose();
    _caste.dispose();
    _religion.dispose();
    _issues.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('சர்வே பதிவு சேமிக்கப்பட்டது (MVP stub)')),
    );

    // TODO: Save to Firestore surveys collection:
    // - name, mobile, area, caste, religion, votingPreference, localIssues, satisfaction, district
    // - createdAt server timestamp
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('சர்வே')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 110),
        children: [
          GlassCard(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('வாக்காளர் சர்வே', style: TextStyle(fontWeight: FontWeight.w900)),
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
                    decoration: const InputDecoration(labelText: 'மொபைல்'),
                    validator: (v) => (v == null || v.trim().length < 10)
                        ? 'சரியான எண்'
                        : null,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _area,
                    decoration: const InputDecoration(labelText: 'பகுதி / இடம்'),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _caste,
                    decoration: const InputDecoration(labelText: 'சாதி'),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _religion,
                    decoration: const InputDecoration(labelText: 'மதம்'),
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: _votePref,
                    decoration: const InputDecoration(labelText: 'வாக்கு முன்னுரிமை'),
                    items: const [
                      DropdownMenuItem(value: 'தமிழர் தேசம்', child: Text('தமிழர் தேசம்')),
                      DropdownMenuItem(value: 'அதிமுக', child: Text('அதிமுக')),
                      DropdownMenuItem(value: 'திமுக', child: Text('திமுக')),
                      DropdownMenuItem(value: 'காங்கிரஸ்', child: Text('காங்கிரஸ்')),
                      DropdownMenuItem(value: 'மற்றது', child: Text('மற்றது')),
                      DropdownMenuItem(value: 'முடிவு இல்லை', child: Text('முடிவு இல்லை')),
                    ],
                    onChanged: (v) => setState(() => _votePref = v ?? _votePref),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _issues,
                    maxLines: 3,
                    decoration: const InputDecoration(labelText: 'உள்ளூர் பிரச்சினைகள்'),
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: _satisfaction,
                    decoration: const InputDecoration(labelText: 'அரசு திருப்தி'),
                    items: const [
                      DropdownMenuItem(value: 'மிக நல்லது', child: Text('மிக நல்லது')),
                      DropdownMenuItem(value: 'நல்லது', child: Text('நல்லது')),
                      DropdownMenuItem(value: 'சராசரி', child: Text('சராசரி')),
                      DropdownMenuItem(value: 'குறைவு', child: Text('குறைவு')),
                      DropdownMenuItem(value: 'மிக குறைவு', child: Text('மிக குறைவு')),
                    ],
                    onChanged: (v) => setState(() => _satisfaction = v ?? _satisfaction),
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
        ],
      ),
    );
  }
}

