import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tips_n_steps/core/di/service_locator.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';
import 'package:tips_n_steps/core/widgets/success_state.dart';
import 'package:tips_n_steps/feature/children/data/model/child_model.dart';
import 'package:tips_n_steps/feature/children/logic/children_cubit.dart';
import 'package:tips_n_steps/feature/children/view/components/add_child_form.dart';

/// Add-child screen, reused for edit: pass [existingChild] to pre-fill the
/// form and submit an update instead of a create.
class AddChildView extends StatefulWidget {
  final ChildModel? existingChild;

  const AddChildView({super.key, this.existingChild});

  @override
  State<AddChildView> createState() => _AddChildViewState();
}

class _AddChildViewState extends State<AddChildView> {
  bool _isSuccess = false;

  bool get _isEditing => widget.existingChild != null;

  Future<void> _handleSubmit(
    ChildrenCubit cubit, {
    required String fullName,
    required DateTime dateOfBirth,
    required String gender,
    String? bloodType,
  }) async {
    final success = _isEditing
        ? await cubit.updateChild(
            id: widget.existingChild!.id,
            fullName: fullName,
            dateOfBirth: dateOfBirth,
            gender: gender,
            bloodType: bloodType,
          )
        : await cubit.addChild(
            fullName: fullName,
            dateOfBirth: dateOfBirth,
            gender: gender,
            bloodType: bloodType,
          );
    if (!mounted) return;
    if (success) {
      setState(() => _isSuccess = true);
    } else {
      final message = cubit.state.errorMessage ?? 'حدث خطأ، حاول مرة أخرى';
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChildrenCubit>(
      create: (_) => sl<ChildrenCubit>(),
      child: Builder(
        builder: (context) {
          if (_isSuccess) {
            return SuccessState(
              title:
                  _isEditing ? 'تم تحديث بيانات الطفل!' : 'تمت إضافة الطفل!',
              description: _isEditing
                  ? 'تم حفظ التعديلات بنجاح.'
                  : 'يمكنك الآن متابعة معدلات نمو طفلك والحصول على نصائح مخصصة.',
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
                        _isEditing ? 'تعديل بيانات الطفل' : 'إضافة طفل جديد',
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
                              Text(
                                _isEditing
                                    ? 'حدّث بيانات طفلك'
                                    : 'أضف بيانات طفلك لمتابعة نموه',
                                style:
                                    const TextStyle(color: AppColors.gray600),
                              ),
                            ],
                          ),
                        ),
                        32.vS,
                        BlocBuilder<ChildrenCubit, ChildrenState>(
                          builder: (context, state) {
                            final cubit = context.read<ChildrenCubit>();
                            return AddChildForm(
                              existingChild: widget.existingChild,
                              isSubmitting: state.isSubmitting,
                              onSubmit: ({
                                required fullName,
                                required dateOfBirth,
                                required gender,
                                bloodType,
                              }) =>
                                  _handleSubmit(
                                cubit,
                                fullName: fullName,
                                dateOfBirth: dateOfBirth,
                                gender: gender,
                                bloodType: bloodType,
                              ),
                            );
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
        },
      ),
    );
  }
}
