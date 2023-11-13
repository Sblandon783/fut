import 'dart:async';

import 'package:soccer/pages/admin/models/payments_model.dart';
import 'package:soccer/pages/admin/models/profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/payment_filter_model.dart';

class ProviderPayments {
  ProviderPayments();

  final Supabase _supabase = Supabase.instance;
  List<PaymentModel> members = [];
  final _memberStreamController =
      StreamController<List<PaymentModel>>.broadcast();

  Function(List<PaymentModel>) get membersSink =>
      _memberStreamController.sink.add;
  Stream<List<PaymentModel>> get membersStream =>
      _memberStreamController.stream;

  Future getPayments({required PaymentFilterModel filter}) async {
    final Map<String, dynamic> params = {
      '_name': filter.name,
      '_type': filter.type
    };
    final List<dynamic> response =
        await _supabase.client.rpc('get_payments', params: params);
    print('API: get get_payments -- params: $params');
    PaymentsModel paymentsResponse = PaymentsModel.fromJson(response);

    members = paymentsResponse.members;
    membersSink(members);
  }

  Future<bool> addMember({required ProfileModel member}) async {
    await _supabase.client.from('user').insert({
      'name': member.name,
      'image': member.image,
      'emergency_contact': member.emergencyContact,
      'contact': member.contact,
      'email': member.email,
    });

    return true;
  }

  Future<bool> updatePaymentMember({required PaymentModel payment}) async {
    final Map<String, dynamic> params = {
      'id_user': payment.idUser,
      'date': payment.date,
      'type': payment.type,
      'next_date': payment.nextDate,
    };
    await _supabase.client.from('user_payment').insert(params);
    print('API: insert  user_payment -- params: $params');
    return true;
  }
}
