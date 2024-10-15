import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:irroba/app_config.dart';
import 'package:irroba/core/extensions/double.dart';
import 'package:irroba/core/models/product.dart';

class BoxProductCart extends StatelessWidget {
  final ProductModel product;
  final int quantity;
  final Function onAddQuatity;
  final Function onRemoveQuantity;
  const BoxProductCart({
    super.key,
    required this.product,
    required this.quantity,
    required this.onAddQuatity,
    required this.onRemoveQuantity,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>();

    return Card(
      elevation: 3,
      color: theme?.secondary ?? Colors.grey,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.all(8),
                color: Colors.white,
                child: CachedNetworkImage(
                  progressIndicatorBuilder: (context, url, progress) => Center(
                    child: CircularProgressIndicator(
                      value: progress.progress,
                      color: Colors.red,
                    ),
                  ),
                  height: 80,
                  width: 80,
                  imageUrl: product.image,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: SizedBox(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      product.title,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          product.price.formatToCurrency(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                onRemoveQuantity();
                              },
                              icon: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: theme?.primary,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(100),
                                  ),
                                ),
                                child: const Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              quantity.toString(),
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: theme?.primary),
                            ),
                            const SizedBox(width: 4),
                            IconButton(
                              onPressed: () {
                                onAddQuatity();
                              },
                              icon: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: theme?.primary,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(100),
                                  ),
                                ),
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
