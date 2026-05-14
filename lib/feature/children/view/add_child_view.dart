import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';
import 'package:tips_n_steps/core/widgets/success_state.dart';
import 'package:tips_n_steps/feature/children/view/components/add_child_form.dart';

class AddChildView extends StatefulWidget {
  const AddChildView({super.key});

  @override
  State<AddChildView> createState() => _AddChildViewState();
}

class _AddChildViewState extends State<AddChildView> {
  bool _isSuccess = false;

  @override
  Widget build(BuildContext context) {
    if (_isSuccess) {
      return SuccessState(
        title: 'تمت إضافة الطفل!',
        description:
            'يمكنك الآن متابعة معدلات نمو طفلك والحصول على نصائح مخصصة.',
        actionLabel: 'قائمة الأطفال',
        onAction: () => context.pop(),
      );
    }
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.gray50,
      body: Column(
        children: [
          // Custom Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
                top: 54.H, left: 16.W, right: 16.W, bottom: 24.H),
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30.R),
                bottomRight: Radius.circular(30.R),
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 4.H)),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => context.pop(),
                ),
                Text(
                  'إضافة طفل جديد',
                  style: TextStyle(
                      fontSize: 24.SP,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.W),
              child: Column(
                children: [
                  16.vS,
                  Center(
                    child: Column(
                      children: [
                        Container(
                          width: 80.W,
                          height: 80.H,
                          decoration: const BoxDecoration(
                            gradient: AppColors.primaryGradient,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.child_care,
                              size: 40.SP, color: Colors.white),
                        ),
                        16.vS,
                        const Text(
                          'أضف بيانات طفلك لمتابعة نموه',
                          style: TextStyle(color: AppColors.gray600),
                        ),
                      ],
                    ),
                  ),
                  32.vS,
                  AddChildForm(
                    onSubmit: () {
                      setState(() {
                        _isSuccess = true;
                      });
                    },
                  ),
                  100.vS,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
