import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final Map<String, dynamic> cat;
  final double size;

  const CategoryItem({
    required this.cat,
    this.size = 100.0, // Размер по умолчанию
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageSize = size;
    final colors = _getColors(cat);

    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Stack(
          children: [
            if (cat["img"] != null)
              Image.asset(
                cat["img"]!,
                height: imageSize,
                width: imageSize,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _buildPlaceholder(imageSize),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.2, 0.7],
                  colors: colors,
                ),
              ),
              height: imageSize,
              width: imageSize,
            ),
            Center(
              child: SizedBox(
                height: imageSize,
                width: imageSize,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      cat["name"] ?? 'Категория',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Color> _getColors(Map<String, dynamic> cat) {
    return [
      cat['color1'] ?? Colors.grey[800]!,
      cat['color2'] ?? Colors.grey[600]!,
    ];
  }

  Widget _buildPlaceholder(double size) {
    return Container(
      height: size,
      width: size,
      color: Colors.grey[300],
      child: const Icon(Icons.image, size: 40, color: Colors.grey),
    );
  }
}