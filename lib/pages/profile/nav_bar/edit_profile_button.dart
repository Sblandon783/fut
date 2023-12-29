import 'package:flutter/material.dart';
import 'package:soccer/pages/login/models/member_model.dart';
import 'package:soccer/user_preferences.dart';

import '../providers/provider_profile.dart';
import 'alert_edit_profile.dart';

class EditProfileButton extends StatelessWidget {
  final UserPreferences _prefs = UserPreferences();
  final ProviderProfile provider;
  final MemberModel member;
  EditProfileButton({
    super.key,
    required this.provider,
    required this.member,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: GestureDetector(
          onTap: () => _onTap(context: context),
          child: const Icon(
            Icons.edit,
            color: Colors.white,
          )),
    );
  }

  _onTap({required BuildContext context}) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        content: EditProfile(member: member),
        insetPadding: EdgeInsets.zero,
      ),
    ).then((dynamic value) {
      provider.updateMember(newMember: member);
    });
  }
}
