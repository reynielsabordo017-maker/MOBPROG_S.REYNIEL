
import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF12121E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E2E),
        foregroundColor: Colors.white,
        title: const Text('Product Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  product.imagePath,
                  width: double.infinity,
                  height: 280,
                  fit: BoxFit.contain,
                  semanticLabel: product.name,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 280,
                      width: double.infinity,
                      color: const Color(0xFF1E1E2E),
                      child: const Icon(
                        Icons.image_not_supported,
                        size: 60,
                        color: Colors.white54,
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),

              Text(
                product.category.toUpperCase(),
                style: const TextStyle(
                  color: Colors.purpleAccent,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                product.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Text(
                '₱${product.price.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: Colors.greenAccent,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 24),

              const Text(
                'Product Description',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                product.description,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  height: 1.6,
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Thank you for checking out GAMEHUB!',
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.sports_esports),
                  label: const Text('Explore Gaming'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purpleAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
