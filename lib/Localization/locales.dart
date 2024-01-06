import 'package:flutter_localization/flutter_localization.dart';

const List<MapLocale> LOCALES = [
  MapLocale("en", LocaleData.EN),
  MapLocale("idn", LocaleData.IDN),
];

mixin LocaleData{
  static const String body = 'body';
  static const String poin = 'poin';
  static const String setting = 'setting';
  static const String sound = 'sound';
  static const String save = 'save';
  static const String close = 'close';
  static const Map<String, dynamic> EN = {
    body: 'Play',
    poin: 'Point : ',
    setting: 'Setting',
    sound: 'Sound',
    save: 'Save',
    close: 'close'
  };

  static const Map<String, dynamic> IDN = {
    body: 'Mulai',
    poin: 'Poin : ',
    setting: 'Pengaturan',
    sound: 'Lagu',
    save: 'Simpan',
    close: 'Tutup'
  };


}