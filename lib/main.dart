import 'package:flutter/material.dart';

void main() => runApp(const DartApp());

class DartApp extends StatelessWidget {
  const DartApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'DartApp',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF0B0D10),
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFFFFB300),
        brightness: Brightness.dark,
      ),
      useMaterial3: true,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF171A1F),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    ),
    home: const LoginPage(),
  );
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 460),
            child: Column(
              children: [
                const Text('🎯', style: TextStyle(fontSize: 64)),
                const SizedBox(height: 8),
                const Text('DARTAPP', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, letterSpacing: 4)),
                const SizedBox(height: 8),
                Text('Play. Score. Improve.', style: TextStyle(color: Colors.grey.shade400)),
                const SizedBox(height: 40),
                const TextField(decoration: InputDecoration(labelText: 'E-mail', prefixIcon: Icon(Icons.email_outlined))),
                const SizedBox(height: 14),
                const TextField(obscureText: true, decoration: InputDecoration(labelText: 'Wachtwoord', prefixIcon: Icon(Icons.lock_outline))),
                const SizedBox(height: 20),
                SizedBox(width: double.infinity, height: 52, child: FilledButton(onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const DashboardPage())), child: const Text('INLOGGEN'))),
                const SizedBox(height: 12),
                SizedBox(width: double.infinity, height: 52, child: OutlinedButton.icon(onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const DashboardPage())), icon: const Icon(Icons.g_mobiledata), label: const Text('DOORGAAN MET GOOGLE'))),
                TextButton(onPressed: () {}, child: const Text('Wachtwoord vergeten?')),
                TextButton(onPressed: () {}, child: const Text('Account aanmaken')),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});
  static const games = [
    ('501', Icons.looks_one, 501), ('301', Icons.looks_two, 301),
    ('701', Icons.looks_3, 701), ('Cricket', Icons.sports_score, 0),
    ("Bob's 27", Icons.track_changes, 0), ('Half-It', Icons.call_split, 0),
  ];
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('DARTAPP 🎯'), actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.settings_outlined))]),
    body: ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const Text('Nieuwe wedstrijd', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
        const SizedBox(height: 6),
        Text('Kies een spel en start direct.', style: TextStyle(color: Colors.grey.shade400)),
        const SizedBox(height: 18),
        ...games.map((g) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Card(
            color: const Color(0xFF15181D),
            child: ListTile(
              leading: CircleAvatar(child: Icon(g.$2)),
              title: Text(g.$1, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SetupPage(gameName: g.$1, startingScore: g.$3))),
            ),
          ),
        )),
        const SizedBox(height: 12),
        const Text('Jouw profiel', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
        const SizedBox(height: 10),
        const Row(children: [
          Expanded(child: StatCard(title: 'Matches', value: '0')),
          SizedBox(width: 10),
          Expanded(child: StatCard(title: '3-dart avg', value: '—')),
          SizedBox(width: 10),
          Expanded(child: StatCard(title: 'High checkout', value: '—')),
        ]),
      ],
    ),
  );
}

class StatCard extends StatelessWidget {
  final String title, value;
  const StatCard({super.key, required this.title, required this.value});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(color: const Color(0xFF15181D), borderRadius: BorderRadius.circular(14)),
    child: Column(children: [
      Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
      const SizedBox(height: 4),
      Text(title, style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
    ]),
  );
}

class SetupPage extends StatefulWidget {
  final String gameName;
  final int startingScore;
  const SetupPage({super.key, required this.gameName, required this.startingScore});
  @override
  State<SetupPage> createState() => _SetupPageState();
}

class _SetupPageState extends State<SetupPage> {
  int players = 2;
  final names = List.generate(8, (i) => TextEditingController(text: 'Speler ' + (i + 1).toString()));

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(widget.gameName)),
    body: ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text('Wedstrijd instellen', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
        const SizedBox(height: 24),
        const Text('Aantal spelers', style: TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 10),
        SegmentedButton<int>(
          segments: List.generate(8, (i) => ButtonSegment(value: i + 1, label: Text((i + 1).toString()))),
          selected: {players},
          onSelectionChanged: (v) => setState(() => players = v.first),
        ),
        const SizedBox(height: 24),
        ...List.generate(players, (i) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: TextField(controller: names[i], decoration: InputDecoration(labelText: 'Speler ' + (i + 1).toString(), prefixIcon: const Icon(Icons.person_outline))),
        )),
        const SizedBox(height: 16),
        FilledButton.icon(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => GamePage(
            gameName: widget.gameName,
            startingScore: widget.startingScore,
            playerNames: List.generate(players, (i) => names[i].text),
          ))),
          icon: const Icon(Icons.play_arrow),
          label: const Text('START WEDSTRIJD'),
        ),
      ],
    ),
  );
}

