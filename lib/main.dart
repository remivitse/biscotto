import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final List<String> types = [
  'all_types',
  'cardio',
  'olympic_weightlifting',
  'plyometrics',
  'powerlifting',
  'strength',
  'stretching',
  'strongman',
];

final List<String> muscles = [
  'all_muscles',
  'abdominals',
  'abductors',
  'adductors',
  'biceps',
  'calves',
  'chest',
  'forearms',
  'glutes',
  'hamstrings',
  'lower_back',
  'middle_back',
  'neck',
  'quadriceps',
  'traps',
  'triceps',
];

/* final List<String> equipment = [
  'all_equipments',
]; */

final List<String> difficulties = [
  'all_difficulties',
  'beginner',
  'intermediate',
  'expert',
];

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
}

String format(String muscle) {
  return muscle[0].toUpperCase() + muscle.substring(1).replaceAll('_', ' ');
}

void main() {
  runApp(const Biscotto());
}

class Biscotto extends StatelessWidget {
  static const Color primary = Color(0xFF701F15);
  static const Color primaryDark = Color(0xFF4D140F);
  static const Color primaryLight = Color(0xFFFBF5F4);
  static const Color accent = Color(0xFF136F63);
  static const Color accentDark = Color(0xFF000F08);

  const Biscotto({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biscotto',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Biscotto.primary,
          secondary: Biscotto.accent,
          background: Biscotto.primaryLight,
          onBackground: Biscotto.primaryDark,
        ),
      ),
      home: const BiscottoSearchPage(title: 'Biscotto'),
    );
  }
}

class BiscottoSearchPage extends StatefulWidget {
  const BiscottoSearchPage({super.key, required this.title});

  final String title;

  @override
  State<BiscottoSearchPage> createState() => _BiscottoSearchPageState();
}

class _BiscottoSearchPageState extends State<BiscottoSearchPage> {
  static const String _selectedTypeDefault = 'all_types';
  static const String _selectedMuscleDefault = 'all_muscles';
  /* static const String _selectedEquipmentDefault = 'all_equipments'; */
  static const String _selectedDifficultyDefault = 'all_difficulties';

  String _selectedType = _selectedTypeDefault;
  String _selectedMuscle = _selectedMuscleDefault;
  /* String _selectedEquipment = _selectedEquipmentDefault; */
  String _selectedDifficulty = _selectedDifficultyDefault;

