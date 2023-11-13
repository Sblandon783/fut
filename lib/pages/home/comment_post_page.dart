import 'package:flutter/material.dart';
import 'package:soccer/pages/home/models/comment_model.dart';

import '../../user_preferences.dart';

import 'models/post_model.dart';
import 'providers/provider_post.dart';

class CommennPostPage extends StatefulWidget {
  final PostModel post;
  const CommennPostPage({Key? key, required this.post}) : super(key: key);

  @override
  CommennPostPageState createState() => CommennPostPageState();
}

class CommennPostPageState extends State<CommennPostPage> {
  final ScrollController _controller = ScrollController();

  final UserPreferences _prefs = UserPreferences();
  final ProvidersHome _provider = ProvidersHome();
  final TextEditingController _postController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _getComments();
  }

  _getComments() async {
    await _provider.getComments(idPost: widget.post.idPost);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text("Details"),
          automaticallyImplyLeading: true,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Container(
            color: const Color.fromARGB(255, 233, 233, 233),
            height: double.infinity,
            child: SingleChildScrollView(
              controller: _controller,
              child: Column(
                children: [
                  _generateContent(),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      height: 190,
                      width: double.infinity,
                      child: _generateMyComment(),
                    ),
                  ),
                  _generateComments(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _generateComments() {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 20.0),
      child: StreamBuilder(
        stream: _provider.commentsStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<CommentModel>> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!.isNotEmpty
                ? Column(
                    children: snapshot.data!
                        .map((comment) => _generateComment(comment: comment))
                        .toList(),
                  )
                : const Padding(
                    padding: EdgeInsets.only(top: 50.0),
                    child: Text("You can be the first comment!"),
                  );
          } else {
            return const Padding(
              padding: EdgeInsets.only(top: 50.0),
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _generateComment({required CommentModel comment}) {
    BorderSide border =
        const BorderSide(color: Color.fromARGB(255, 103, 103, 103), width: 1.0);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        decoration: BoxDecoration(
          border:
              Border(right: border, left: border, bottom: border, top: border),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: comment.idUser == _prefs.userId
                    ? const Color.fromARGB(255, 84, 84, 84)
                    : const Color.fromARGB(255, 119, 119, 119),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
              ),
              child: _generateProfile(
                userName: comment.username,
                userId: comment.idUser,
                imageUser: comment.userImage,
                id: comment.id,
              ),
            ),
            Flexible(
              flex: 1,
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 7.0, vertical: 5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3.0),
                        child: Text(comment.comment,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black54)),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(comment.date,
                            textAlign: TextAlign.end,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black45,
                                fontSize: 12.0)),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  _generateProfile(
          {bool showSend = false,
          required String userName,
          required int userId,
          required String imageUser,
          required int id}) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 7.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage(imageUser),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                userName,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            if (showSend) ...[
              const Spacer(),
              ElevatedButton(
                  onPressed: _addComment,
                  child: const Icon(Icons.send_rounded)),
            ],
            if (!showSend && userId == _prefs.userId) ...[
              const Spacer(),
              GestureDetector(
                onTapDown: (details) =>
                    _generateMenu(details: details, idComment: id),
                child: const Icon(
                  Icons.more_vert_outlined,
                  color: Colors.white,
                ),
              ),
            ]
          ],
        ),
      );

  _generateMenu({required TapDownDetails details, required int idComment}) {
    showMenu(
        context: context,
        position: RelativeRect.fromLTRB(
          details.globalPosition.dx,
          details.globalPosition.dy,
          details.globalPosition.dx,
          details.globalPosition.dy,
        ),
        items: [
          PopupMenuItem<int>(
            value: 0,
            child: const Text('Delete'),
            onTap: () => _deleteComment(idComment: idComment),
          ),
        ]);
  }

  _deleteComment({required int idComment}) async {
    bool resolve = await _provider.deleteCommetPost(idComment: idComment);
    if (resolve) {
      _getComments();
    }
  }

  _generateMyComment() {
    BorderSide border = const BorderSide(color: Colors.blue, width: 1.0);
    return Container(
      decoration: BoxDecoration(
        border:
            Border(right: border, left: border, bottom: border, top: border),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7.0),
              child: TextField(
                controller: _postController,
                obscureText: false,
                decoration: const InputDecoration(
                  hintText: 'What do you think?',
                ),
                maxLines: 6,
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(211, 62, 151, 224),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
            ),
            child: _generateProfile(
              showSend: true,
              userName: widget.post.username,
              userId: widget.post.idPost,
              imageUser: widget.post.userImage,
              id: widget.post.idPost,
            ),
          )
        ],
      ),
    );
  }

  Widget _generateContent() =>
      const Padding(padding: EdgeInsets.only(top: 10.0), child: Text("data"));

  _addComment() async {
    bool response = await _provider.addCommetPost(
      comment: _postController.text,
      idPost: widget.post.idPost,
    );
    if (response) {
      _postController.text = "";
      _getComments();
    }
  }
}
