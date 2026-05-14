import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';

class ContentCategoryFilter extends StatelessWidget {
  final List<Map<String, dynamic>> categories;
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const ContentCategoryFilter({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((cat) {
          final isSelected = selectedCategory == cat['id'];
          return Padding(
            padding: EdgeInsets.only(left: 8.W),
            child: ChoiceChip(
              label: Text('${cat['emoji']} ${cat['name']}'),
              selected: isSelected,
              onSelected: (selected) => onCategorySelected(cat['id']),
              selectedColor: cat['color'],
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.R)),
            ),
          );
        }).toList(),
      ),
    );
  }
}
