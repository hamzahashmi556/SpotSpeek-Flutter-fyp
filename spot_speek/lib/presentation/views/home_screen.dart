import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spot_speek/data/models/post_model.dart';
import 'package:spot_speek/presentation/viewmodels/home_viewmodel.dart';
import 'package:spot_speek/presentation/views/map_screen.dart';
import 'package:spot_speek/presentation/widgets/post_row.dart';
import 'package:latlong2/latlong.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeViewModel>();
    final posts = vm.posts;
    return Scaffold(
      appBar: AppBar(
        title: Text("Spot Speek"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
                child: Icon(Icons.map),
                onTap: () async {
                  final newLocation = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MapScreen(vm.currentCoordinates)),
                  );

                  if (newLocation != null) {
                    vm.updateLocation(newLocation);
                  }
                }),
          )
        ],
      ),
      body: Column(
        children: [
          // Posts List (Stream)
          if (vm.isLoading)
            Center(child: CircularProgressIndicator())
          else
            Expanded(
                child: vm.posts.isEmpty
                    ? Center(child: Text("No posts found"))
                    : _listView(posts, vm.isLoading)),
          Spacer(),
          // Message TextField
          _bottomTextField(vm)
        ],
      ),

      // Floating Button -> Open Map Screen
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.only(bottom: 70.0),
      //   child: FloatingActionButton(
      //     child: ,
      //     onPressed: ,
      //   ),
      // ),
    );
  }

  Widget _bottomTextField(HomeViewModel vm) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: vm.messageController,
              decoration: InputDecoration(
                hintText: "Message to be posted...",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: vm.sendMessage,
          ),
        ],
      ),
    );
  }

  Widget _listView(List<PostModel> posts, bool isLoading) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return PostRow(post: posts[index], isLoading: isLoading);
      },
    );
  }
}
