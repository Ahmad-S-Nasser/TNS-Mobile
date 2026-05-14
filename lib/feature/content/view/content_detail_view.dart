import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/feature/content/data/model/content_item.dart';
import 'package:tips_n_steps/feature/content/view/components/content_action_buttons.dart';
import 'package:tips_n_steps/feature/content/view/components/content_expert_card.dart';
import 'package:tips_n_steps/feature/content/view/components/content_media_placeholder.dart';
import 'package:tips_n_steps/feature/content/view/components/content_topics_wrap.dart';

class ContentDetailView extends StatelessWidget {
  final ContentItem item;
  final bool isSaved;
  final VoidCallback onBack;

  const ContentDetailView({
    super.key,
    required this.item,
    required this.isSaved,
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
                top: 60.H, bottom: 20.H, left: 20.W, right: 20.W),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                  colors: [Color(0xFF1B59B2), Color(0xFF0D3A7A)]),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(40.R),
              ),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: onBack,
                ),
                8.hS,
                Expanded(
                  child: Text(
                    item.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.SP,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(20.W),
              children: [
                ContentExpertCard(expert: item.expert),
                24.vS,
                ContentTopicsWrap(topics: item.topics),
                24.vS,
                ContentMediaPlaceholder(type: item.type),
                24.vS,
                ContentActionButtons(
                  isSaved: isSaved,
                  onSave: () {},
                  onLike: () {},
                  onShare: () {},
                ),
                24.vS,
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF23A99A),
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 60.H),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.R),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(item.type == 'video'
                          ? Icons.play_arrow
                          : Icons.menu_book),
                      8.hS,
                      Text(
                        item.type == 'video'
                            ? 'مشاهدة الفيديو الآن'
                            : 'قراءة المقالة الآن',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.SP),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
