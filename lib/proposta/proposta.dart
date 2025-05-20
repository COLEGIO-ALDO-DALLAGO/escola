import 'package:flutter/material.dart';

class PropostasPage extends StatefulWidget {
  const PropostasPage({super.key});

  @override
  State<PropostasPage> createState() => _PropostasPageState();
}

class _PropostasPageState extends State<PropostasPage> {
  final TextEditingController _searchController = TextEditingController();
  List<String> propostasFiltradas = [];

  final List<String> propostas = [
    "Organização do Interclasse",
    "Dia do Estudante Verde",
    "Semana Cultural",
    "Organização dos Clubes",
    "Reforma da Quadra",
    "Treino de volêi, Tênis de mesa e Futsal",
    "Teatro e show de talentos",
    "Rádio",
    "Clubes Novos",
    "+ Materiais (bolas e redes)",
    "Semana Verde",
    "Turma Verde",
    "Melhora de Produtos (loja Cead)",
    "Gincanas",
    "Horta",
    "Campanhas de Contribuição",
    "Melhora da Caixa de Enfermagem",
    "CineClube",
    "PodCast e Cinema",
    "Melhora das Festas e Festas Abertas",
    "Votação Popular",
    "Projeto Aluno Empreende",
    "Comunicação Social",
    "Painel \"orgulho da escola\" com conquistas dos estudantes e troféus",
    "Mini feira de empreendedorismo jovem",
    "Cantinho da calma",
    "Painel \"Você Sabia?\"",
    "Redes Sociais",
    "Renovação da Biblioteca",
    "Mural dos sonhos da escola toda",
    "Semana de saúde mental e autocuidado",
    "Kit's de Higiene"
  ];

  @override
  void initState() {
    super.initState();
    propostasFiltradas = List.from(propostas);
    _searchController.addListener(_filtrarPropostas);
  }

  void _filtrarPropostas() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      propostasFiltradas = propostas
          .where((p) => p.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      appBar: AppBar(
        title: const Text(
          '📌 Propostas da Chapa ELO',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red[700],
        elevation: 6,
      ),
      body: Column(
        children: [
          // Header com imagem e gradiente
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            child: Stack(
              children: [
                Image.asset(
                  'assets-chapa/foto/chapa.jpg',
                  width: double.infinity,
                  height: 190,
                  fit: BoxFit.cover,
                ),
                Container(
                  width: double.infinity,
                  height: 190,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        // ignore: deprecated_member_use
                        Colors.black.withOpacity(0.5),
                        Colors.transparent
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                const Positioned(
                  bottom: 16,
                  left: 20,
                  child: Text(
                    "Conheça nossas propostas!",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: Colors.black54,
                          offset: Offset(1, 2),
                          blurRadius: 4,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Campo de busca
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: '🔍 Buscar proposta...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // Lista de Propostas
          Expanded(
            child: ListView.builder(
              itemCount: propostasFiltradas.length,
              padding: const EdgeInsets.only(bottom: 80),
              itemBuilder: (context, index) {
                final proposta = propostasFiltradas[index];
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(18),
                    child: ListTile(
                      leading: Icon(
                        Icons.check_circle_rounded,
                        color: Colors.red.shade600,
                        size: 28,
                      ),
                      title: Text(
                        proposta,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      tileColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text('Detalhes da Proposta'),
                            content: Text(proposta),
                            actions: [
                              TextButton(
                                child: const Text('Fechar'),
                                onPressed: () => Navigator.of(context).pop(),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),

          // Rodapé
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.red[50],
              border: const Border(
                top: BorderSide(color: Colors.redAccent, width: 1),
              ),
            ),
            child: const Column(
              children: [
                Text(
                  'Desenvolvido por Lukas Carvalho',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 4),
                Text(
                  'Contato: lucascarvalhojapira@icloud.com',
                  style: TextStyle(fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
