class ActivitiesCountersModel {
  int newPlayers;
  int newChallenges;
  int teams;

  ActivitiesCountersModel({
    required this.newPlayers,
    required this.newChallenges,
    required this.teams,
  });

  factory ActivitiesCountersModel.fromJson(Map<String, dynamic> json) =>
      ActivitiesCountersModel(
        newPlayers: json["new_players"],
        newChallenges: json["new_challenges"],
        teams: json["teams"],
      );
}
