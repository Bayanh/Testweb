import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:async';

void main() {
  runApp(const SecurityPassApp());
}

class SecurityPassApp extends StatelessWidget {
  const SecurityPassApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Security Pass',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF1B232D),
        primarySwatch: Colors.blue,
      ),
      home: const SecurityPassPage(),
    );
  }
}

class SecurityPassPage extends StatefulWidget {
  const SecurityPassPage({Key? key}) : super(key: key);

  @override
  State<SecurityPassPage> createState() => _SecurityPassPageState();
}

class _SecurityPassPageState extends State<SecurityPassPage> {
  String _formattedDuration = '00:00';
  Timer? _timer;
  final Stopwatch _stopwatch = Stopwatch();
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _stopwatch.start();
    _timer = Timer.periodic(const Duration(seconds: 1), _updateDuration);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _updateDuration(Timer timer) {
    final duration = _stopwatch.elapsed;
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    setState(() {
      // Hiển thị phút:giây đồng bộ với thời gian chạy ứng dụng
      _formattedDuration = '$minutes:$seconds'; 
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'V23060542 (Bùi Minh Hoàng)',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 12.0),
                        decoration: const BoxDecoration(
                          color: Color(0xFFFDCB58),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            topRight: Radius.circular(15.0),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            '將二維碼對准掃描器刷碼出場',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Center(
                        child: QrImageView(
                          data: 'V23060542-Security-Pass',
                          version: QrVersions.auto,
                          size: 200.0,
                          foregroundColor: const Color(0xFF1B232D),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 15.0),
                        child: Text(
                          '刷新二維碼',
                          style: TextStyle(
                            color: Color(0xFF6C757D),
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.0),
                        child: Text(
                          '已生效',
                          style: TextStyle(
                            color: Color(0xFF38B000),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Text(
                          _formattedDuration,
                          style: const TextStyle(
                            color: Color(0xFF7A9BB8), // Màu xanh xám giống trong ảnh
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Monospace',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  padding: const EdgeInsets.all(15.0),
                  child: const Text(
                    '尊敬的員工您好，您已進入企業涉密區域，出于企業安全考慮，您的手機攝像頭將被禁止拍攝，感謝您的配合。',
                    style: TextStyle(
                      color: Color(0xFFB5BCC4),
                      fontSize: 13,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF1B232D),
        selectedItemColor: const Color(0xFFFDCB58),
        unselectedItemColor: const Color(0xFF6C757D),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: '首頁',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.crop_free_outlined),
            activeIcon: Icon(Icons.crop_free),
            label: '掃描',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: '設置',
          ),
        ],
      ),
    );
  }
}
