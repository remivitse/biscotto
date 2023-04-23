class Exercise {
  final String name;
  final String type;
  final String muscle;
  final String equipment;
  final String difficulty;
  final String instructions;

  Exercise(
      {required this.name,
      required this.type,
      required this.muscle,
      required this.equipment,
      required this.difficulty,
      required this.instructions});

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      name: json['name'],
      type: json['type'],
      muscle: json['muscle'],
      equipment: json['equipment'],
      difficulty: json['difficulty'],
      instructions: json['instructions'],
    );
  }

  static List<String> getTypes() {
    return [
      'all_types',
      'cardio',
      'olympic_weightlifting',
      'plyometrics',
      'powerlifting',
      'strength',
      'stretching',
      'strongman',
    ];
  }

  static List<String> getMuscles() {
    return [
      'all_muscles',
      'abductors',
      'adductors',
      'biceps',
      'calves',
      'chest',
      'forearms',
      'glutes',
      'hamstrings',
      'lats',
      'lower_back',
      'middle_back',
      'quadriceps',
      'shoulders',
      'traps',
      'triceps',
    ];
  }

  /* static List<String> getEquipment() {
    return [
      'all_equipment',
    ];
  } */

  static List<String> getDifficulties() {
    return [
      'all_difficulties',
      'beginner',
      'intermediate',
      'expert',
    ];
  }

  static String format(String key) {
    return key[0].toUpperCase() + key.substring(1).replaceAll('_', ' ');
  }
}
