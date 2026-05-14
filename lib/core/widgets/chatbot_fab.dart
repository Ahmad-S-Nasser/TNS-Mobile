import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tips_n_steps/core/helpers/app_assets.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';

import 'app_text_field.dart';

class ChatbotFAB extends StatefulWidget {
  const ChatbotFAB({super.key});

  @override
  State<ChatbotFAB> createState() => _ChatbotFABState();
}

class _ChatbotFABState extends State<ChatbotFAB> {
  bool _isExpanded = false;

  final List<String> _quickQuestions = [
    'كيف أهدئ طفلي الرضيع؟',
    'ما هي علامات التطور الطبيعي؟',
    'كيف أتعامل مع نوبات الغضب؟',
    'متى يجب زيارة الطبيب؟',
  ];

  @override
  Widget build(BuildContext context) {
    return _isExpanded ? const SizedBox.shrink() : _buildFAB();
  }

  Widget _buildFAB() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Pulse ring
        Container(
          width: 58.W,
          height: 58.H,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.primaryBlue.withValues(alpha: 0.55),
              width: 2.W,
            ),
          ),
        )
            .animate(onPlay: (controller) => controller.repeat())
            .scale(
              begin: const Offset(1, 1),
              end: const Offset(1.55, 1.55),
              duration: 2400.ms,
              curve: Curves.easeOut,
            )
            .fadeOut(duration: 1680.ms), // 70% of 2400ms is ~1680ms

        // Main FAB
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = true;
            });
            _showChatBottomSheet();
          },
          child: Container(
            width: 58.W,
            height: 58.H,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF1B59B2), Color(0xFF0D3A7A)],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF1B59B2).withValues(alpha: 0.45),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: SvgPicture.asset(
                AppIcons.aiBot,
                width: 30.W,
                height: 30.H,
              ),
            ),
          ),
        )
            .animate()
            .scale(
              begin: const Offset(0, 0),
              end: const Offset(1, 1),
              duration: 600.ms,
              curve: Curves.elasticOut,
            )
            .moveY(
              begin: 0,
              end: -8,
              duration: 600.ms,
              curve: Curves.easeInOut,
            )
            .then()
            .moveY(
              begin: 0,
              end: 8,
              duration: 600.ms,
              curve: Curves.easeInOut,
            ),
      ],
    );
  }

  void _showChatBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildChatBottomSheet(context),
    ).then((_) {
      setState(() {
        _isExpanded = false;
      });
    });
  }

  Widget _buildChatBottomSheet(BuildContext context) {
    return Container(
      height: 600.H,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.R)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Drag Handle
          Container(
            margin: EdgeInsets.only(top: 12.H, bottom: 8.H),
            width: 40.W,
            height: 4.H,
            decoration: BoxDecoration(
              color: const Color(0xFFD1D5DB),
              borderRadius: BorderRadius.circular(2.R),
            ),
          ),

          // Header
          Padding(
            padding: EdgeInsets.fromLTRB(16.W, 8.H, 16.W, 16.H),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 48.W,
                      height: 48.H,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF1B59B2), Color(0xFF0D3A7A)],
                        ),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          AppIcons.aiBot,
                          width: 26.W,
                          height: 26.H,
                        ),
                      ),
                    ),
                    12.hS,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'مساعد حياة كرمة',
                          style: TextStyle(
                            color: const Color(0xFF111827),
                            fontWeight: FontWeight.bold,
                            fontSize: 16.SP,
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              width: 7.W,
                              height: 7.H,
                              decoration: const BoxDecoration(
                                color: Color(0xFF82CD47),
                                shape: BoxShape.circle,
                              ),
                            ),
                            6.hS,
                            Text(
                              'متصل الآن',
                              style: TextStyle(
                                color: const Color(0xFF6B7280),
                                fontSize: 12.SP,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () => context.pop(),
                  icon: const Icon(Icons.close,
                      color: Color(0xFF6B7280), size: 24),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF3F4F6)),

          // Chat Content
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16.W),
              children: [
                // Welcome Message
                Container(
                  padding: EdgeInsets.all(16.W),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.R),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFF16665A).withValues(alpha: 0.08),
                        const Color(0xFF16665A).withValues(alpha: 0.04),
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'مرحباً بك! 👋',
                        style: TextStyle(
                          color: const Color(0xFF1F2937),
                          fontSize: 14.SP,
                        ),
                      ),
                      8.vS,
                      Text(
                        'أنا مساعدك الذكي في رحلة تربية طفلك. يمكنني مساعدتك في الإجابة على أسئلتك حول النمو، الصحة، والسلوك.',
                        style: TextStyle(
                          color: const Color(0xFF374151),
                          fontSize: 14.SP,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ).animate().fade(delay: 100.ms).slideY(begin: 0.1, end: 0),

                24.vS,

                // Quick Questions Title
                Text(
                  'أسئلة شائعة:',
                  style: TextStyle(
                    color: const Color(0xFF4B5563),
                    fontSize: 12.SP,
                    fontWeight: FontWeight.w600,
                  ),
                ).animate().fade(delay: 200.ms),

                12.vS,

                // Quick Questions Buttons
                ...List.generate(_quickQuestions.length, (index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 8.H),
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(12.R),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.W, vertical: 12.H),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFE5E7EB)),
                          borderRadius: BorderRadius.circular(12.R),
                        ),
                        alignment: Alignment.centerRight,
                        child: Text(
                          _quickQuestions[index],
                          style: TextStyle(
                            color: const Color(0xFF374151),
                            fontSize: 14.SP,
                          ),
                        ),
                      ),
                    ),
                  )
                      .animate()
                      .fade(delay: (300 + index * 100).ms)
                      .slideX(begin: -0.1, end: 0);
                }),
              ],
            ),
          ),

          // Input Area
          Container(
            padding: EdgeInsets.fromLTRB(16.W, 12.H, 16.W, 24.H),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Color(0xFFF3F4F6))),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.W, vertical: 8.H),
              decoration: BoxDecoration(
                color: const Color(0xFFF9FAFB),
                borderRadius: BorderRadius.circular(30.R),
              ),
              child: Row(
                children: [
                  Container(
                    width: 36.W,
                    height: 36.H,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF1B59B2), Color(0xFF0D3A7A)],
                      ),
                    ),
                    child: Center(
                      child: Transform.rotate(
                        angle: 3.14159, // 180 degrees
                        child:
                            Icon(Icons.send, color: Colors.white, size: 18.W),
                      ),
                    ),
                  ),
                  12.hS,
                  const Expanded(
                    child: AppTextField(
                      textAlign: TextAlign.right,
                      hint: 'اكتب سؤالك هنا...',
                      hintColor: Color(0xFF9CA3AF),
                      isFill: false,
                      enabledColor: Colors.transparent,
                    ),
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
