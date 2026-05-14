import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/feature/emergency/data/model/emergency_model.dart';

class FirstAidKitView extends StatelessWidget {
  final List<FirstAidKitItemModel> kitItems;
  final VoidCallback onBack;

  const FirstAidKitView({
    super.key,
    required this.kitItems,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
                top: 60.H, bottom: 24.H, left: 20.W, right: 20.W),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                  colors: [Color(0xFF1B59B2), Color(0xFF0D3A7A)]),
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(40.R)),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: onBack,
                ),
                8.hS,
                Text(
                  'حقيبة الإسعافات الأولية',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24.SP,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(20.W),
              children: [
                _buildKitInfoCard(),
                24.vS,
                Text('المحتويات الأساسية',
                    style: TextStyle(
                        fontSize: 18.SP, fontWeight: FontWeight.bold)),
                16.vS,
                ...kitItems.map((item) => _buildKitItem(item.item, item.emoji)),
                24.vS,
                _buildKitNotes(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKitInfoCard() {
    return Container(
      padding: EdgeInsets.all(16.W),
      decoration: BoxDecoration(
        color: const Color(0xFF1B59B2).withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(24.R),
        border:
            Border.all(color: const Color(0xFF1B59B2).withValues(alpha: 0.18)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('💡', style: TextStyle(fontSize: 24.SP)),
          12.hS,
          Expanded(
            child: Text(
              'احتفظ بحقيبة إسعافات أولية كاملة في منزلك وتأكد من أن جميع أفراد الأسرة يعرفون مكانها',
              style: TextStyle(
                  color: const Color(0xFF1B59B2), height: 1.5, fontSize: 13.SP),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKitItem(String name, String emoji) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.H),
      padding: EdgeInsets.all(16.W),
      decoration: BoxDecoration(
        color: const Color(0xFF1B59B2).withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(20.R),
        border:
            Border.all(color: const Color(0xFF1B59B2).withValues(alpha: 0.15)),
      ),
      child: Row(
        children: [
          Container(
            width: 48.W,
            height: 48.H,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(12.R)),
            child:
                Center(child: Text(emoji, style: TextStyle(fontSize: 24.SP))),
          ),
          16.hS,
          Expanded(
              child: Text(name,
                  style: const TextStyle(fontWeight: FontWeight.bold))),
          const Icon(Icons.check_circle, color: Color(0xFF82CD47)),
        ],
      ),
    );
  }

  Widget _buildKitNotes() {
    return Container(
      padding: EdgeInsets.all(20.W),
      decoration: BoxDecoration(
        color: Colors.yellow.shade50,
        borderRadius: BorderRadius.circular(24.R),
        border: Border.all(color: Colors.yellow.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.warning_amber_rounded, color: Colors.orange),
              8.hS,
              const Text(
                'ملاحظات مهمة',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.orange),
              ),
            ],
          ),
          12.vS,
          Text('• تحقق من تواريخ انتهاء الأدوية كل 6 أشهر',
              style: TextStyle(fontSize: 13.SP, height: 1.5)),
          Text('• احفظ الحقيبة في مكان بارد وجاف',
              style: TextStyle(fontSize: 13.SP, height: 1.5)),
          Text('• أبعدها عن متناول الأطفال',
              style: TextStyle(fontSize: 13.SP, height: 1.5)),
        ],
      ),
    );
  }
}
