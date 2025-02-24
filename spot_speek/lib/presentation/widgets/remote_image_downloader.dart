import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RemoteImageDownloader extends StatelessWidget {
  final String? imageUrl;
  const RemoteImageDownloader({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return (imageUrl == null || imageUrl!.isEmpty)
        ? Container(
            width: 40,
            height: 40,
            color: Colors.grey[300],
            child: const Icon(Icons.person, color: Colors.white),
          )
        : CachedNetworkImage(
            imageUrl: imageUrl ?? '',
            placeholder: (context, url) {
              return Icon(Icons.person);
            },
          );
  }
}
