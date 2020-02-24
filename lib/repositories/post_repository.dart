import 'dart:convert';

import 'package:mvc_example/interfaces/post_repository_interface.dart';
import 'package:mvc_example/models/comment_model.dart';
import 'package:mvc_example/models/post_model.dart';
import 'package:http/http.dart' as http;
import 'package:mvc_example/shared/consts_api.dart';

// dentro dos métodos, implementar as requisições http

class PostRepository implements IPostRepository {

  PostRepository() {
    
  }

  @override
  Future<List<Post>> getAllPosts() async {    
    
    try {
      List<Post> list = List();
      var response = await http.get(ConstsApi.POST_URL);

      if ( response.statusCode == 200 ) {
        var decodeJson = jsonDecode(response.body);
        decodeJson.forEach( (item) => list.add(Post.fromJson(item)));      
        return list;
      } else {
        print('erro ao carregar a lista ' + response.statusCode.toString());
        return null;
      }
    } catch (e) {
      print('erro ao carregar a lista' + e.toString());
      return null;
    }
  }

  @override
  Future<List<Comment>> getComment(int idPost) async {
    try {
      List<Comment> list = List();
      var response = await http.get(ConstsApi.POST_COMMENT + idPost.toString());

      if ( response.statusCode == 200 ) {
        var decodeJson = jsonDecode(response.body);
        decodeJson.forEach( (item) => list.add(Comment.fromJson(item)));      
        return list;
      } else {
        print('erro ao carregar a lista ' + response.statusCode.toString());
        return null;
      }
    } catch (e) {
      print('erro ao carregar a lista' + e.toString());
      return null;
    }
  }

}