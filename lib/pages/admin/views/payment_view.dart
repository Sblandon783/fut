import 'package:flutter/material.dart';
import 'package:soccer/pages/routines/widgets/dialogs/alerts.dart';

import '../../CustomWidgets/custom_button_exit.dart';
import '../models/payment_filter_model.dart';
import '../models/payments_model.dart';
import '../providers/provider_payments.dart';
import '../widgets/custom_circle_button.dart';
import '../widgets/payments_filter.dart';
import 'member_card_payment.dart';

class PaymentViewView extends StatefulWidget {
  const PaymentViewView({Key? key}) : super(key: key);

  @override
  PaymentViewViewState createState() => PaymentViewViewState();
}

class PaymentViewViewState extends State<PaymentViewView> {
  final ProviderPayments _provider = ProviderPayments();
  final TextEditingController _searchController = TextEditingController();
  final PaymentFilterModel _filter = PaymentFilterModel();
  final String _textSearchMembers = 'Buscar miembros';

  @override
  void initState() {
    super.initState();
    _getPayments();
    _searchController.addListener(() => _filter.name = _searchController.text);
  }

  void _getPayments() => _provider.getPayments(filter: _filter);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text("Pagos"),
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: const EdgeInsets.only(right: 0),
            child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back)),
          ),
          actions: [CustomButtonExit()],
        ),
        body: Container(
          width: double.infinity,
          color: Colors.grey.shade300,
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Column(
            children: [
              _generateTopSection(),
              const Divider(color: Colors.grey, height: 5, thickness: 0.5),
              Flexible(
                child: SingleChildScrollView(
                  child: StreamBuilder(
                      stream: _provider.membersStream,
                      builder: (BuildContext context,
                          AsyncSnapshot<List<PaymentModel>> snapshot) {
                        if (snapshot.hasData) {
                          return snapshot.data!.isNotEmpty
                              ? Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: snapshot.data!
                                      .map(
                                        (member) => MemberCardPayment(
                                          member: member,
                                          provider: _provider,
                                        ),
                                      )
                                      .toList(),
                                )
                              : const Text("Not data");
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _generateTopSection() {
    return Container(
      height: 75.0,
      width: double.infinity,
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: _searchController,
              obscureText: false,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                label: Text(_textSearchMembers),
                suffixIcon: GestureDetector(
                    onTap: () {
                      _searchController.text = "";
                      _getPayments();
                    },
                    child: const Icon(Icons.close)),
              ),
              maxLines: 1,
              minLines: 1,
            ),
          ),
          CustomCircleButton(
            icon: Icons.search_rounded,
            onTap: _search,
          ),
          CustomCircleButton(
            icon: Icons.more_vert_rounded,
            onTap: _filterOnTap,
          ),
        ],
      ),
    );
  }

  void _search() {
    _filter.searchMember();
    _getPayments();
  }

  void _filterOnTap() {
    Widget content = PaymentsFilter(filter: _filter);
    Alerts.content(
        context: context,
        content: content,
        text: _textSearchMembers,
        onPressed: () {
          _searchController.text = _filter.name;
          Navigator.pop(context);
          _getPayments();
        });
  }
}
