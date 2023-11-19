import 'package:flutter/material.dart';
import 'package:soccer/pages/profile/widgets/profile_pay_day.dart';
import 'package:soccer/pages/profile/widgets/profile_top_content.dart';
import 'package:soccer/pages/profile/providers/provider_profile.dart';

import '../CustomWidgets/custom_button_exit.dart';
import 'models/profile_model.dart';
import 'widgets/custom_card_info.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final double _heightProfile = 200.0;
  final ProviderProfile _providersProfile = ProviderProfile();

  @override
  void initState() {
    super.initState();
    _getProfile();
  }

  _getProfile() async {
    await _providersProfile.getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text("Profile"),
          automaticallyImplyLeading: false,
          elevation: 0,
          actions: [CustomButtonExit()],
        ),
        body: _generateContent(),
      ),
    );
  }

  Widget _generateContent() => StreamBuilder(
        stream: _providersProfile.profileStream,
        builder: (BuildContext context, AsyncSnapshot<ProfileModel> snapshot) =>
            snapshot.hasData
                ? Column(
                    children: [
                      _generateTop(profile: snapshot.data),
                      _generateInfo(profile: snapshot.data),
                      const Spacer(),
                      ProfilePayDay(nextDate: snapshot.data!.nextDate),
                    ],
                  )
                : const Center(child: CircularProgressIndicator()),
      );

  Widget _generateInfo({required ProfileModel? profile}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomCardInfo(
            title: "Fecha de ingreso",
            text: profile!.dateEntry.split('T').first,
            icon: Icons.calendar_month_rounded),
        CustomCardInfo(
            title: 'Contacto de emergencia',
            text: profile.emergencyContact,
            icon: Icons.contact_phone_rounded),
        CustomCardInfo(
            title: 'Correo eléctronico',
            text: profile.email,
            icon: Icons.email_outlined)
      ],
    );
  }

  Widget _generateTop({required ProfileModel? profile}) => SizedBox(
        height: _heightProfile + 30,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            _generateProfile(profile: profile),
            _generateData(profile: profile),
          ],
        ),
      );

  Widget _generateData({required ProfileModel? profile}) => Positioned(
        top: _heightProfile - 40,
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            width: 180,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _generateOption(
                  count: profile!.countPayments,
                  icon: Icons.fact_check_rounded,
                ),
                _generateOption(
                  count: profile.countRoutine,
                  icon: Icons.note_alt_rounded,
                ),
              ],
            ),
          ),
        ),
      );

  Widget _generateOption({required IconData icon, required int count}) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.grey.shade500),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              count.toString(),
              style: const TextStyle(
                  fontWeight: FontWeight.w700, color: Colors.blue),
            ),
          ),
        ],
      );

  Widget _generateProfile({required ProfileModel? profile}) =>
      ProfileTopContent(name: profile!.name, image: profile.image);
}
