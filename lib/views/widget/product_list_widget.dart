import 'dart:math';
import 'package:flutter/material.dart';
import 'package:project/model/product.dart';

class ProductListWidget extends StatelessWidget {
  ProductListWidget({
    super.key,
    required this.items,
  });

  final List<Product> items;

  // Liste d'images aléatoires
  final List<String> randomImages = [
    'images/image1.PNG',
    'images/image2.PNG',
    'images/image3.PNG',
    'images/image4.png',
  ];

  void _showModal(BuildContext context) {
    // Générer une image aléatoire
    final randomImage = randomImages[Random().nextInt(randomImages.length)];

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('%'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Afficher une image aléatoire
              Image.asset(
                randomImage,
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 10),
              const Text('statistique de vente de ce produit par mois'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Fermer'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final product = items[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.asset(
                      product.images[0],
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "\$${product.price}",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward, color: Colors.blue),
                    onPressed: () => _showModal(context),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
