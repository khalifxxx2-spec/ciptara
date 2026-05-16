import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import '../widgets/gradient_app_bar.dart';

class AIAssistantPage extends StatefulWidget {
  const AIAssistantPage({super.key});

  @override
  State<AIAssistantPage> createState() => _AIAssistantPageState();
}

class _AIAssistantPageState extends State<AIAssistantPage> {
  final TextEditingController _messageController = TextEditingController();
  final List<AIMessage> _messages = [
    AIMessage(
      text: "Halo! Saya CiptaAI. Ide inovasi apa yang ingin kamu kembangkan hari ini? 🚀",
      isUser: false,
      time: DateTime.now(),
    ),
  ];
  bool _isTyping = false;

  void _sendMessage() {
    if (_messageController.text.isEmpty) return;

    final userMsg = _messageController.text;
    setState(() {
      _messages.add(AIMessage(text: userMsg, isUser: true, time: DateTime.now()));
      _messageController.clear();
      _isTyping = true;
    });

    // Simulasi Jawaban AI
    Future.delayed(const Duration(seconds: 2), () {
      String response = "";
      if (userMsg.toLowerCase().contains("sampah plastik")) {
        response = "Ide yang luar biasa! Masalah sampah plastik sangat mendesak. Berikut beberapa pengembangan yang bisa kamu coba:\n\n1. **Aplikasi PlastikPoin**: Pengguna menukar sampah plastik dengan saldo e-wallet.\n2. **Paving Block Plastik**: Mesin kecil pengolah plastik menjadi bahan bangunan.\n3. **Saran**: Coba fokus pada pengumpulan di tingkat RT agar lebih berdampak.\n\nApakah kamu ingin saya bantu buatkan roadmap projectnya?";
      } else if (userMsg.toLowerCase().contains("energi")) {
        response = "Energi terbarukan adalah masa depan! Kamu bisa mengeksplorasi panel surya portable atau generator micro-hydro untuk desa terpencil. Ingin rekomendasi teknologi yang cocok?";
      } else {
        response = "Ide yang sangat potensial! Saya melihat peluang besar untuk inovasi ini di pasar Indonesia. Saya sarankan untuk fokus pada skalabilitas dan biaya produksi. Ingin saya bantu buatkan judul yang lebih menjual?";
      }

      setState(() {
        _messages.add(AIMessage(text: response, isUser: false, time: DateTime.now()));
        _isTyping = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      appBar: const GradientAppBar(title: 'AI Idea Assistant'),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return _buildMessageBubble(msg);
              },
            ),
          ),
          if (_isTyping)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  const Icon(Icons.auto_awesome, color: AppColors.cyan, size: 16),
                  const SizedBox(width: 8),
                  Text('CiptaAI sedang berpikir...', style: AppTextStyles.caption(color: AppColors.cyan)),
                ],
              ),
            ),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(AIMessage msg) {
    return Align(
      alignment: msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: msg.isUser ? AppColors.purple.withValues(alpha: 0.2) : AppColors.cardDark,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: Radius.circular(msg.isUser ? 20 : 0),
            bottomRight: Radius.circular(msg.isUser ? 0 : 20),
          ),
          border: Border.all(
            color: msg.isUser ? AppColors.purple.withValues(alpha: 0.4) : AppColors.surfaceLight,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              msg.text,
              style: AppTextStyles.body(color: Colors.white, height: 1.5),
            ),
            const SizedBox(height: 8),
            Text(
              "${msg.time.hour}:${msg.time.minute.toString().padLeft(2, '0')}",
              style: AppTextStyles.caption(fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
      decoration: BoxDecoration(
        color: AppColors.navyBlue,
        border: Border(top: BorderSide(color: AppColors.surfaceLight, width: 1)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Ketik masalah atau ide...',
                hintStyle: AppTextStyles.body(color: AppColors.textMuted),
                filled: true,
                fillColor: AppColors.cardDark,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: _sendMessage,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
