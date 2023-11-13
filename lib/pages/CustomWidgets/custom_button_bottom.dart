import 'package:flutter/material.dart';

class CustomButtonBottom extends StatelessWidget {
  final Function() onTap;
  final String positiveText;
  const CustomButtonBottom(
      {super.key, required this.onTap, required this.positiveText});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.white,
                width: 0.5,
              ),
            ),
          ),
          height: 30.0,
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Row(
              children: [
                Flexible(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: Center(
                        child: Text(
                          "CANCELAR",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  height: double.infinity,
                  width: 1.0,
                ),
                Flexible(
                  child: GestureDetector(
                    onTap: onTap,
                    child: SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: Center(
                        child: Text(
                          positiveText,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
