import 'package:flutter/material.dart';

class Step {
  Step(
      this.title,
      this.body,
      [this.subSteps = const <Step>[]]
      );
  String title;
  String body;
  List<Step> subSteps;
}

List<Step> getSteps() {
  return [
    Step('Step 0: Install Flutter', 'Install Flutter development tools according to the official documentation.'),
    Step('Step 1: Create a project', 'Open your terminal, run `flutter create <project_name>` to create a new project.'),
    Step('Step 2: Run the app', 'Change your terminal directory to the project directory, enter `flutter run`.'),
    Step('Step 3: Build your app', 'Select a tutorial:', [
      Step('Developing a to-do app', 'Add a link to the tutorial video'),
      Step('Developing a 2-D game', 'Add a link to the tutorial video'),
    ]),
  ];
}

class Steps extends StatefulWidget {
  const Steps({Key? key}) : super(key: key);
  @override
  State<Steps> createState() => _StepsState();
}

class _StepsState extends State<Steps> {
  final List<Step> _steps = getSteps();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          child: _renderSteps(_steps)
      ),
    );
  }

  Widget _renderSteps(List<Step> steps) {
    return Scaffold(
      body: ExpansionPanelList.radio(
        children: steps.map<ExpansionPanelRadio>((Step step) {
          return ExpansionPanelRadio(
              headerBuilder: (BuildContext context, bool isExpanded) {
                return ListTile(
                  title: Text(step.title),
                );
              },
              body: ListTile(
                  title: Text(step.body),
                  subtitle: _renderSteps(step.subSteps)
              ),
              value: step.title
          );
        }).toList(),
      ),
    );
  }
}