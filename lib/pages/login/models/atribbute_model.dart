class AttributesModel {
  AttributeModel attack;
  AttributeModel technique;
  AttributeModel creative;
  AttributeModel tactic;
  AttributeModel defense;

  AttributesModel({
    required this.attack,
    required this.technique,
    required this.creative,
    required this.tactic,
    required this.defense,
  });

  factory AttributesModel.fromJson(Map<dynamic, dynamic> response) =>
      AttributesModel(
        attack: AttributeModel(
            name: _mapTranslate[_attackStr]!, total: response[_attackStr]),
        technique: AttributeModel(
            name: _mapTranslate[_techniqueStr]!,
            total: response[_techniqueStr]),
        creative: AttributeModel(
            name: _mapTranslate[_creativeStr]!, total: response[_creativeStr]),
        tactic: AttributeModel(
            name: _mapTranslate[_tacticStr]!, total: response[_tacticStr]),
        defense: AttributeModel(
            name: _mapTranslate[_defensekStr]!, total: response[_defensekStr]),
      );
}

class AttributeModel {
  String name;
  int total;

  AttributeModel({required this.name, required this.total});
}

//CONSTANTS
const String _attackStr = "attack";
const String _techniqueStr = "technique";
const String _creativeStr = "creative";
const String _tacticStr = "tactic";
const String _defensekStr = "defense";
const Map<String, String> _mapTranslate = {
  _attackStr: "Ataque",
  _techniqueStr: "Técnica",
  _creativeStr: "Creatividad",
  _tacticStr: "Táctica",
  _defensekStr: "Defensa",
};
