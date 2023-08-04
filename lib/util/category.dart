import 'package:flutter/material.dart';

class CategoryContainer extends StatelessWidget {
  final String category;
  final String selectedCategory;
  final Function(String) onTap;

  CategoryContainer(this.category, this.selectedCategory, this.onTap);

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
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28.0),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(20, 0, 0, 0).withOpacity(0.4),
              offset: Offset(2, 5),
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
                    ? Color(0XFF262A32)
                    : Color(0Xff262A32),
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
            Text(
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