  DropdownMenuItem<String> buildDropdownMenuItem(String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(format(value)),
    );
  }

  List<DropdownMenuItem<String>> buildDropdownMenuItems(List<String> filter) {
    List<DropdownMenuItem<String>> items = [];
    for (String option in filter) {
      items.add(buildDropdownMenuItem(option));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          width: 240,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DropdownButton<String>(
                isExpanded: true,
                value: _selectedType,
                items: buildDropdownMenuItems(types),
                onChanged: (item) => setState(() {
                  _selectedType = item!;
                }),
              ),
              DropdownButton<String>(
                isExpanded: true,
                value: _selectedMuscle,
                items: buildDropdownMenuItems(muscles),
                onChanged: (item) => setState(() {
                  _selectedMuscle = item!;
                }),
              ),
              /* DropdownButton<String>(
                isExpanded: true,
                value: _selectedEquipment,
                items: buildDropdownMenuItems(equipment),
                onChanged: (item) => setState(() {
                  _selectedEquipment = item!;
                }),
              ), */
              DropdownButton<String>(
                isExpanded: true,
                value: _selectedDifficulty,
                items: buildDropdownMenuItems(difficulties),
                onChanged: (item) => setState(() {
                  _selectedDifficulty = item!;
                }),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BiscottoResultsPage(
                                  type: _selectedType == _selectedTypeDefault
                                      ? null
                                      : _selectedType,
                                  muscle:
                                      _selectedMuscle == _selectedMuscleDefault
                                          ? null
                                          : _selectedMuscle,
                                  /*equipment: _selectedEquipment ==
                                          _selectedEquipmentDefault
                                      ? null
                                      : _selectedEquipment, */
                                  difficulty: _selectedDifficulty ==
                                          _selectedDifficultyDefault
                                      ? null
                                      : _selectedDifficulty,
                                )));
                  },
                  child: const Text('Search'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BiscottoResultsPage extends StatelessWidget {
  final String title;
  final String? type;
  final String? muscle;
  /* final String? equipment; */
  final String? difficulty;

  const BiscottoResultsPage(
      {super.key,
      this.type,
      this.title = 'Search results',
      this.muscle,
      /* this.equipment, */
      this.difficulty});

  Future<List<Exercise>> _fetchExercises({
    String? type,
    String? muscle,
    String? difficulty,
  }) async {
    String query = 'https://api.api-ninjas.com/v1/exercises';
    bool prems = true;

    if (type != null) {
      prems = false;
      query += '?type=$type';
    }
    if (muscle != null) {
      if (prems) {
        query += '?';
        prems = false;
      } else {
        query += '&';
      }
      query += 'muscle=$muscle';
    }
    /* if (equipment != null) {
      if (prems) {
        query += '?';
        prems = false;
      } else {
        query += '&';
      }
      query += 'equipment=$equipment';
    } */
    if (difficulty != null) {
      if (prems) {
        query += '?';
        prems = false;
      } else {
        query += '&';
      }
      query += 'difficulty=$difficulty';
    }

    final response = await http.get(Uri.parse(query),
        headers: {'X-Api-Key': 'your_api_ninjas_key_here'});

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Exercise> exercises =
          body.map((dynamic item) => Exercise.fromJson(item)).toList();
      return exercises;
    } else {
      throw Exception('Failed to load exercises');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: FutureBuilder(
          future: _fetchExercises(
              type: type, muscle: muscle, difficulty: difficulty),
          builder: (context, AsyncSnapshot<List<Exercise>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return const Text('Sorry, no Biscotto for you today :(');
              }
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BiscottoExercisePage(
                                  exercise: snapshot.data![index],
                                ))),
                    title: Text(snapshot.data![index].name),
                    subtitle: Row(
                      children: [
                        Text(format(snapshot.data![index].type)),
                        const Text(' - '),
                        Text(format(snapshot.data![index].muscle)),
                        const Text(' - '),
                        Text(format(snapshot.data![index].equipment)),
                        const Text(' - '),
                        Text(format(snapshot.data![index].difficulty)),
                      ],
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

class BiscottoExercisePage extends StatelessWidget {
  final Exercise exercise;

  const BiscottoExercisePage({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(exercise.name),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 64),
          child: Center(
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 16, right: 24, left: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BiscottoResultsPage(
                                          title: format(exercise.type),
                                          type: exercise.type,
                                        )));
                          },
                          style: ButtonStyle(
                            alignment: Alignment.center,
                            backgroundColor:
                                MaterialStateProperty.all(Biscotto.primary),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.all(8)),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            elevation: MaterialStateProperty.all(0),
                          ),
                          child: Text(
                            format(exercise.type),
                            style:
                                const TextStyle(color: Biscotto.primaryLight),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BiscottoResultsPage(
                                            title: format(exercise.muscle),
                                            muscle: exercise.muscle,
                                          )));
                            },
                            style: ButtonStyle(
                              alignment: Alignment.center,
                              backgroundColor:
                                  MaterialStateProperty.all(Biscotto.primary),
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.all(8)),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              elevation: MaterialStateProperty.all(0),
                            ),
                            child: Text(
                              format(exercise.muscle),
                              style:
                                  const TextStyle(color: Biscotto.primaryLight),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: ElevatedButton(
                            onPressed: () {
                              /* Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BiscottoResultsPage(
                                            title: format(exercise.equipment),
                                            equipment: exercise.equipment,
                                          ))); */
                            },
                            style: ButtonStyle(
                              alignment: Alignment.center,
                              backgroundColor:
                                  MaterialStateProperty.all(Biscotto.primary),
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.all(8)),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              elevation: MaterialStateProperty.all(0),
                            ),
                            child: Text(
                              format(exercise.equipment),
                              style:
                                  const TextStyle(color: Biscotto.primaryLight),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BiscottoResultsPage(
                                            title: format(exercise.difficulty),
                                            difficulty: exercise.difficulty,
                                          )));
                            },
                            style: ButtonStyle(
                              alignment: Alignment.center,
                              backgroundColor:
                                  MaterialStateProperty.all(Biscotto.primary),
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.all(8)),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              elevation: MaterialStateProperty.all(0),
                            ),
                            child: Text(
                              format(exercise.difficulty),
                              style:
                                  const TextStyle(color: Biscotto.primaryLight),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(
                        top: 16, right: 24, bottom: 16, left: 24),
                    child: Text(
                      exercise.instructions,
                      style: const TextStyle(fontSize: 16),
                    )),
              ],
            ),
          ),
        ));
  }
}
