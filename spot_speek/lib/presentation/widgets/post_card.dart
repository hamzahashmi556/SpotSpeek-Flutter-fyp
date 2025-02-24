import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:spot_speek/core/constants/app_colors.dart';
import 'package:spot_speek/data/datasources/user_firestore_datasource.dart';
import 'package:spot_speek/data/models/post_model.dart';
import 'package:spot_speek/data/models/user_model.dart';
import 'package:spot_speek/presentation/widgets/remote_image_downloader.dart';

class PostCard extends StatefulWidget {
  final PostModel post;
  final bool isLoading;

  PostCard({
    super.key,
    required this.post,
    required this.isLoading,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  UserModel? user;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  void _fetchUserData() async {
    final userDataSource = context.read<UserFirestoreDataSource>();
    UserModel? fetchedUser =
        await userDataSource.getUserFromCacheOrDatabase(widget.post.userId);

    if (mounted) {
      setState(() {
        user = fetchedUser;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = widget.post.createdAt;
    String formattedDate = DateFormat('hh:mm a, dd MMM yyyy').format(now);
    return Card(
      elevation: 1,
      margin: EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: _buildProfileImage(),
        // CircleAvatar(
        //   backgroundColor: Colors.blueAccent,
        //   child: Icon(Icons.person, color: Colors.white),
        // ),
        title: Text(widget.post.content,
            style: TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text("Posted ${formattedDate}",
            style: TextStyle(color: Colors.grey)),
      ),
    );
  }

  // Profile Image
  Widget _buildProfileImage() {
    return ClipOval(
      child: RemoteImageDownloader(imageUrl: user?.profilePicture),
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
    bool isEmojiOnly = RegExp(r'^[\p{Emoji}\s]+$', unicode: true)
        .hasMatch(widget.post.content);
    return Text(
      widget.post.content,
      style: TextStyle(
        fontSize: isEmojiOnly ? 28 : 14,
        fontWeight: FontWeight.normal,
        color: Colors.white,
      ),
    );
  }

  // Dynamic Icons Based on Post Type
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

  Color _getBackgroundColor() {
    return AppColors.primary;
  }
}
