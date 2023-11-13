import 'package:flutter/material.dart';

class CustomCard3 extends StatelessWidget {
  final String text;
  final Function() onTap;
  final String icon;
  const CustomCard3(
      {super.key, required this.text, required this.onTap, required this.icon});

  @override
  Widget build(BuildContext context) => Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 150,
          width: 150,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.blue,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      color: Colors.blue.shade100,
                    ),
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Image(
                      width: 80.0,
                      image: AssetImage('assets/$icon.png'),
                    )),
              ),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  //color: Colors.blue,
                ),
                width: double.infinity,
                height: 30.0,
                alignment: Alignment.center,
                child: Text(
                  text,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ));
}
