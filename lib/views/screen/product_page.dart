import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/controller/product_controller.dart';
import 'package:project/views/widget/product_list_widget.dart';
import 'package:project/views/widget/list_item_selector.dart';

final ProductController controller = Get.put(ProductController());

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  Widget _topCategoriesListView() {
    return ListItemSelector(
      categories: controller.categories,
      onItemPressed: (index) {
        controller.filterItemsByCategory(index);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    controller.getAllItems();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produits'),
        backgroundColor: const Color.fromARGB(255, 239, 239, 239),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _topCategoriesListView(),
                const SizedBox(height: 20),
                GetBuilder<ProductController>(
                  builder: (controller) {
                    return ProductListWidget(
                      items: controller.filteredProducts,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
