import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'widgets/custom_drop_down.dart';

class FirstPart extends StatefulWidget {
  final TextEditingController usernameController;

  final TextEditingController passwordController;
  final TextEditingController numberController;
  final Function({required int pos}) changePosition;
  final Function({required bool isStartSession}) login;
  const FirstPart({
    super.key,
    required this.usernameController,
    required this.passwordController,
    required this.numberController,
    required this.changePosition,
    required this.login,
  });

  @override
  FirstPartState createState() => FirstPartState();
}

class FirstPartState extends State<FirstPart> {
  final Map<int, String> _list = {
    1: 'POR',
    2: 'LTD',
    3: 'LTI',
    4: 'DFC',
    5: 'MD',
    6: 'MC',
    7: 'DC'
  };
  bool _show = false;
  final double _heightProfile = 300;
  bool _isStartSession = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Positioned(
        top: _heightProfile - 150,
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            width: 300,
            height: _isStartSession ? 380 : 430,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            padding: const EdgeInsets.only(
                top: 10, left: 10, right: 10.0, bottom: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 40.0, bottom: 20.0),
                  child: Center(
                    child: Text(
                      "Listo para el fútbol",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.blue,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                TextField(
                  controller: widget.usernameController,
                  obscureText: false,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nombre del crack!',
                  ),
                  maxLength: 20,
                ),
                TextField(
                  controller: widget.passwordController,
                  obscureText: !_show,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Contraseña',
                    suffixIcon: GestureDetector(
                        onTap: () => setState(() => _show = !_show),
                        child: Icon(_show
                            ? Icons.remove_red_eye_sharp
                            : Icons.remove_red_eye_outlined)),
                  ),
                  maxLength: 20,
                ),
                if (!_isStartSession)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 80.0,
                        padding: const EdgeInsets.only(left: 10.0, top: 5),
                        child: TextField(
                          controller: widget.numberController,
                          decoration:
                              const InputDecoration(labelText: "Número"),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 60.0,
                        child: CustomDropDown(
                          key: UniqueKey(),
                          dropdownValue: _list.keys.first.toString(),
                          list: _list,
                          change: widget.changePosition,
                          text: "Posición",
                        ),
                      ),
                    ],
                  ),
                Center(
                  child: GestureDetector(
                    onTap: () =>
                        setState(() => _isStartSession = !_isStartSession),
                    child: Text(
                      _isStartSession
                          ? "Quiero ser una leyenda"
                          : "Ya soy una leyenda",
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
                _isStartSession
                    ? Center(
                        child: ElevatedButton(
                        onPressed: () =>
                            widget.login(isStartSession: _isStartSession),
                        child: const Text("Iniciar como leyenda"),
                      ))
                    : Center(
                        child: ElevatedButton(
                        onPressed: () =>
                            widget.login(isStartSession: _isStartSession),
                        child: const Text("Registrarme como leyenda"),
                      ))
              ],
            ),
          ),
        ),
      );
}