class GamePage extends StatefulWidget {
  final GameInfo game;
  final List<String> players;
  const GamePage({super.key, required this.game, required this.players});
  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late List<int> scores;
  late List<int> darts;
  late List<int> turns;
  late List<int> halfRounds;
  late List<List<int>> cricketMarks;
  late List<int> cricketScore;
  int current = 0;
  int turnTotal = 0;
  final turnDarts = <int>[];
  final history = <List<int>>[];

  static const cricketTargets = [20, 19, 18, 17, 16, 15, 25];

  bool get isX01 => widget.game.start > 0;
  bool get isCricket => widget.game.name == 'Cricket';
  bool get isHalfIt => widget.game.name == 'Half-It';
  bool get isBobs => widget.game.name == "Bob's 27";

  @override
  void initState() {
    super.initState();
    scores = List.filled(widget.players.length, widget.game.start);
    darts = List.filled(widget.players.length, 0);
    turns = List.filled(widget.players.length, 0);
    halfRounds = List.filled(widget.players.length, 0);
    cricketMarks = List.generate(widget.players.length, (_) => List.filled(7, 0));
    cricketScore = List.filled(widget.players.length, 0);
  }

  void addDart(int value) {
    if (turnDarts.length >= 3) return;
    setState(() {
      turnDarts.add(value);
      turnTotal += value;
    });
  }

  void undoDart() {
    if (turnDarts.isEmpty) return;
    setState(() => turnTotal -= turnDarts.removeLast());
  }

  void finishTurn() {
    if (turnDarts.isEmpty) return;
    if (isX01) return _finishX01();
    if (isHalfIt) return _finishHalfIt();
    if (isBobs) return _finishBobs();
  }

  void _finishX01() {
    final remaining = scores[current] - turnTotal;
    final bust = remaining < 0 || remaining == 1;
    history.add(List.of(scores));
    setState(() {
      darts[current] += turnDarts.length;
      turns[current]++;
      if (!bust) scores[current] = remaining;
    });
    if (remaining == 0) {
      _winner();
      return;
    }
    if (bust) _snack('Bust! Geen score.');
    _next();
  }

  void _finishHalfIt() {
    const targets = [20, 19, 18, 17, 16, 15, 25, 50];
    final round = halfRounds[current];
    final target = targets[round.clamp(0, targets.length - 1)];
    final hit = turnDarts.contains(target);
    setState(() {
      darts[current] += turnDarts.length;
      turns[current]++;
      halfRounds[current]++;
      if (hit) {
        scores[current] += turnTotal;
      } else {
        scores[current] = scores[current] ~/ 2;
      }
    });
    if (halfRounds[current] >= targets.length) {
      _winnerByHighestScore();
      return;
    }
    _next();
  }

