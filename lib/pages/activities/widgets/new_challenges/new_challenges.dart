import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:soccer/pages/activities/widgets/new_challenges/title_new_challenges.dart';

import '../../../CustomWidgets/empty_data.dart';
import '../../../home/provider/provider_matches.dart';
import '../../../login/models/field_notifier.dart';
import '../../../login/models/match_model.dart';
import '../../../login/providers/provider_members.dart';
import '../../../login/utils/utils.dart';
import '../../../login/widgets/custom_toggle.dart';
import '../../../login/widgets/match/match_card/match_card.dart';
import '../../../profile/nav_bar/exit_button.dart';
import '../../../profile/nav_bar/leading_button.dart';
import 'create_challenge.dart';

class NewChallenges extends StatefulWidget {
  const NewChallenges({Key? key}) : super(key: key);

  @override
  NewChallengesState createState() => NewChallengesState();
}

class NewChallengesState extends State<NewChallenges> {
  final ProviderMatches _provider = ProviderMatches();
  final ProviderMembers _providerMembers = ProviderMembers();
  final ValueNotifier<FieldNotifier> _typeAlignNotifier =
      ValueNotifier(FieldNotifier(idField: -1, idAlign: -1));
  final Map<int, String> tabs = {1: "Confirmados", 2: "Nuevos"};
  int _tabIndex = 1;
  @override
  void initState() {
    super.initState();
    _calls();
  }

  void _calls() async {
    await _provider.getFields();
    await _provider.getMatches();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade700,
          automaticallyImplyLeading: false,
          elevation: 0,
          actions: [ExitButton()],
          leading: const LeadingButton(),
          centerTitle: false,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _onTap,
          child: const Icon(Icons.add),
        ),
        backgroundColor: Colors.blue.shade700,
        body: _generateContent(),
      ),
    );
  }

  Widget _generateContent() => StreamBuilder(
      stream: _provider.matchesStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<MatchModel>> snapshot) {
        if (snapshot.hasData) {
          return snapshot.data != null
              ? Center(
                  child: Container(
                    constraints:
                        const BoxConstraints(minWidth: 100, maxWidth: 600),
                    child: _content(matches: snapshot.data!),
                  ),
                )
              : const SizedBox.shrink();
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      });

  Widget _content({required List<MatchModel> matches}) {
    final List<MatchModel> matchesCurrent =
        matches.where((match) => !match.isFinished).toList();

    return Column(
      children: [
        TitleWewChallenges(tab: _tabIndex),
        Container(
          color: const Color.fromARGB(186, 21, 84, 136),
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 2.0,
          ),
          child: CustomToggle(
            changeIndex: _changeIndex,
            tabIndex: _tabIndex,
            tabs: tabs,
          ),
        ),
        _column(matches: matchesCurrent),
      ],
    );
  }

  Widget _column({required List<MatchModel> matches}) => matches.isEmpty
      ? const Flexible(
          child: EmptyData(
            text: "No hay partidos disponibles",
            image: "there_aren't_match.jpeg",
          ),
        )
      : Flexible(
          child: ListView.builder(
            itemCount: matches.length,
            itemBuilder: (context, index) {
              final MatchModel match = matches[index];
              return _generateMatch(match: match);
            },
          ),
        );

  Widget _generateMatch({required MatchModel match}) {
    MatchCard matchCard = MatchCard(
      match: match,
      typeAlignNotifier: _typeAlignNotifier,
      fields: _tabIndex == tabs.keys.first ? _provider.fields : [],
      providerMembers: _providerMembers,
    );

    Widget matchWidget =
        _tabIndex != 1 ? IgnorePointer(child: matchCard) : matchCard;
    return _tabIndex == 1
        ? matchWidget
        : Slidable(
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  flex: 1,
                  onPressed: (context) {
                    _requestToChanllenge(isAccept: true, match: match);
                  },
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  icon: Icons.check,
                  label: 'Aceptar',
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  autoClose: true,
                ),
                SlidableAction(
                  flex: 1,
                  onPressed: (context) {
                    _requestToChanllenge(isAccept: false, match: match);
                  },
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
              ],
            ),
            child: matchWidget,
          );
  }

  _onTap() {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => const AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        content: SizedBox(
          width: 320,
          child: CreateChallenge(),
        ),
        insetPadding: EdgeInsets.zero,
      ),
    ).then((dynamic value) async {
      if (value != null && value) {
        SnackBar snackBar = SnackBar(
          content: const Text("Reto creado"),
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {},
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        await _provider.getMatches();
      }
    });
  }

  void _changeIndex({required int tabIndex}) async {
    if (tabIndex == tabs.keys.first) {
      await _provider.getMatches();
    } else if (tabIndex == tabs.keys.last) {
      await _provider.getChallenges();
    }
    setState(() => _tabIndex = tabIndex);
  }

  void _requestToChanllenge({
    required bool isAccept,
    required MatchModel match,
  }) {
    match.idField = 1;
    match.idAlign = 1;
    //match.parsedDate = Parsed

    String date = match.parsedDate.toString().split(" ").first;
    date = '$date 20:00';
    date = '2024-01-16 20:00:00';
    DateTime dateMatch = Utils().getParsedDate(date: date);

    match.parsedDate = dateMatch;

    if (isAccept) {
      _provider.createMatch(match: match);
    }
    _provider.deleteChallenge(id: match.id);
    setState(() {});
  }
}
