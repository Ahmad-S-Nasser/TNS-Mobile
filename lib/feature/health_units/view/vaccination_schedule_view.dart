import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';
import 'package:tips_n_steps/feature/health_units/data/model/health_unit_model.dart';

class VaccinationScheduleView extends StatelessWidget {
  final List<VaccinationItem> schedule;
  final VoidCallback onBack;

  const VaccinationScheduleView({
    super.key,
    required this.schedule,
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
              gradient:
                  const LinearGradient(colors: [Colors.purple, Colors.pink]),
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
                  'جدول التطعيمات',
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
            child: ListView.builder(
              padding: EdgeInsets.all(20.W),
              itemCount: schedule.length,
              itemBuilder: (context, index) {
                final item = schedule[index];
                return Container(
                  margin: EdgeInsets.only(bottom: 16.H),
                  padding: EdgeInsets.all(16.W),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.R),
                    border: Border.all(color: AppColors.gray200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.purple,
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          12.hS,
                          Text(
                            item.age,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.SP,
                            ),
                          ),
                        ],
                      ),
                      12.vS,
                      ...item.vaccines.map((v) => Padding(
                            padding: EdgeInsets.only(bottom: 4.H),
                            child: Row(
                              children: [
                                const Icon(Icons.vaccines,
                                    size: 14, color: Colors.purple),
                                8.hS,
                                Text(v),
                              ],
                            ),
                          )),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
