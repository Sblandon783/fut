import 'package:flutter/material.dart';
import 'package:soccer/pages/home/models/post_model.dart';

class CreateMatch extends StatefulWidget {
  final PostModel post;
  const CreateMatch({Key? key, required this.post}) : super(key: key);

  @override
  CreateMatchState createState() => CreateMatchState();
}

class CreateMatchState extends State<CreateMatch> {
  final _image =
      "https://s1.eestatic.com/2020/08/26/curiosidades/mascotas/mascotas-perros-gatos_515959375_158488465_1706x960.jpg";
  final TextEditingController _firstTeamController = TextEditingController();
  final TextEditingController _secondTeamController = TextEditingController();
  int _selectId = 0;
  final int _selectIWantId = 1;
  final int _selectIHaveId = 0;

  @override
  void initState() {
    widget.post.image = _image;

    super.initState();
  }

  @override
  void dispose() {
    _firstTeamController.dispose();
    _secondTeamController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Align(
            alignment: Alignment.topRight,
            child: Icon(Icons.close),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Text(
                  "Reservar cancha",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                ),
              ),
              _createButtons(),
              _createConten(),
            ],
          ),
        )
      ],
    );
  }

  Widget _createConten() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        color: Colors.blue.shade200,
        height: 350,
        width: double.infinity,
        child: _selectId == _selectIHaveId ? _contenIhave() : _contenIWant(),
      ),
    );
  }

  Widget _contenIhave() {
    return Column(
      children: [
        const Text("Fecha del encuentro"),
        ElevatedButton(
            onPressed: () {}, child: const Text("12/12/2020 a las 7:00 PM")),
        const SizedBox(height: 30.0, width: double.infinity),
        const Text("Equipos"),
        const SizedBox(height: 10.0, width: double.infinity),
        _generateInput(
            controller: _firstTeamController, text: "Escriba el primer equipo"),
        const Text("VS"),
        _generateInput(
            controller: _secondTeamController,
            text: "Escriba el segundo equipo"),
      ],
    );
  }

  Widget _contenIWant() {
    return Column(
      children: [
        const Text("Fecha del encuentro"),
        ElevatedButton(
            onPressed: () {}, child: const Text("12/12/2020 a las 7:00 PM")),
        const SizedBox(height: 30.0, width: double.infinity),
        _generateTeam(),
        const Text("VS"),
        _generateInput(
            controller: _secondTeamController, text: "Escriba mi equipo"),
      ],
    );
  }

  Widget _generateTeam() => Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          padding: const EdgeInsets.all(5.0),
          color: Colors.white,
          child: Column(
            children: const [
              Icon(Icons.sports_soccer),
              Text("Galacticos"),
            ],
          ),
        ),
      );

  Widget _generateInput(
          {required TextEditingController controller, required String text}) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: TextField(
          controller: controller,
          obscureText: false,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            label: Text(text),
          ),
          maxLines: 1,
          minLines: 1,
        ),
      );

  Widget _createButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        _createCustomButton(text: "Tengo reto", id: _selectIHaveId),
        _createCustomButton(text: "Quiero reto", id: _selectIWantId),
        const SizedBox(height: 20.0),
      ],
    );
  }

  Widget _createCustomButton({required String text, required int id}) {
    return Flexible(
      child: GestureDetector(
        onTap: () => setState(() => _selectId = id),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: Container(
            padding: const EdgeInsets.all(10.0),
            width: double.infinity,
            alignment: Alignment.center,
            color:
                id == _selectId ? Colors.blue.shade500 : Colors.blue.shade200,
            child: Text(text),
          ),
        ),
      ),
    );
  }
}
