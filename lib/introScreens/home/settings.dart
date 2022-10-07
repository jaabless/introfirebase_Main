import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:introfirebase/introScreens/home/profile.dart';
import 'package:introfirebase/introScreens/home/settingsWidgets/terms.dart';
import 'package:settings_ui/settings_ui.dart';

class AppSettings extends StatefulWidget {
  const AppSettings({Key? key}) : super(key: key);

  @override
  State<AppSettings> createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 6, 177, 120),
        title: Text('Settings'),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: Text('Common'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: Icon(Icons.language),
                title: Text('Language'),
                value: Text('English'),
              ),
              SettingsTile.switchTile(
                onToggle: (value) {},
                initialValue: true,
                leading: Icon(Icons.format_paint),
                title: Text('Enable custom theme'),
              ),
            ],
          ),
          SettingsSection(
            title: Text('Help'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: Icon(Icons.help),
                title: Text('Help Center'),
              ),
              SettingsTile.navigation(
                leading: Icon(Icons.group),
                title: Text('Contact us'),
                value: Text('Questions? Need help'),
              ),
              SettingsTile.navigation(
                leading: Icon(Icons.info),
                title: Text('Terms and Privacy Policy'),
                onPressed: (BuildContext) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PrivacyPolicy()));
                },
                trailing: Icon(Icons.edit),
              ),
              SettingsTile.navigation(
                leading: Icon(Icons.info),
                title: Text('Help Center'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
