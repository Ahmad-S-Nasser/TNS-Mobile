import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';
import 'package:tips_n_steps/feature/content/data/model/content_item.dart';
import 'package:tips_n_steps/feature/content/logic/content_cubit.dart';
import 'package:tips_n_steps/feature/content/view/components/content_action_buttons.dart';
import 'package:tips_n_steps/feature/content/view/components/content_media_placeholder.dart';
import 'package:tips_n_steps/feature/content/view/components/content_topics_wrap.dart';

/// Renders the currently-selected content item from [ContentCubit]'s detail
/// state (fetched fresh via `getById` so it always reflects the real,
/// possibly-longer `body` rather than just what the list endpoint returned).
class ContentDetailView extends StatelessWidget {
  final bool isSaved;
  final VoidCallback onToggleSaved;
  final VoidCallback onBack;

  const ContentDetailView({
    super.key,
    required this.isSaved,
    required this.onToggleSaved,
    required this.onBack,
  });

  void _handleLike(BuildContext context) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(const SnackBar(content: Text('ميزة الإعجاب قريباً')));
  }

  void _handleShare(ContentItem item) {
    final text = '${item.title}\n\n${item.displaySummary}';
    Share.share(text, subject: item.title);
  }

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
                  child: BlocBuilder<ContentCubit, ContentState>(
                    buildWhen: (previous, current) =>
                        previous.detailItem?.title != current.detailItem?.title,
                    builder: (context, state) => Text(
                      state.detailItem?.title ?? 'المحتوى',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.SP,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<ContentCubit, ContentState>(
              builder: (context, state) {
                if (state.detailStatus == ContentDetailStatus.loading ||
                    state.detailStatus == ContentDetailStatus.initial) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.detailStatus == ContentDetailStatus.error ||
                    state.detailItem == null) {
                  return Center(
                    child: Text(state.detailError ?? 'تعذر تحميل المحتوى'),
                  );
                }

                final item = state.detailItem!;
                return ListView(
                  padding: EdgeInsets.all(20.W),
                  children: [
                    ContentMediaPlaceholder(
                      type: item.type,
                      thumbnailUrl: item.thumbnailUrl,
                    ),
                    24.vS,
                    _ContentMetaRow(item: item),
                    24.vS,
                    if (item.tags.isNotEmpty) ...[
                      ContentTopicsWrap(topics: item.tags),
                      24.vS,
                    ],
                    Text(
                      item.body,
                      style: TextStyle(fontSize: 15.SP, height: 1.7),
                    ),
                    24.vS,
                    ContentActionButtons(
                      isSaved: isSaved,
                      onSave: onToggleSaved,
                      onLike: () => _handleLike(context),
                      onShare: () => _handleShare(item),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ContentMetaRow extends StatelessWidget {
  final ContentItem item;

  const _ContentMetaRow({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.W),
      decoration: BoxDecoration(
        color: const Color(0xFF1B59B2).withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20.R),
        border: Border.all(color: const Color(0xFF1B59B2).withValues(alpha: 0.2)),
      ),
      child: Wrap(
        spacing: 16.W,
        runSpacing: 8.H,
        children: [
          _metaItem(Icons.remove_red_eye, '${item.formattedViewCount} مشاهدة'),
          _metaItem(Icons.star, item.averageRating.toStringAsFixed(1)),
          if (item.formattedPublishedAt.isNotEmpty)
            _metaItem(Icons.calendar_today, item.formattedPublishedAt),
        ],
      ),
    );
  }

  Widget _metaItem(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14.W, color: AppColors.gray500),
        4.hS,
        Text(label, style: TextStyle(fontSize: 12.SP, color: AppColors.gray600)),
      ],
    );
  }
}
