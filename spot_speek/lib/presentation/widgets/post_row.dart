import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:spot_speek/core/constants/app_colors.dart';
import 'package:spot_speek/data/models/post_model.dart';

class PostRow extends StatelessWidget {
  final PostModel post;
  // final String imageUrl;
  // final String postText;
  final bool isLoading;
  // final PostType type;
  // final int repliesCount;

  const PostRow({
    super.key,
    required this.post,
    // required this.imageUrl,
    // required this.postText,
    required this.isLoading,
    // required this.type,
    // required this.repliesCount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
          color: _getBackgroundColor(),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //_buildProfileImage(),
            const SizedBox(width: 12),
            Expanded(
              child: isLoading ? _buildSkeletonText() : _buildMessageText(),
            ),
            const SizedBox(width: 8),
            // _buildIcon(),
          ],
        ),
      ),
    );
  }

  // Profile Image with Placeholder
  /*
  Widget _buildProfileImage() {
    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: 40,
        height: 40,
        fit: BoxFit.cover,
        placeholder: (context, url) => _buildPlaceholder(),
        errorWidget: (context, url, error) => _buildPlaceholder(),
      ),
    );
  }
  */

  // Placeholder Image
  Widget _buildPlaceholder() {
    return Container(
      width: 40,
      height: 40,
      color: Colors.grey[300],
      child: const Icon(Icons.person, color: Colors.white),
    );
  }

  // Loading Skeleton
  Widget _buildSkeletonText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _shimmerContainer(width: double.infinity, height: 16),
        const SizedBox(height: 6),
        _shimmerContainer(width: 100, height: 12),
      ],
    );
  }

  // Shimmer Effect
  Widget _shimmerContainer({required double width, required double height}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  // Post Message
  Widget _buildMessageText() {
    bool isEmojiOnly =
        RegExp(r'^[\p{Emoji}\s]+$', unicode: true).hasMatch(post.content);
    return Text(
      post.content,
      style: TextStyle(
        fontSize: isEmojiOnly ? 28 : 14,
        fontWeight: FontWeight.normal,
        color: Colors.white,
      ),
    );
  }

  // Dynamic Icons Based on Post Type
  /*
  Widget _buildIcon() {
    if (type == PostType.dropMessage) {
      return _icon(Icons.water_drop, Colors.blue);
    } else if (repliesCount > 50) {
      return _icon(Icons.local_fire_department, Colors.red);
    } else if (repliesCount > 0) {
      return _icon(Icons.circle, Colors.grey, label: "$repliesCount");
    }
    return const SizedBox();
  }
  */

  // Icon Helper
  Widget _icon(IconData icon, Color color, {String? label}) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(icon, color: color, size: 28),
          if (label != null)
            Positioned(
              right: 0,
              top: 0,
              child: Text(
                label,
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
    );
  }

  // Background Color Based on Type
  Color _getBackgroundColor() {
    // if (type == PostType.dropMessage) return Colors.blue.shade100;
    // if (repliesCount > 50) return Colors.red.shade100;
    return AppColors.primary;
  }
}

// Enum for Post Type
// enum PostType { dropMessage, normal }
