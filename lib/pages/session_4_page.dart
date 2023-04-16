import 'package:flutter/material.dart';

class Session4Page extends StatefulWidget {
  const Session4Page({super.key});

  @override
  State<Session4Page> createState() => _Session4PageState();
}

class _Session4PageState extends State<Session4Page> {
  // Define a person list with emojis in dart
  final List<People> people = [const People(name: 'John', emoji: '👨'), const People(name: 'Jane', emoji: '👩'), const People(name: 'Jack', emoji: '👦')];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Session 4'),
      ),
      body: ListView(
        children: people.map((people) => _peopleItem(people: people)).toList(),
      ),
    );
  }

  Widget _peopleItem({required People people}) {
    return ListTile(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (settings) => PeopleDetailPage(people: people)));
      },
      leading: Hero(tag: people.emoji, child: Text(people.emoji, style: const TextStyle(fontSize: 30))),
      title: Text(people.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      trailing: const Icon(Icons.arrow_forward_ios),
    );
  }
}

class PeopleDetailPage extends StatelessWidget {
  final People people;
  const PeopleDetailPage({super.key, required this.people});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(people.name),
      ),
      body: Center(
        child: Hero(
            tag: people.emoji,
            flightShuttleBuilder: (flightContext, animation, flightDirection, fromHeroContext, toHeroContext) {
              switch (flightDirection) {
                case HeroFlightDirection.push:
                  return Material(
                    color: Colors.transparent,
                    child: ScaleTransition(scale: animation.drive(Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: Curves.bounceInOut))), child: toHeroContext.widget),
                  );
                case HeroFlightDirection.pop:
                  return Material(
                    color: Colors.transparent,
                    child: ScaleTransition(scale: animation, child: fromHeroContext.widget),
                  );
              }
            },
            child: Text(people.emoji, style: const TextStyle(fontSize: 200))),
      ),
    );
  }
}

class People {
  final String name;
  final String emoji;

  const People({required this.name, required this.emoji});
}
