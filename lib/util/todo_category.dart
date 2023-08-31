import 'package:flutter/material.dart';

class CategoryContainer extends StatelessWidget {
  final String category;
  final String selectedCategory;
  final Function(String) onTap;

  const CategoryContainer({
    Key? key,
    required this.category,
    required this.selectedCategory,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(category);
      },
      child: Container(
        transformAlignment: Alignment.center,
        height: 164,
        width: 126,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28.0),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(20, 0, 0, 0).withOpacity(0.4),
              offset: const Offset(2, 5),
              blurRadius: 7,
            )
          ],
          color: selectedCategory == category
              ? Theme.of(context).colorScheme.scrim
              : Theme.of(context).colorScheme.secondary,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              category,
              style: TextStyle(
                letterSpacing: 5,
                color: selectedCategory == category
                    ? const Color(0XFF262A32)
                    : const Color(0Xff262A32),
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
            const Text(
              'Your Task from all category will show here',
              style: TextStyle(
                color: Color(0Xff262A32),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
