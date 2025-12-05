import 'dart:async';
import 'package:flutter/material.dart';
import 'package:noise_meter/noise_meter.dart';
import 'package:permission_handler/permission_handler.dart';
import '../l10n/app_localizations.dart';
import '../widgets/decibel_gauge.dart';
import '../widgets/stats_card.dart';
import '../widgets/noise_level_indicator.dart';

class HomeScreen extends StatefulWidget {
  final Locale currentLocale;
  final Function(Locale) onLocaleChange;

  const HomeScreen({
    super.key,
    required this.currentLocale,
    required this.onLocaleChange,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  bool _isRecording = false;
  bool _hasPermission = false;
  
  NoiseMeter? _noiseMeter;
  StreamSubscription<NoiseReading>? _noiseSubscription;
  
  double _currentDecibel = 0;
  double _minDecibel = 999;
  double _maxDecibel = 0;
  double _avgDecibel = 0;
  final List<double> _decibelHistory = [];
  
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _noiseMeter = NoiseMeter();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
    _checkPermission();
  }

  @override
  void dispose() {
    _noiseSubscription?.cancel();
    _pulseController.dispose();
    super.dispose();
  }

  Future<void> _checkPermission() async {
    final status = await Permission.microphone.status;
    setState(() {
      _hasPermission = status.isGranted;
    });
  }

  Future<void> _requestPermission() async {
    final status = await Permission.microphone.request();
    setState(() {
      _hasPermission = status.isGranted;
    });
  }

  void _startRecording() async {
    if (!_hasPermission) {
      await _requestPermission();
      if (!_hasPermission) return;
    }

    try {
      _noiseSubscription = _noiseMeter!.noise.listen(
        _onData,
        onError: _onError,
      );
      setState(() {
        _isRecording = true;
      });
    } catch (e) {
      debugPrint('Error starting noise meter: $e');
    }
  }

  void _stopRecording() {
    _noiseSubscription?.cancel();
    setState(() {
      _isRecording = false;
    });
  }

  void _onData(NoiseReading reading) {
    setState(() {
      // meanDecibel을 사용 (noise_meter 5.x 버전)
      _currentDecibel = reading.meanDecibel.clamp(0, 150);
      
      if (_currentDecibel < _minDecibel) _minDecibel = _currentDecibel;
      if (_currentDecibel > _maxDecibel) _maxDecibel = _currentDecibel;
      
      _decibelHistory.add(_currentDecibel);
      if (_decibelHistory.length > 100) {
        _decibelHistory.removeAt(0);
      }
      
      _avgDecibel = _decibelHistory.reduce((a, b) => a + b) / _decibelHistory.length;
    });
  }

  void _onError(Object error) {
    debugPrint('Noise meter error: $error');
    _stopRecording();
  }

  void _resetStats() {
    setState(() {
      _minDecibel = 999;
      _maxDecibel = 0;
      _avgDecibel = 0;
      _decibelHistory.clear();
    });
  }

  void _showLanguageDialog() {
    final l10n = AppLocalizations.of(context);
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A24),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.language,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _languageChip('🇰🇷', '한국어', const Locale('ko')),
                _languageChip('🇺🇸', 'English', const Locale('en')),
                _languageChip('🇯🇵', '日本語', const Locale('ja')),
                _languageChip('🇨🇳', '中文', const Locale('zh')),
                _languageChip('🇪🇸', 'Español', const Locale('es')),
                _languageChip('🇧🇷', 'Português', const Locale('pt')),
                _languageChip('🇩🇪', 'Deutsch', const Locale('de')),
                _languageChip('🇫🇷', 'Français', const Locale('fr')),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _languageChip(String flag, String name, Locale locale) {
    final isSelected = widget.currentLocale.languageCode == locale.languageCode;
    return GestureDetector(
      onTap: () {
        widget.onLocaleChange(locale);
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF6366F1) : const Color(0xFF2A2A34),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFF6366F1) : Colors.transparent,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(flag, style: const TextStyle(fontSize: 18)),
            const SizedBox(width: 8),
            Text(
              name,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white70,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0A0A0F),
              Color(0xFF12121A),
              Color(0xFF0A0A0F),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // 헤더
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF6366F1), Color(0xFF06B6D4)],
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Text(
                              'S',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          l10n.appName,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: _resetStats,
                          icon: const Icon(Icons.refresh, color: Colors.white70),
                        ),
                        IconButton(
                          onPressed: _showLanguageDialog,
                          icon: const Icon(Icons.language, color: Colors.white70),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // 메인 게이지
              Expanded(
                child: !_hasPermission
                    ? _buildPermissionRequest(l10n)
                    : _buildMainContent(l10n),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPermissionRequest(AppLocalizations l10n) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.mic_off,
            size: 80,
            color: Colors.white.withOpacity(0.3),
          ),
          const SizedBox(height: 24),
          Text(
            l10n.permissionDenied,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _requestPermission,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6366F1),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Text(
              l10n.requestPermission,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent(AppLocalizations l10n) {
    return Column(
      children: [
        const Spacer(),
        
        // 데시벨 게이지
        DecibelGauge(
          decibel: _currentDecibel,
          isRecording: _isRecording,
          pulseAnimation: _pulseController,
        ),
        
        const SizedBox(height: 20),
        
        // 소음 레벨 표시
        NoiseLevelIndicator(
          decibel: _currentDecibel,
          l10n: l10n,
        ),
        
        const Spacer(),
        
        // 통계 카드들
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              Expanded(
                child: StatsCard(
                  label: l10n.min,
                  value: _minDecibel < 999 ? _minDecibel : 0,
                  color: const Color(0xFF06B6D4),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: StatsCard(
                  label: l10n.avg,
                  value: _avgDecibel,
                  color: const Color(0xFF8B5CF6),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: StatsCard(
                  label: l10n.max,
                  value: _maxDecibel,
                  color: const Color(0xFFF43F5E),
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 32),
        
        // 시작/중지 버튼
        GestureDetector(
          onTap: _isRecording ? _stopRecording : _startRecording,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: _isRecording
                    ? [const Color(0xFFF43F5E), const Color(0xFFEC4899)]
                    : [const Color(0xFF6366F1), const Color(0xFF06B6D4)],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: (_isRecording
                          ? const Color(0xFFF43F5E)
                          : const Color(0xFF6366F1))
                      .withOpacity(0.4),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Icon(
              _isRecording ? Icons.stop : Icons.mic,
              color: Colors.white,
              size: 36,
            ),
          ),
        ),
        
        const SizedBox(height: 12),
        
        Text(
          _isRecording ? l10n.stop : l10n.start,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 14,
          ),
        ),
        
        const SizedBox(height: 40),
      ],
    );
  }
}

