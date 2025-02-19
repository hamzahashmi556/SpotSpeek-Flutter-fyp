import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spot_speek/presentation/viewmodels/home_viewmodel.dart';
import 'package:spot_speek/data/models/post_model.dart';
import 'package:spot_speek/presentation/views/map_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeViewModel>();
    final posts = vm.posts;

    return Scaffold(
      appBar: AppBar(
        title:
            Text("Spot Speek", style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon:
                Icon(Icons.map, color: Theme.of(context).colorScheme.onPrimary),
            onPressed: () async {
              final newLocation = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MapScreen(vm.currentCoordinates),
                ),
              );

              if (newLocation != null) {
                vm.updateLocation(newLocation);
              }
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
                    : _listView(posts),
          ),

          // Message TextField
          _bottomTextField(vm),
        ],
      ),

      // Floating Action Button for Map
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final newLocation = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MapScreen(vm.currentCoordinates),
            ),
          );

          if (newLocation != null) {
            vm.updateLocation(newLocation);
          }
        },
        icon: Icon(Icons.map),
        label: Text("Map View"),
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

  // Bottom TextField with Modern Styling
  Widget _bottomTextField(HomeViewModel vm) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: vm.messageController,
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
          FloatingActionButton(
            onPressed: vm.sendMessage,
            child: Icon(Icons.send),
            mini: true,
          ),
        ],
      ),
    );
  }

  // ListView with Material 3 Design
  Widget _listView(List<PostModel> posts) {
    return ListView.builder(
      padding: EdgeInsets.all(10),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 1,
          margin: EdgeInsets.symmetric(vertical: 6),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blueAccent,
              child: Icon(Icons.person, color: Colors.white),
            ),
            title: Text(posts[index].content,
                style: TextStyle(fontWeight: FontWeight.w600)),
            subtitle:
                Text("Posted just now", style: TextStyle(color: Colors.grey)),
          ),
        );
      },
    );
  }
}
