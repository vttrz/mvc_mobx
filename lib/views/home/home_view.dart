import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mvc_example/controllers/post_controller.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  PostController _postController;

  @override
  void initState() {
    super.initState();
    _postController = PostController();
    _postController.loadPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () => _postController.loadPosts())
        ],
        title: Text('MVC - App'),
      ),
      body: Container(child: Observer(builder: (context) {
        var list = _postController.listPost;
        return list != null
            ? ListView.builder(
              itemCount: list.length,
              itemBuilder: (ctx, idx) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 5,
                    child: ListTile(
                        title: Text(list[idx].title, maxLines: 3, overflow: TextOverflow.ellipsis,),
                        subtitle: Text(list[idx].body),
                        onTap: () {
                          Navigator.pushNamed(context, '/comments',
                              arguments: list[idx].userId);
                        }),
                  ),
                );
              })
            : Center(
                child: CircularProgressIndicator(),
              );
      })),
    );
  }
}
