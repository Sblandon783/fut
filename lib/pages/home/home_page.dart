import 'package:flutter/material.dart';
import 'package:soccer/pages/home/models/match_model.dart';
import 'package:soccer/pages/login/login_page.dart';
import 'package:soccer/pages/profile/models/pet_model.dart';

import '../../services/notifi_service.dart';
import '../../user_preferences.dart';
import 'create_pet.dart';
import 'create_match.dart';
import 'models/post_model.dart';
import 'providers/provider_post.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final ScrollController _controller = ScrollController();
  final UserPreferences _prefs = UserPreferences();
  final ProvidersHome _provider = ProvidersHome();
  @override
  void initState() {
    //NotificationService().start(_prefs.nextDatePayment);
    super.initState();
    _getPosts();
  }

  _getPosts() async => _provider.getRoutines();

  void _deletePost({required int idPost}) async => _provider
      .deletePost(idPost: idPost)
      .then((value) => value ? _getPosts() : null);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text("Home"),
          automaticallyImplyLeading: false,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: GestureDetector(
                  onTap: () {
                    _prefs.isLogin = false;
                    final route = MaterialPageRoute(
                        builder: (context) => const LoginPage());
                    Navigator.push(context, route);
                  },
                  child: const Icon(Icons.exit_to_app_rounded)),
            )
          ],
        ),
        /*
        floatingActionButton: FloatingActionButton(
          onPressed: _showMyDialogAddPost,
          tooltip: 'Agregar partido',
          child: const Icon(
            Icons.add,
            size: 20.0,
          ),
        ),
        */
        body: _generateContent(),
      ),
    );
  }

  Widget _generateContent() => StreamBuilder(
        stream: _provider.matchesStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<MatchModel>> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!.isNotEmpty
                ? Container(
                    color: const Color.fromARGB(255, 214, 214, 214),
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 35.0,
                          alignment: Alignment.center,
                          child: const Text(
                            "Partidos",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        const Padding(
                            padding: EdgeInsets.only(top: 40.0),
                            child: Text(
                                "qsas") /*CustomGridview(
                            posts: snapshot.data ?? [],
                            controller: _controller,
                            deletePost: _deletePost,
                          ),*/
                            ),
                      ],
                    ),
                  )
                : const Text("data");
          } else {
            return const SizedBox.shrink();
          }
        },
      );

  Future<void> _showMyDialogAddPost() async {
    PostModel newPost = PostModel();
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 7),
          content: CreateMatch(post: newPost),
          actions: <Widget>[
            Center(
              child: ElevatedButton(
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.0),
                  child: Text('Reservar'),
                ),
                onPressed: () => _callCreatePost(newPost: newPost),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showMyDialogAddPet() async {
    PetModel pet = PetModel(name: "", image: "");

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 7),
          content: CreatePet(pet: pet),
          actions: <Widget>[
            Center(
              child: ElevatedButton(
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.0),
                  child: Text('Add pet'),
                ),
                onPressed: () => _callCreatePet(newPet: pet),
              ),
            ),
          ],
        );
      },
    );
  }

  _callCreatePet({required PetModel newPet}) async {
    bool result = await _provider.createPet(pet: newPet);
    if (result) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);

      setState(() => _showOption = !_showOption);
    }
  }

  _callCreatePost({required PostModel newPost}) async {
    bool result = await _provider.createPost(post: newPost);
    if (result) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      _getPosts();
      _controller.animateTo(
        0,
        duration: const Duration(milliseconds: 100),
        curve: Curves.bounceIn,
      );
      setState(() => _showOption = !_showOption);
    }
  }

  bool _showOption = false;
  _add() => setState(() => _showOption = !_showOption);
}
