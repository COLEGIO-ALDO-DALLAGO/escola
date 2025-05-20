import 'package:flutter/material.dart';
import 'proposta/proposta.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chapa Escolar ELO',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF9F9F9),
        fontFamily: 'Roboto',
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.red.shade700,
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
      ),
      home: const MyHomePage(title: 'Chapa Escolar ELO'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  void _mostrarIndisponivel(BuildContext context, String titulo) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('$titulo indisponível', style: const TextStyle(fontWeight: FontWeight.bold)),
        content: const Text('Esta seção ainda está em desenvolvimento. Volte em breve!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 6,
        title: Text(title),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.menu),
            onSelected: (value) {
              if (value == 'propostas') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PropostasPage()),
                );
              } else {
                _mostrarIndisponivel(
                  context,
                  value == 'eventos' ? 'Eventos Mensais' : 'Calendário',
                );
              }
            },
            itemBuilder: (BuildContext context) => const [
              PopupMenuItem(value: 'propostas', child: Text('Propostas')),
              PopupMenuItem(value: 'eventos', child: Text('Eventos Mensais')),
              PopupMenuItem(value: 'calendario', child: Text('Calendário')),
            ],
          ),
        ],
      ),
      body: Scrollbar(
        radius: const Radius.circular(8),
        thickness: 6,
        interactive: true,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedBanner(),
              const SizedBox(height: 40),
              const SectionTitle(title: '🎯 Eventos em Destaque'),
              const SizedBox(height: 20),
              Wrap(
                runSpacing: 16,
                spacing: 16,
                children: const [
                  EventCard(
                    title: 'Feira Cultural',
                    description: 'Arte, música e apresentações dos nossos talentos! 🎭🎨',
                  ),
                  EventCard(
                    title: 'Gincana Esportiva',
                    description: 'Competições saudáveis e premiações incríveis! 🏅',
                  ),
                  EventCard(
                    title: 'Semana do Meio Ambiente',
                    description: 'Sustentabilidade, oficinas e conscientização. 🌱',
                  ),
                ],
              ),
              const SizedBox(height: 50),
              const SectionTitle(title: '🏫 Nosso Colégio'),
              const SizedBox(height: 12),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/logo_cead.jpg',
                    width: 300,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              const Footer(),
            ],
          ),
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }
}

class AnimatedBanner extends StatelessWidget {
  const AnimatedBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.red.shade300, Colors.red.shade700],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.red.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              'assets-chapa/foto/chapa.jpg',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 24),
          const Expanded(
            child: Text(
              '❤️ Bem-vindo à Chapa ELO!\nConfira abaixo nossos eventos em destaque! 🎉',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: const [
          Divider(thickness: 1),
          SizedBox(height: 8),
          Text(
            'Desenvolvido por Lukas Carvalho',
            style: TextStyle(fontSize: 14, color: Colors.black54),
          ),
          SizedBox(height: 4),
          Text(
            'lucascarvalhojapira@icloud.com',
            style: TextStyle(fontSize: 13, color: Colors.black38),
          ),
          SizedBox(height: 12),
        ],
      ),
    );
  }
}

class EventCard extends StatefulWidget {
  final String title;
  final String description;

  const EventCard({super.key, required this.title, required this.description});

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
    _scale = Tween(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(_) => _controller.forward();
  void _onTapUp(_) => _controller.reverse();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scale,
        child: SizedBox(
          width: 300,
          child: Card(
            elevation: 6,
            // ignore: deprecated_member_use
            shadowColor: Colors.red.withOpacity(0.4),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.description,
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
