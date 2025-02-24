import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spot_speek/presentation/viewmodels/home_viewmodel.dart';
import 'package:spot_speek/data/models/post_model.dart';
import 'package:spot_speek/presentation/views/map_screen.dart';
import 'package:spot_speek/presentation/views/profile_screen.dart';
import 'package:spot_speek/presentation/widgets/remote_image_downloader.dart';
import 'package:spot_speek/presentation/widgets/post_card.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeViewModel>();
    final posts = vm.posts;
    final user = vm.currentUser;

    return Scaffold(
      appBar: AppBar(
        title:
            Text("Spot Speek", style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: RemoteImageDownloader(imageUrl: user?.profilePicture),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Posts List
          Expanded(
            child: vm.isLoading
                ? Center(child: CircularProgressIndicator.adaptive())
                : posts.isEmpty
                    ? _emptyState()
                    : _listView(posts, vm.isLoading),
          ),

          // Message Input Field with Animated Button
          _bottomTextField(vm, context),
        ],
      ),
    );
  }

  // Empty State UI
  Widget _emptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.chat_bubble_outline, size: 80, color: Colors.grey),
          SizedBox(height: 10),
          Text("No posts found",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  // Message Input Field with Animated Button
  Widget _bottomTextField(HomeViewModel vm, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          // TextField Expanded
          Expanded(
            child: TextField(
              controller: vm.messageController,
              onChanged: (text) =>
                  vm.notifyListeners(), // Update UI on text change
              decoration: InputDecoration(
                hintText: "Write a message...",
                prefixIcon: Icon(Icons.message_outlined),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(width: 10),

          // Animated Map/Send Button
          AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            transitionBuilder: (child, animation) =>
                FadeTransition(opacity: animation, child: child),
            child: vm.messageController.text.isEmpty
                ? FloatingActionButton(
                    key: ValueKey("mapButton"),
                    onPressed: () async {
                      final newLocation = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MapScreen(vm.currentCoordinates),
                        ),
                      );

                      if (newLocation != null) {
                        vm.updateLocation(newLocation);
                      }
                    },
                    child: Icon(Icons.map),
                    mini: true,
                  )
                : FloatingActionButton(
                    key: ValueKey("sendButton"),
                    onPressed: vm.sendMessage,
                    child: Icon(Icons.send),
                    mini: true,
                  ),
          ),
        ],
      ),
    );
  }

  // ListView with Material 3 Design
  Widget _listView(List<PostModel> posts, bool isLoading) {
    return ListView.builder(
      padding: EdgeInsets.all(10),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return PostCard(post: posts[index], isLoading: isLoading);
      },
    );
  }
}
