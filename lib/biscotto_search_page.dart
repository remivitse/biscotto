import 'package:flutter/material.dart';

import 'biscotto_results_page.dart';
import 'exercise.dart';

class BiscottoSearchPage extends StatefulWidget {
  const BiscottoSearchPage({super.key, required this.title});

  final String title;

  @override
  State<BiscottoSearchPage> createState() => _BiscottoSearchPageState();
}

class _BiscottoSearchPageState extends State<BiscottoSearchPage> {
  String _selectedType = Exercise.getTypes()[0];
  String _selectedMuscle = Exercise.getMuscles()[0];
  /* String _selectedEquipment = Exercise.getEquipment()[0]; */
  String _selectedDifficulty = Exercise.getDifficulties()[0];

  DropdownMenuItem<String> buildDropdownMenuItem(String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(Exercise.format(value)),
    );
  }

  List<DropdownMenuItem<String>> buildDropdownMenuItems(List<String> filter) {
    List<DropdownMenuItem<String>> items = [];
    for (String option in filter) {
      items.add(buildDropdownMenuItem(option));
    }
    return items;
  }

  // DropdownButton<String> buildDropdownButton(
  //     String value, List<String> filter) {
  //   return DropdownButton<String>(
  //     isExpanded: true,
  //     value: value,
  //     items: buildDropdownMenuItems(filter),
  //     onChanged: (item) => setState(() {
  //       value = item!;
  //     }),
  //   );
  // }

  DropdownButton<String> buildDropdownButtonType() {
    return DropdownButton<String>(
      isExpanded: true,
      value: _selectedType,
      items: buildDropdownMenuItems(Exercise.getTypes()),
      onChanged: (item) => setState(() {
        _selectedType = item!;
      }),
    );
  }

  DropdownButton<String> buildDropdownButtonMuscle() {
    return DropdownButton<String>(
      isExpanded: true,
      value: _selectedMuscle,
      items: buildDropdownMenuItems(Exercise.getMuscles()),
      onChanged: (item) => setState(() {
        _selectedMuscle = item!;
      }),
    );
  }

  /* DropdownButton<String> buildDropdownButtonEquipment() {
    return DropdownButton<String>(
      isExpanded: true,
      value: _selectedEquipment,
      items: buildDropdownMenuItems(Exercise.getEquipment()),
      onChanged: (item) => setState(() {
        _selectedEquipment = item!;
      }),
    );
  } */

  DropdownButton<String> buildDropdownButtonDifficulty() {
    return DropdownButton<String>(
      isExpanded: true,
      value: _selectedDifficulty,
      items: buildDropdownMenuItems(Exercise.getDifficulties()),
      onChanged: (item) => setState(() {
        _selectedDifficulty = item!;
      }),
    );
  }

  List<DropdownButton<String>> buildDropdownButtons() {
    List<DropdownButton<String>> buttons = [];
    buttons.add(buildDropdownButtonType());
    buttons.add(buildDropdownButtonMuscle());
    /* buttons.add(buildDropdownButtonEquipment()); */
    buttons.add(buildDropdownButtonDifficulty());
    return buttons;
  }

  ElevatedButton buildSearchButton({String text = 'Search'}) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BiscottoResultsPage(
                      type: _selectedType == Exercise.getTypes()[0]
                          ? null
                          : _selectedType,
                      muscle: _selectedMuscle == Exercise.getMuscles()[0]
                          ? null
                          : _selectedMuscle,
                      /*equipment: _selectedEquipment ==
                                          Exercise.getEquipment()[0]
                                      ? null
                                      : _selectedEquipment, */
                      difficulty:
                          _selectedDifficulty == Exercise.getDifficulties()[0]
                              ? null
                              : _selectedDifficulty,
                    )));
      },
      child: Text(text),
    );
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
              ...buildDropdownButtons(),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: buildSearchButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
