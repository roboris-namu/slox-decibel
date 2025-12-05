import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/// 다국어 지원 클래스 (8개 언어)
class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const List<LocalizationsDelegate> localizationsDelegates = [
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  static const List<Locale> supportedLocales = [
    Locale('ko'), // 한국어
    Locale('en'), // 영어
    Locale('ja'), // 일본어
    Locale('zh'), // 중국어
    Locale('es'), // 스페인어
    Locale('pt'), // 포르투갈어
    Locale('de'), // 독일어
    Locale('fr'), // 프랑스어
  ];

  // 번역 데이터
  static final Map<String, Map<String, String>> _localizedValues = {
    'ko': {
      'appName': 'SLOX 데시벨',
      'soundLevel': '소음 수준',
      'decibel': 'dB',
      'min': '최소',
      'max': '최대',
      'avg': '평균',
      'start': '측정 시작',
      'stop': '측정 중지',
      'permissionDenied': '마이크 권한이 필요합니다',
      'requestPermission': '권한 요청',
      'quiet': '조용함',
      'normal': '보통',
      'loud': '시끄러움',
      'veryLoud': '매우 시끄러움',
      'dangerous': '위험',
      'settings': '설정',
      'language': '언어',
      'about': '앱 정보',
      'version': '버전',
      'reset': '초기화',
      'whisper': '속삭임',
      'library': '도서관',
      'conversation': '대화',
      'traffic': '교통 소음',
      'concert': '콘서트',
      'jet': '제트기',
    },
    'en': {
      'appName': 'SLOX Decibel',
      'soundLevel': 'Sound Level',
      'decibel': 'dB',
      'min': 'Min',
      'max': 'Max',
      'avg': 'Avg',
      'start': 'Start',
      'stop': 'Stop',
      'permissionDenied': 'Microphone permission required',
      'requestPermission': 'Request Permission',
      'quiet': 'Quiet',
      'normal': 'Normal',
      'loud': 'Loud',
      'veryLoud': 'Very Loud',
      'dangerous': 'Dangerous',
      'settings': 'Settings',
      'language': 'Language',
      'about': 'About',
      'version': 'Version',
      'reset': 'Reset',
      'whisper': 'Whisper',
      'library': 'Library',
      'conversation': 'Conversation',
      'traffic': 'Traffic',
      'concert': 'Concert',
      'jet': 'Jet Engine',
    },
    'ja': {
      'appName': 'SLOX デシベル',
      'soundLevel': '騒音レベル',
      'decibel': 'dB',
      'min': '最小',
      'max': '最大',
      'avg': '平均',
      'start': '測定開始',
      'stop': '測定停止',
      'permissionDenied': 'マイクの許可が必要です',
      'requestPermission': '許可をリクエスト',
      'quiet': '静か',
      'normal': '普通',
      'loud': 'うるさい',
      'veryLoud': '非常にうるさい',
      'dangerous': '危険',
      'settings': '設定',
      'language': '言語',
      'about': 'アプリについて',
      'version': 'バージョン',
      'reset': 'リセット',
      'whisper': 'ささやき',
      'library': '図書館',
      'conversation': '会話',
      'traffic': '交通騒音',
      'concert': 'コンサート',
      'jet': 'ジェット機',
    },
    'zh': {
      'appName': 'SLOX 分贝',
      'soundLevel': '噪音级别',
      'decibel': 'dB',
      'min': '最小',
      'max': '最大',
      'avg': '平均',
      'start': '开始测量',
      'stop': '停止测量',
      'permissionDenied': '需要麦克风权限',
      'requestPermission': '请求权限',
      'quiet': '安静',
      'normal': '正常',
      'loud': '吵闹',
      'veryLoud': '非常吵闹',
      'dangerous': '危险',
      'settings': '设置',
      'language': '语言',
      'about': '关于',
      'version': '版本',
      'reset': '重置',
      'whisper': '耳语',
      'library': '图书馆',
      'conversation': '对话',
      'traffic': '交通噪音',
      'concert': '音乐会',
      'jet': '喷气式飞机',
    },
    'es': {
      'appName': 'SLOX Decibelios',
      'soundLevel': 'Nivel de Sonido',
      'decibel': 'dB',
      'min': 'Mín',
      'max': 'Máx',
      'avg': 'Prom',
      'start': 'Iniciar',
      'stop': 'Detener',
      'permissionDenied': 'Se requiere permiso de micrófono',
      'requestPermission': 'Solicitar Permiso',
      'quiet': 'Silencioso',
      'normal': 'Normal',
      'loud': 'Ruidoso',
      'veryLoud': 'Muy Ruidoso',
      'dangerous': 'Peligroso',
      'settings': 'Ajustes',
      'language': 'Idioma',
      'about': 'Acerca de',
      'version': 'Versión',
      'reset': 'Reiniciar',
      'whisper': 'Susurro',
      'library': 'Biblioteca',
      'conversation': 'Conversación',
      'traffic': 'Tráfico',
      'concert': 'Concierto',
      'jet': 'Motor a reacción',
    },
    'pt': {
      'appName': 'SLOX Decibéis',
      'soundLevel': 'Nível de Som',
      'decibel': 'dB',
      'min': 'Mín',
      'max': 'Máx',
      'avg': 'Méd',
      'start': 'Iniciar',
      'stop': 'Parar',
      'permissionDenied': 'Permissão de microfone necessária',
      'requestPermission': 'Solicitar Permissão',
      'quiet': 'Silencioso',
      'normal': 'Normal',
      'loud': 'Alto',
      'veryLoud': 'Muito Alto',
      'dangerous': 'Perigoso',
      'settings': 'Configurações',
      'language': 'Idioma',
      'about': 'Sobre',
      'version': 'Versão',
      'reset': 'Reiniciar',
      'whisper': 'Sussurro',
      'library': 'Biblioteca',
      'conversation': 'Conversa',
      'traffic': 'Tráfego',
      'concert': 'Concerto',
      'jet': 'Motor a jato',
    },
    'de': {
      'appName': 'SLOX Dezibel',
      'soundLevel': 'Lautstärke',
      'decibel': 'dB',
      'min': 'Min',
      'max': 'Max',
      'avg': 'Durchschn.',
      'start': 'Starten',
      'stop': 'Stoppen',
      'permissionDenied': 'Mikrofonberechtigung erforderlich',
      'requestPermission': 'Berechtigung anfordern',
      'quiet': 'Leise',
      'normal': 'Normal',
      'loud': 'Laut',
      'veryLoud': 'Sehr Laut',
      'dangerous': 'Gefährlich',
      'settings': 'Einstellungen',
      'language': 'Sprache',
      'about': 'Über',
      'version': 'Version',
      'reset': 'Zurücksetzen',
      'whisper': 'Flüstern',
      'library': 'Bibliothek',
      'conversation': 'Gespräch',
      'traffic': 'Verkehr',
      'concert': 'Konzert',
      'jet': 'Düsenflugzeug',
    },
    'fr': {
      'appName': 'SLOX Décibels',
      'soundLevel': 'Niveau Sonore',
      'decibel': 'dB',
      'min': 'Min',
      'max': 'Max',
      'avg': 'Moy',
      'start': 'Démarrer',
      'stop': 'Arrêter',
      'permissionDenied': 'Permission microphone requise',
      'requestPermission': 'Demander Permission',
      'quiet': 'Silencieux',
      'normal': 'Normal',
      'loud': 'Fort',
      'veryLoud': 'Très Fort',
      'dangerous': 'Dangereux',
      'settings': 'Paramètres',
      'language': 'Langue',
      'about': 'À propos',
      'version': 'Version',
      'reset': 'Réinitialiser',
      'whisper': 'Chuchotement',
      'library': 'Bibliothèque',
      'conversation': 'Conversation',
      'traffic': 'Circulation',
      'concert': 'Concert',
      'jet': 'Avion à réaction',
    },
  };

  String get(String key) {
    return _localizedValues[locale.languageCode]?[key] ??
        _localizedValues['en']![key] ??
        key;
  }

  // 편의 getter들
  String get appName => get('appName');
  String get soundLevel => get('soundLevel');
  String get decibel => get('decibel');
  String get min => get('min');
  String get max => get('max');
  String get avg => get('avg');
  String get start => get('start');
  String get stop => get('stop');
  String get permissionDenied => get('permissionDenied');
  String get requestPermission => get('requestPermission');
  String get quiet => get('quiet');
  String get normal => get('normal');
  String get loud => get('loud');
  String get veryLoud => get('veryLoud');
  String get dangerous => get('dangerous');
  String get settings => get('settings');
  String get language => get('language');
  String get about => get('about');
  String get version => get('version');
  String get reset => get('reset');
  String get whisper => get('whisper');
  String get library => get('library');
  String get conversation => get('conversation');
  String get traffic => get('traffic');
  String get concert => get('concert');
  String get jet => get('jet');
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['ko', 'en', 'ja', 'zh', 'es', 'pt', 'de', 'fr']
        .contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

