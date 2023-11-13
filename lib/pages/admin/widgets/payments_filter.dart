import 'dart:async';

import 'package:flutter/material.dart';

import '../models/payment_filter_model.dart';
import 'custom_radio_button.dart';

class PaymentsFilter extends StatelessWidget {
  final PaymentFilterModel filter;
  final TextEditingController _searchController = TextEditingController();
  final StreamController _typeController = StreamController();
  final Map<int, String> list = {
    0: 'Todos',
    1: 'Al día',
    2: 'Pendiente',
    3: 'Vencidos'
  };
  final String title = "Selecciona un estado";

  PaymentsFilter({super.key, required this.filter});

  @override
  Widget build(BuildContext context) {
    _searchController.addListener(() => filter.name = _searchController.text);
    _typeController.stream.listen((type) => filter.type = int.parse(type));

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: SizedBox(
              height: 40.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: const Text(
                          "Busqueda avanzada",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                  ),
                  GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.close))
                ],
              ),
            ),
          ),
          Flexible(
            child: TextField(
              controller: _searchController,
              obscureText: false,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Buscar miembro'),
              ),
              maxLines: 1,
              minLines: 1,
            ),
          ),
          CustomRadioButton(
            list: list,
            typeController: _typeController,
            title: title,
            selected: filter.type,
          ),
        ],
      ),
    );
  }
}
