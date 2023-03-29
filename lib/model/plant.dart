class Plant {
  final int index;
  final String name;
  final String disease;
  final String type;
  final String pathogen;
  final List<String> symptoms;
  final List<String> remedies;
  const Plant({
    required this.index,
    required this.name,
    required this.disease,
    required this.type,
    required this.pathogen,
    required this.symptoms,
    required this.remedies,
  });
}
