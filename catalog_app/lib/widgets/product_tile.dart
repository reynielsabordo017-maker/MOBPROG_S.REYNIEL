
import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductTile({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1E1E2E),
      margin: EdgeInsets.zero,
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        onTap: onTap,
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            product.imagePath,
            width: 65,
            height: 65,
            fit: BoxFit.cover,
            semanticLabel: product.name,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 65,
                height: 65,
                color: Colors.black26,
                child: const Icon(
                  Icons.image_not_supported,
                  color: Colors.white54,
                ),
              );
            },
          ),
        ),
        title: Text(
          product.name,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(
            product.category,
            style: const TextStyle(
              color: Colors.purpleAccent,
            ),
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '₱${product.price.toStringAsFixed(2)}',
              style: const TextStyle(
                color: Colors.greenAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white54,
              size: 14,
            ),
          ],
        ),
      ),
    );
  }
}
