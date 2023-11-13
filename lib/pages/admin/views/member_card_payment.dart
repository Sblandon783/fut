import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../routines/widgets/dialogs/alerts.dart';
import '../models/payments_model.dart';
import '../providers/provider_payments.dart';
import '../widgets/payments_member.dart';

class MemberCardPayment extends StatelessWidget {
  final PaymentModel member;
  final ProviderPayments provider;
  const MemberCardPayment(
      {super.key, required this.member, required this.provider});

  @override
  Widget build(BuildContext context) => ClipRRect(
        child: GestureDetector(
          onTap: () => _updatePayment(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: SizedBox(
              height: 180.0,
              width: 350.0,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Container(
                      padding: const EdgeInsets.only(left: 135.0),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            (member.name.length > 20
                                    ? '${member.name.substring(0, 20)}...'
                                    : member.name)
                                .toUpperCase(),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),
                          _generateRow(
                            icon: Icons.grade_outlined,
                            text: 'Membresía',
                            subText:
                                member.type == 1 ? 'Mensual' : 'Trimestral',
                          ),
                          _generateRow(
                            icon: Icons.payment_rounded,
                            text: 'Último pago ',
                            subText: member.date,
                          ),
                          _generateRow(
                            icon: Icons.calendar_month_rounded,
                            text: 'Siguiente pago ',
                            subText: member.nextDate,
                          ),
                        ],
                      ),
                    ),
                  ),
                  _generateTop(),
                ],
              ),
            ),
          ),
        ),
      );

  Widget _generateTop() => SizedBox(
        height: double.infinity,
        width: 130.0,
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(40.0),
              child: Image(
                  height: double.infinity,
                  fit: BoxFit.fill,
                  image: AssetImage(
                      'assets/${member.name.toUpperCase().contains('ME') ? 'background_payment_2.png' : 'background_payment_3.png'}')), // BoxDecoration
            ),
            Container(
              padding: const EdgeInsets.all(3.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                color: Colors.white,
              ),
              width: 90.0,
              height: 90.0,
              child: CircleAvatar(
                radius: 10,
                backgroundImage: member.image.contains('https')
                    ? NetworkImage(member.image)
                    : imageFromBase64String(),
              ),
            ),
          ],
        ),
      );
  void _updatePayment(BuildContext context) {
    PaymentModel payment = member;
    Widget content = PaymentsMembers(
      payment: payment,
      provider: provider,
    );
    Alerts.content(
        context: context,
        content: content,
        text: 'Actualizar membresía',
        onPressed: () {
          provider.updatePaymentMember(payment: payment);
          Navigator.pop(context);
        });
  }

  Widget _generateRow({
    required IconData icon,
    required String text,
    required String subText,
  }) {
    return Padding(
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
                  color: Colors.grey,
                ),
              ),
              Text(
                text,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                    color: Colors.grey),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 19.0),
            child: Text(subText,
                style: const TextStyle(fontSize: 12.0, color: Colors.grey)),
          ),
        ],
      ),
    );
  }

  imageFromBase64String() {
    Uint8List profile = base64.decode(member.image);
    return MemoryImage(profile);
  }

  Uint8List dataFromBase64String(String base64String) =>
      base64Decode(base64String);

  String base64String(Uint8List data) => base64Encode(data);
}
