import 'package:flutter/material.dart';

class UnderConstructionPage extends StatelessWidget {
  const UnderConstructionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xff003f62),
        title: const Text("ページ準備中"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.construction, size: 100, color: Colors.orange),
            SizedBox(height: 20),
            Text(
              "🙇‍♂️ ただいま工事中です",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text(
              "ご不便をおかけして申し訳ありません。",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "ホームにお戻りください。",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}