import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'biscotto_exercise_page.dart';
import 'exercise.dart';

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

  String appendParamsToQuery(
      {required String query,
      required Map<String, String> params,
      bool prems = true}) {
    if (params.isEmpty) {
      return query;
    }
    String separator = prems ? '?' : '&';
    query = '$query$separator${params.keys.first}=${params.values.first}';
    params.remove(params.keys.first);
    return appendParamsToQuery(
      query: query,
      params: params,
      prems: false,
    );
  }

  Map<String, String> _buildParams({
    String? type,
    String? muscle,
    /* String? equipment, */
    String? difficulty,
  }) {
    Map<String, String> params = {};
    if (type != null) params['type'] = type;
    if (muscle != null) params['muscle'] = muscle;
    /* if (equipment != null) params['equipment'] = equipment; */
    if (difficulty != null) params['difficulty'] = difficulty;
    return params;
  }

  Future<List<Exercise>> _fetchExercises({
    String? type,
    String? muscle,
    /* String? equipment, */
    String? difficulty,
  }) async {
    String query = appendParamsToQuery(
        query: 'https://api.api-ninjas.com/v1/exercises',
        params: _buildParams(
          difficulty: difficulty,
          muscle: muscle,
          /* equipment: equipment, */
          type: type,
        ));
    final response = await http.get(Uri.parse(query),
        headers: {'X-Api-Key': dotenv.env['API_NINJAS_KEY']!});
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
                        ),
                      ),
                    ),
                    title: Text(snapshot.data![index].name),
                    subtitle: Row(
                      children: [
                        Text(Exercise.format(snapshot.data![index].type)),
                        const Text(' - '),
                        Text(Exercise.format(snapshot.data![index].muscle)),
                        const Text(' - '),
                        Text(Exercise.format(snapshot.data![index].equipment)),
                        const Text(' - '),
                        Text(Exercise.format(snapshot.data![index].difficulty)),
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