  void _finishBobs() {
    const targets = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 25];
    final target = targets[turns[current].clamp(0, targets.length - 1)];
    final hit = turnDarts.contains(target);
    setState(() {
      darts[current] += turnDarts.length;
      turns[current]++;
      if (hit) {
        scores[current] += turnTotal;
      } else {
        scores[current] -= 27;
      }
    });
    if (turns[current] >= targets.length) {
      _winnerByHighestScore();
      return;
    }
    _next();
  }

  void cricketMark(int target, int amount) {
    final idx = cricketTargets.indexOf(target);
    if (idx < 0) return;
    setState(() {
      final before = cricketMarks[current][idx];
      final after = (before + amount).clamp(0, 3);
      cricketMarks[current][idx] = after;
      if (before < 3 && after == 3) cricketScore[current] += target;
    });
  }

  void finishCricket() {
    if (cricketScore[current] >= 0) {
      _next();
    }
  }

  void _next() {
    turnDarts.clear();
    turnTotal = 0;
    setState(() => current = (current + 1) % widget.players.length);
  }

  void _winner() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text('🎯 GAME SHOT!'),
        content: Text(widget.players[current] + ' wint ' + widget.game.name + '!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.popUntil(context, (r) => r.isFirst),
            child: const Text('NAAR DASHBOARD'),
          ),
        ],
      ),
    );
  }

  void _winnerByHighestScore() {
    final best = scores.reduce((a, b) => a > b ? a : b);
    final winner = scores.indexOf(best);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text('🏆 WEDSTRIJD KLAAR'),
        content: Text(widget.players[winner] + ' wint met ' + best.toString() + ' punten!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.popUntil(context, (r) => r.isFirst),
            child: const Text('NAAR DASHBOARD'),
          ),
        ],
      ),
    );
  }

  void _snack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  List<String> checkout(int score) {
    const routes = <int, String>{
      170: 'T20 T20 Bull', 167: 'T20 T19 Bull', 164: 'T20 T18 Bull',
      161: 'T20 T17 Bull', 160: 'T20 T20 D20', 158: 'T20 T20 D19',
      157: 'T20 T19 D20', 156: 'T20 T20 D18', 155: 'T20 T19 D19',
      154: 'T20 T18 D20', 153: 'T20 T19 D18', 152: 'T20 T20 D16',
      151: 'T20 T17 D20', 150: 'T20 T18 D18', 147: 'T20 T17 D18',
      140: 'T20 T20 D10', 132: 'Bull T14 D20', 130: 'T20 T18 D8',
      120: 'T20 20 D20', 110: 'T20 18 D16', 100: 'T20 D20',
    };
    if (routes.containsKey(score)) return [routes[score]!];
    if (score >= 2 && score <= 40 && score.isEven) return ['D' + (score ~/ 2).toString()];
    return [];
  }

  @override
  Widget build(BuildContext context) {
    if (isCricket) return _cricketView();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.game.name),
        actions: [
          IconButton(
            onPressed: history.isEmpty ? null : () => setState(() {
              scores = history.removeLast();
              turnDarts.clear();
              turnTotal = 0;
            }),
            icon: const Icon(Icons.undo),
          ),
        ],
      ),
      body: Column(children: [
        Expanded(child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            ...List.generate(widget.players.length, (i) => Card(
              color: i == current ? const Color(0xFF28220F) : const Color(0xFF15181D),
              child: ListTile(
                leading: CircleAvatar(child: Text((i + 1).toString())),
                title: Text(widget.players[i], style: const TextStyle(fontWeight: FontWeight.w800)),
                subtitle: Text(i == current ? 'Aan de beurt • ' + darts[i].toString() + ' darts' : turns[i].toString() + ' beurten'),
                trailing: Text(scores[i].toString(), style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w900)),
              ),
            )),
            if (isX01 && checkout(scores[current]).isNotEmpty)
              Card(child: ListTile(
                leading: const Icon(Icons.auto_awesome),
                title: const Text('Checkout'),
                subtitle: Text(checkout(scores[current]).join(' / ')),
              )),
            if (isHalfIt)
              Card(child: ListTile(
                leading: const Icon(Icons.flag),
                title: Text('Ronde ' + (halfRounds[current] + 1).toString()),
                subtitle: Text('Target: ' + [20, 19, 18, 17, 16, 15, 25, 50][halfRounds[current].clamp(0, 7)].toString()),
              )),
            if (isBobs)
              Card(child: ListTile(
                leading: const Icon(Icons.track_changes),
                title: Text('Ronde ' + (turns[current] + 1).toString()),
                subtitle: const Text('Raak je target of verlies 27 punten.'),
              )),
          ],
        )),
        _keypad(),
      ]),
    );
  }

  Widget _keypad() => Container(
    padding: const EdgeInsets.fromLTRB(10, 10, 10, 16),
    decoration: const BoxDecoration(color: Color(0xFF111419), borderRadius: BorderRadius.vertical(top: Radius.circular(22))),
    child: SafeArea(top: false, child: Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(widget.players[current], style: const TextStyle(fontWeight: FontWeight.w800)),
        Text('Beurt: ' + turnTotal.toString() + ' • ' + turnDarts.length.toString() + '/3', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
      ]),
      const SizedBox(height: 8),
      Wrap(spacing: 6, runSpacing: 6, children: [
        for (final n in [0, 1, 5, 10, 15, 20, 25, 30, 40, 50, 60])
          SizedBox(width: 62, child: FilledButton(
            onPressed: n == 0 ? null : () => addDart(n),
            child: Text(n.toString()),
          )),
      ]),
      const SizedBox(height: 7),
      Row(children: [
        Expanded(child: OutlinedButton(onPressed: turnDarts.isEmpty ? null : undoDart, child: const Text('LAATSTE DART WIS'))),
        const SizedBox(width: 8),
        Expanded(child: FilledButton(onPressed: turnDarts.isEmpty ? null : finishTurn, child: const Text('BEURT OPSLAAN'))),
      ]),
    ])),
  );

  Widget _cricketView() => Scaffold(
    appBar: AppBar(title: const Text('Cricket'), actions: [
      IconButton(onPressed: () {}, icon: const Icon(Icons.volume_up_outlined)),
    ]),
    body: Column(children: [
      Expanded(child: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          ...List.generate(widget.players.length, (p) => Card(
            color: p == current ? const Color(0xFF28220F) : const Color(0xFF15181D),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text(widget.players[p], style: const TextStyle(fontWeight: FontWeight.w800)),
                  Text(cricketScore[p].toString(), style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w900)),
                ]),
                const SizedBox(height: 10),
                Row(children: List.generate(7, (i) => Expanded(child: Center(
                  child: Text(
                    cricketTargets[i].toString() + '\n' + '×' * cricketMarks[p][i],
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                )))),
              ]),
            ),
          )),
        ],
      )),
      Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 16),
        color: const Color(0xFF111419),
        child: SafeArea(top: false, child: Column(children: [
          Wrap(spacing: 6, runSpacing: 6, children: cricketTargets.map((n) => SizedBox(width: 66, child: FilledButton(onPressed: () => cricketMark(n, 1), child: Text(n.toString())))).toList()),
          const SizedBox(height: 8),
          SizedBox(width: double.infinity, child: FilledButton(onPressed: finishCricket, child: const Text('BEURT OPSLAAN'))),
        ])),
      ),
    ]),
  );
}
