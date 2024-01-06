import 'package:candiboom/Controller/settings_controller.dart';
import 'package:candiboom/Localization/locales.dart';
import 'package:candiboom/View/menu.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late FlutterLocalization _flutterLocalization;
  late SettingsController settingsController;
  late String _currentLocale;

  @override
  void initState() {
    super.initState();
    _flutterLocalization = FlutterLocalization.instance;
    _currentLocale = _flutterLocalization.currentLocale!.languageCode;
    print(_currentLocale);
    // Initialize controllers and settings
    settingsController = SettingsController();
  }

  bool musicPlaying = false;

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40,
                    width: 40,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MainMenu()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(139, 90, 71, 1),
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                    child: Text(
                      context.formatString(LocaleData.body, []),
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 50,
            right: 20,
            child: Container(
              padding: EdgeInsets.all(0.2),
              decoration: BoxDecoration(
                color: Color.fromRGBO(139, 90, 71, 1),
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: IconButton(
                icon: Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                onPressed: () {
                  _openSettings(context, settingsController);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _openSettings(
      BuildContext context, SettingsController settingsController) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return AlertDialog(
              title: Text(context.formatString(LocaleData.setting, [])),
              content: Column(
                children: [
                  SwitchListTile(
                    title: Text(context.formatString(LocaleData.sound, [])),
                    value: settingsController.model.isSoundOn,
                    onChanged: (value) {
                      setState(() {
                        settingsController.toggleSound();
                        _updateAudio(settingsController);
                        settingsController.onSettingsChanged
                            ?.call(); // Call the callback
                      });
                    },
                  ),
                  Slider(
                    value: settingsController.model.soundVolume,
                    onChanged: (value) {
                      setState(() {
                        settingsController.adjustVolume(value);
                        _updateAudio(settingsController);
                        settingsController.onSettingsChanged
                            ?.call(); // Call the callback
                      });
                    },
                    min: 0.0,
                    max: 1.0,
                    divisions: 10,
                    label: 'Volume',
                  ),
                  // ... (Other settings)
                ],
              ),
              actions: [
                DropdownButton(
                  value: _currentLocale,
                  items: const [
                    DropdownMenuItem(
                      value: "en",
                      child: Text("English"),
                    ),
                    DropdownMenuItem(
                      value: "idn",
                      child: Text("Indonesia"),
                    ),
                  ],
                  onChanged: (value) {
                    _setLocale(value);
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    settingsController.saveSettings();
                    Navigator.of(context).pop();
                  },
                  child: Text('Save'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Close'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _updateAudio(SettingsController settingsController) {
    if (settingsController.model.isSoundOn) {
      if (!musicPlaying) {
        FlameAudio.bgm.play('sound.mp3');
        musicPlaying = true;
      }
      // Set the volume using FlameAudio's setBgmVolume method
      FlameAudio.bgm.audioPlayer.setVolume(settingsController.model.soundVolume);
    } else {
      if (musicPlaying) {
        FlameAudio.bgm.stop();
        musicPlaying = false;
      }
    }
  }

  void _setLocale(String? value) {
    if (value == null) return;
    if (value == "en") {
      _flutterLocalization.translate("en");
    } else if (value == "idn") {
      _flutterLocalization.translate("idn");
    } else {
      return;
    }
    setState(() {
      _currentLocale = value;
    });
  }
}
