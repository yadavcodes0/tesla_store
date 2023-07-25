import 'package:flutter/material.dart';

class CustomRow extends StatelessWidget {
  const CustomRow({
    Key? key,
    required this.onBackPressed,
    required this.onFavoritePressed,
    required this.isFavorite,
  }) : super(key: key);

  final VoidCallback onBackPressed;
  final VoidCallback onFavoritePressed;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 32.0,
      ).copyWith(
        bottom: 0,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: onBackPressed,
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 25,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: onFavoritePressed,
            icon: isFavorite
                ? const Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 25,
                  )
                : const Icon(
                    Icons.favorite_border,
                    color: Colors.white,
                    size: 25,
                  ),
          ),
        ],
      ),
    );
  }
}
