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
        height: 200,
        width: 150,
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: selectedCategory == category ? Colors.blue : Colors.grey,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              category,
              style: TextStyle(
                color:
                    selectedCategory == category ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
