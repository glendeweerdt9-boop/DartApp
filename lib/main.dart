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
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => X01GamePage(
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

class X01GamePage extends StatefulWidget {
  final String gameName;
  final int startingScore;
  final List<String> playerNames;
  const X01GamePage({super.key, required this.gameName, required this.startingScore, required this.playerNames});
  @override
  State<X01GamePage> createState() => _X01GamePageState();
}

class _X01GamePageState extends State<X01GamePage> {
  late List<int> scores;
  int current = 0;
  int turnScore = 0;
  final history = <List<int>>[];

  @override
  void initState() {
    super.initState();
    scores = List.filled(widget.playerNames.length, widget.startingScore);
  }

  void addScore(int value) {
    if (widget.startingScore == 0) return;
    setState(() => turnScore += value);
  }

  void undoTurn() => setState(() => turnScore = 0);

  void submitTurn() {
    if (widget.startingScore == 0) {
      setState(() => current = (current + 1) % scores.length);
      return;
    }
    final remaining = scores[current] - turnScore;
    final bust = remaining < 0 || remaining == 1;
    setState(() {
      history.add(List.of(scores));
      if (!bust) scores[current] = remaining;
      if (remaining == 0) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => AlertDialog(
            title: const Text('🎯 Game shot!'),
            content: Text(widget.playerNames[current] + ' wint ' + widget.gameName + '!'),
            actions: [TextButton(onPressed: () => Navigator.popUntil(context, (r) => r.isFirst), child: const Text('NAAR DASHBOARD'))],
          ),
        );
        return;
      }
      turnScore = 0;
      current = (current + 1) % scores.length;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(widget.gameName),
      actions: [IconButton(onPressed: history.isEmpty ? null : () => setState(() { scores = history.removeLast(); turnScore = 0; }), icon: const Icon(Icons.undo))],
    ),
    body: Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: scores.length,
            itemBuilder: (_, i) => Card(
              color: i == current ? const Color(0xFF27220F) : const Color(0xFF15181D),
              child: ListTile(
                leading: CircleAvatar(child: Text((i + 1).toString())),
                title: Text(widget.playerNames[i], style: const TextStyle(fontWeight: FontWeight.w700)),
                subtitle: Text(i == current ? 'Aan de beurt' : 'Wacht'),
                trailing: Text(scores[i].toString(), style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w900)),
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 18),
          decoration: const BoxDecoration(color: Color(0xFF111419), borderRadius: BorderRadius.vertical(top: Radius.circular(22))),
          child: SafeArea(
            top: false,
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(widget.playerNames[current], style: const TextStyle(fontWeight: FontWeight.w700)),
                Text('Turn: ' + turnScore.toString(), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
              ]),
              const SizedBox(height: 10),
              Wrap(spacing: 8, runSpacing: 8, children: [
                for (final n in [1, 5, 10, 20, 25, 50])
                  SizedBox(width: 72, child: FilledButton(onPressed: widget.startingScore == 0 ? null : () => addScore(n), child: Text(n.toString()))),
              ]),
              const SizedBox(height: 8),
              Row(children: [
                Expanded(child: OutlinedButton(onPressed: turnScore == 0 ? null : undoTurn, child: const Text('WIS'))),
                const SizedBox(width: 10),
                Expanded(flex: 2, child: FilledButton(onPressed: submitTurn, child: const Text('BEURT OPSLAAN'))),
              ]),
              if (widget.startingScore == 0)
                Padding(padding: const EdgeInsets.only(top: 8), child: Text('Eigen scorebord voor dit spel komt in de volgende versie.', style: TextStyle(color: Colors.grey.shade500, fontSize: 12))),
            ]),
          ),
        ),
      ],
    ),
  );
}
