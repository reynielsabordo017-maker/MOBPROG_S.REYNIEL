
import 'package:flutter/material.dart';

import '../data/sample_products.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';
import '../widgets/product_tile.dart';
import 'product_detail_page.dart';

class CatalogPage extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onThemeToggle;

  const CatalogPage({
    super.key,
    required this.isDarkMode,
    required this.onThemeToggle,
  });

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  String searchQuery = '';
  String selectedCategory = 'All';

  List<String> get categories {
    return [
      'All',
      ...sampleProducts.map((product) => product.category).toSet(),
    ];
  }

  List<Product> get filteredProducts {
    return sampleProducts.where((product) {
      final matchesName = product.name
          .toLowerCase()
          .contains(searchQuery.toLowerCase());

      final matchesCategory = selectedCategory == 'All' ||
          product.category == selectedCategory;

      return matchesName && matchesCategory;
    }).toList();
  }

  void openProduct(BuildContext context, Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailPage(product: product),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final products = filteredProducts;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E2E),
        foregroundColor: Colors.white,
        leading: const Icon(Icons.sports_esports),

        // Search field in AppBar
        title: TextField(
          onChanged: (value) {
            setState(() {
              searchQuery = value;
            });
          },
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Search gaming products...',
            hintStyle: const TextStyle(color: Colors.white70),
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.white70,
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
          ),
        ),

        actions: [
          IconButton(
            onPressed: widget.onThemeToggle,
            tooltip: widget.isDarkMode
                ? 'Switch to light mode'
                : 'Switch to dark mode',
            icon: Icon(
              widget.isDarkMode
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
          ),
        ],
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Catalog heading
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Level Up Your Setup',
                  style: TextStyle(
                    color: widget.isDarkMode
                        ? Colors.white
                        : Colors.black87,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Explore gaming accessories for every player.',
                  style: TextStyle(
                    color: widget.isDarkMode
                        ? Colors.white70
                        : Colors.black54,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // Category filter chips
          SizedBox(
            height: 48,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: categories.map((category) {
                final isSelected = selectedCategory == category;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                    selectedColor: Colors.deepPurpleAccent,
                    backgroundColor: const Color(0xFF1E1E2E),
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.white70,
                      fontWeight: FontWeight.w600,
                    ),
                    side: BorderSide.none,
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 8),

          // Product count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              '${products.length} product(s) found',
              style: TextStyle(
                color: widget.isDarkMode
                    ? Colors.white70
                    : Colors.black54,
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Responsive product display
          Expanded(
            child: products.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.search_off,
                          size: 60,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'No products found',
                          style: TextStyle(
                            color: widget.isDarkMode
                                ? Colors.white70
                                : Colors.black54,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              searchQuery = '';
                              selectedCategory = 'All';
                            });
                          },
                          child: const Text('Clear filters'),
                        ),
                      ],
                    ),
                  )
                : LayoutBuilder(
                    builder: (context, constraints) {
                      final width = constraints.maxWidth;

                      // Mobile: List layout
                      if (width < 600) {
                        return ListView.separated(
                          padding: const EdgeInsets.all(16),
                          itemCount: products.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 10),
                          itemBuilder: (context, index) {
                            final product = products[index];

                            return ProductTile(
                              product: product,
                              onTap: () =>
                                  openProduct(context, product),
                            );
                          },
                        );
                      }

                      // Tablet: 2 columns
                      // Desktop: 3 columns
                      final columns = width < 840 ? 2 : 3;

                      return GridView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: products.length,
                        gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: columns,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.72,
                        ),
                        itemBuilder: (context, index) {
                          final product = products[index];

                          return ProductCard(
                            product: product,
                            onTap: () =>
                                openProduct(context, product),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
