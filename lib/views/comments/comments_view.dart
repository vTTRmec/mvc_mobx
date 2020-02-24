import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mvc_example/controllers/post_controller.dart';

class CommentsView extends StatefulWidget {
  final int idPost;

  const CommentsView({Key key, this.idPost}) : super(key: key);

  @override
  _CommentsViewState createState() => _CommentsViewState();
}

class _CommentsViewState extends State<CommentsView> {
  PostController _postController;

  @override
  void initState() {
    super.initState();
    _postController = PostController();
    _postController.loadComments(idPosts: widget.idPost);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Text('Comentarios', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
            Expanded(
                child: Observer(                  
                  builder: (context) {
                    return _postController.listComment != null ? ListView.builder(
                        itemCount: _postController.listComment.length,
                        itemBuilder: (ctx, idx) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              child: ListTile(
                                  title: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(_postController.listComment[idx].email),
                                  ),
                                  subtitle:
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(_postController.listComment[idx].body, textAlign: TextAlign.justify,),
                                      )),
                            ),
                          );
                        }) : Center(child: CircularProgressIndicator());
                  }
                ))
          ],
        ),
      ),
    );
  }
}
