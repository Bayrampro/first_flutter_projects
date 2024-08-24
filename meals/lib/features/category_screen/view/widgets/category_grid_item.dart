import 'package:flutter/material.dart';

import '../../../../models/models.dart';

class CategoryGridItem extends StatefulWidget {
  const CategoryGridItem({
    super.key,
    required this.category,
    required void Function() onSelectedCategory,
  }) : _onSelectedCategory = onSelectedCategory;

  final Category category;
  final void Function() _onSelectedCategory;

  @override
  State<CategoryGridItem> createState() => _CategoryGridItemState();
}

class _CategoryGridItemState extends State<CategoryGridItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
    _animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: _animation,
      child: InkWell(
        onTap: widget._onSelectedCategory,
        splashColor: theme.primaryColor,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                widget.category.color.withOpacity(0.55),
                widget.category.color.withOpacity(0.9),
              ],
            ),
          ),
          child: Text(
            widget.category.title,
            style: theme.textTheme.titleLarge,
          ),
        ),
      ),
      builder: (context, child) => Opacity(
        opacity: _animation.value,
        child: child,
      ),
    );
  }
}
