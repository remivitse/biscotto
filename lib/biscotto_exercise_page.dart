import 'package:flutter/material.dart';

import 'biscotto.dart';
import 'biscotto_results_page.dart';
import 'exercise.dart';

class BiscottoExercisePage extends StatelessWidget {
  final Exercise exercise;
  final ButtonStyle _badgeStyle = ButtonStyle(
    alignment: Alignment.center,
    backgroundColor: MaterialStateProperty.all(Biscotto.primary),
    padding: MaterialStateProperty.all(const EdgeInsets.all(8)),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    elevation: MaterialStateProperty.all(0),
  );
  final TextStyle _badgeTextStyle =
      const TextStyle(color: Biscotto.primaryLight);

  BiscottoExercisePage({super.key, required this.exercise});

  ElevatedButton _buildFilterBadgeType({required BuildContext context}) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BiscottoResultsPage(
              title: Exercise.format(exercise.type),
              type: exercise.type,
            ),
          ),
        );
      },
      style: _badgeStyle,
      child: Text(
        Exercise.format(exercise.type),
        style: _badgeTextStyle,
      ),
    );
  }

  ElevatedButton _buildFilterBadgeMuscle({required BuildContext context}) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BiscottoResultsPage(
              title: Exercise.format(exercise.muscle),
              muscle: exercise.muscle,
            ),
          ),
        );
      },
      style: _badgeStyle,
      child: Text(
        Exercise.format(exercise.muscle),
        style: _badgeTextStyle,
      ),
    );
  }

  ElevatedButton _buildFilterBadgeEquipment({required BuildContext context}) {
    return ElevatedButton(
      onPressed: () {
        /* Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BiscottoResultsPage(
              title: Exercise.format(exercise.equipment),
              equipment: exercise.equipment,
            ),
          ),
        ); */
      },
      style: _badgeStyle,
      child: Text(
        Exercise.format(exercise.equipment),
        style: _badgeTextStyle,
      ),
    );
  }

  ElevatedButton _buildFilterBadgeDifficulty({required BuildContext context}) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BiscottoResultsPage(
              title: Exercise.format(exercise.difficulty),
              difficulty: exercise.difficulty,
            ),
          ),
        );
      },
      style: _badgeStyle,
      child: Text(
        Exercise.format(exercise.difficulty),
        style: _badgeTextStyle,
      ),
    );
  }

  SingleChildScrollView _buildFilterBadges({required BuildContext context}) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(top: 16, right: 24, left: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildFilterBadgeType(context: context),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: _buildFilterBadgeMuscle(context: context),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: _buildFilterBadgeEquipment(context: context),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: _buildFilterBadgeDifficulty(context: context),
            ),
          ],
        ),
      ),
    );
  }

  Padding _buildExerciseInstructions() {
    return Padding(
      padding: const EdgeInsets.only(top: 16, right: 24, bottom: 16, left: 24),
      child: Text(
        exercise.instructions,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

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
              children: <Widget>[
                _buildFilterBadges(context: context),
                _buildExerciseInstructions(),
              ],
            ),
          ),
        ));
  }
}
