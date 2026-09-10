import 'package:flutter/material.dart';

/// Emergency phone numbers (fire/ambulance/police) have no natural Content
/// section fit on the backend, so they stay a client-side static list
/// ([EmergencyNumberModel.staticNumbers]) rather than going through the
/// Content API.
class EmergencyNumberModel {
  final int id;
  final String title;
  final String number;
  final String illustration;
  final Color colorStart;
  final Color colorEnd;
  final String description;
  final String available;

  EmergencyNumberModel({
    required this.id,
    required this.title,
    required this.number,
    required this.illustration,
    required this.colorStart,
    required this.colorEnd,
    required this.description,
    required this.available,
  });

  static final List<EmergencyNumberModel> staticNumbers = [
    EmergencyNumberModel(
        id: 1,
        title: 'الإسعاف',
        number: '123',
        illustration: '🚑',
        colorStart: Colors.red,
        colorEnd: Colors.red.shade700,
        description: 'خدمة الإسعاف',
        available: '24/7'),
    EmergencyNumberModel(
        id: 2,
        title: 'الشرطة',
        number: '122',
        illustration: '🚓',
        colorStart: Colors.blue,
        colorEnd: Colors.blue.shade700,
        description: 'شرطة النجدة',
        available: '24/7'),
    EmergencyNumberModel(
        id: 3,
        title: 'المطافئ',
        number: '180',
        illustration: '🚒',
        colorStart: Colors.orange,
        colorEnd: Colors.orange.shade700,
        description: 'الدفاع المدني',
        available: '24/7'),
    EmergencyNumberModel(
        id: 4,
        title: 'النجدة',
        number: '122',
        illustration: '🚨',
        colorStart: Colors.indigo,
        colorEnd: Colors.indigo.shade700,
        description: 'شرطة النجدة',
        available: '24/7'),
  ];
}

/// The backend only returns a flat `title`/`body` per content item — no
/// structured `severity`/`steps`/`warning`/`prevention` fields exist behind
/// `section=Emergency`. Simplified accordingly: [body] carries the whole
/// freeform text rendered as a single block by the detail view. `illustration`
/// / `colorStart` / `colorEnd` are purely cosmetic, deterministically derived
/// from the item's position in the list (not real backend data) so cards keep
/// some visual variety.
class EmergencyTipModel {
  final String id;
  final String title;
  final String body;
  final String illustration;
  final Color colorStart;
  final Color colorEnd;

  EmergencyTipModel({
    required this.id,
    required this.title,
    required this.body,
    required this.illustration,
    required this.colorStart,
    required this.colorEnd,
  });

  static const List<List<Color>> _palette = [
    [Color(0xFFFACC15), Color(0xFFEAB308)],
    [Color(0xFFFB7185), Color(0xFFE11D48)],
    [Color(0xFF818CF8), Color(0xFF4F46E5)],
    [Color(0xFFFB923C), Color(0xFFEA580C)],
    [Color(0xFF4ADE80), Color(0xFF16A34A)],
    [Color(0xFF60A5FA), Color(0xFF3B82F6)],
  ];

  static const List<String> _illustrations = ['🩹', '🚨', '⚕️', '🏥', '💊', '🧯'];

  factory EmergencyTipModel.fromJson(Map<String, dynamic> json, {int index = 0}) {
    final palette = _palette[index % _palette.length];
    return EmergencyTipModel(
      id: json['id'].toString(),
      title: json['title'] as String? ?? '',
      body: (json['body'] as String?) ?? (json['summary'] as String?) ?? '',
      illustration: _illustrations[index % _illustrations.length],
      colorStart: palette[0],
      colorEnd: palette[1],
    );
  }
}

/// First aid kit contents have no dedicated Content section either (see
/// brief) — kept as a client-side static list, same treatment as
/// [EmergencyNumberModel].
class FirstAidKitItemModel {
  final String item;
  final String emoji;

  FirstAidKitItemModel({
    required this.item,
    required this.emoji,
  });

  static final List<FirstAidKitItemModel> staticKit = [
    FirstAidKitItemModel(item: 'ترمومتر رقمي', emoji: '🌡️'),
    FirstAidKitItemModel(item: 'ضمادات معقمة بأحجام مختلفة', emoji: '🩹'),
    FirstAidKitItemModel(item: 'شاش طبي', emoji: '📦'),
    FirstAidKitItemModel(item: 'لاصق طبي', emoji: '📏'),
    FirstAidKitItemModel(item: 'مقص طبي', emoji: '✂️'),
    FirstAidKitItemModel(item: 'ملقط', emoji: '🔧'),
    FirstAidKitItemModel(item: 'قفازات طبية', emoji: '🧤'),
    FirstAidKitItemModel(item: 'محلول معقم (كحول/بيتادين)', emoji: '🧴'),
    FirstAidKitItemModel(item: 'خافض حرارة (باراسيتامول)', emoji: '💊'),
    FirstAidKitItemModel(item: 'محلول معالجة جفاف ORS', emoji: '🥤'),
    FirstAidKitItemModel(item: 'مرهم حروق', emoji: '🧴'),
    FirstAidKitItemModel(item: 'قطن طبي', emoji: '☁️'),
  ];
}
