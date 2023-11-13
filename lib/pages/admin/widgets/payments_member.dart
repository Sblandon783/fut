import 'dart:async';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';

import '../../routines/widgets/dialogs/alerts.dart';
import '../models/payments_model.dart';
import '../providers/provider_payments.dart';
import 'custom_radio_button.dart';

class PaymentsMembers extends StatefulWidget {
  final PaymentModel payment;
  final ProviderPayments provider;
  const PaymentsMembers(
      {Key? key, required this.provider, required this.payment})
      : super(key: key);

  @override
  PaymentsMembersState createState() => PaymentsMembersState();
}

class PaymentsMembersState extends State<PaymentsMembers> {
  final StreamController _typeController = StreamController();
  final Map<int, String> list = {
    0: 'Mensual',
    //1: 'Trimestral',
    //2: 'Anual',
  };
  final String title = "Selecciona una membresía";
  List<DateTime?> _dates = [DateTime.now()];

  @override
  void initState() {
    DateTime dt = DateTime.parse(widget.payment.nextDate);
    _dates = [dt];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //_typeController.stream.listen((type) => filter.type = int.parse(type));

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
                          "Actualizar membresía",
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _generateRow(
                icon: Icons.calendar_month_rounded,
                subText: widget.payment.date,
                text: "Vencimiento",
              ),
              _generateRow(
                icon: Icons.calendar_month_rounded,
                subText: widget.payment.nextDate,
                text: "Próximo pago",
                isOnTap: true,
              ),
            ],
          ),
          CustomRadioButton(
            list: list,
            typeController: _typeController,
            title: title,
            selected: 0,
          ),
        ],
      ),
    );
  }

  Widget _generateRow({
    required IconData icon,
    required String text,
    required String subText,
    bool isOnTap = false,
  }) {
    Widget child = Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 3.0),
                child: Icon(
                  icon,
                  size: 16.0,
                  color: isOnTap ? Colors.blue : Colors.grey,
                ),
              ),
              Text(
                text,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                    color: isOnTap ? Colors.blue : Colors.grey),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 19.0),
            child: Text(subText,
                style: TextStyle(
                    fontSize: 12.0,
                    color: isOnTap ? Colors.blue : Colors.grey)),
          ),
        ],
      ),
    );
    return isOnTap ? _onTapRow(child: child) : child;
  }

  Widget _onTapRow({required Widget child}) => GestureDetector(
        onTap: () {
          Widget content = SizedBox(
            width: 300.0,
            height: 200.0,
            child: CalendarDatePicker2(
              config: CalendarDatePicker2Config(),
              value: _dates,
              onValueChanged: (dates) {
                _dates = dates;
                widget.payment.nextDate =
                    dates.first.toString().split(" ").first;
              },
            ),
          );
          Alerts.content(
              context: context,
              content: content,
              text: 'Seleccionar',
              onPressed: () {
                Navigator.pop(context);
                setState(() {});
              });
        },
        child: child,
      );
}
