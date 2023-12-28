import 'dart:ui';
import 'package:candiboom/Model/setting_model.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsController {
  late SettingsModel _settings;
  VoidCallback? onSettingsChanged;

  SettingsController() {
    _settings = SettingsModel(
      isSoundOn: true,
      soundVolume: 0.5,
      selectedLanguage: 'English',
    );
    _loadSavedSettings(); // Load saved settings during initialization
    _playSound(); // Play sound when the controller is instantiated
  }

  Future<void> _loadSavedSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? selectedLanguage = prefs.getString('selectedLanguage');
    if (selectedLanguage != null) {
      changeLanguage(selectedLanguage);
    }
    onSettingsChanged?.call();
    // Load other settings as needed
  }

  SettingsModel get model => _settings;

  void toggleSound() {
    _settings.isSoundOn = !_settings.isSoundOn;
    _playSound();
  }

  void adjustVolume(double newVolume) {
    _settings.soundVolume = newVolume;
    _playSound();
  }

  void changeLanguage(String newLanguage) {
    _settings.selectedLanguage = newLanguage;
    // Save selected language to SharedPreferences
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('selectedLanguage', newLanguage);
    });
    // Notify the view or update UI as needed
    onSettingsChanged?.call();
  }

  void saveSettings() {
    // In a real application, you would save the settings to persistent storage.
    // For demonstration purposes, we'll just print them.
    print('Saving Settings: $_settings');
  }

  void _playSound() async {
    if (_settings.isSoundOn) {
      String soundPath = 'assets/audio/sound.mp3';
      FlameAudio.bgm.play(soundPath);
      FlameAudio.bgm.audioPlayer.setVolume(_settings.soundVolume);
    } else {
      FlameAudio.bgm.stop();
    }
  }
}
