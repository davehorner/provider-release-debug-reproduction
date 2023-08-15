import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:tmp/theme_provider.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
        builder: (context, theme, _) => Scaffold(
              appBar: AppBar(
                title: Text('Settings'),
              ),
              body: Stack(children: [
                !theme.animated
                    ? Container()
                    : SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: Text("animated"),
                      ),
                Text(
                  'Theme:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SettingSwitchListTile(
                  model: theme,
                  value: SettingValue.NoTheme,
                ),
              ]),
            ));
  }
}

enum SettingValue {
  NoTheme, // system default
  lightTheme,
  darkTheme,
  animatedTheme,
}

class SettingSwitchListTile extends StatefulWidget {
  final ThemeProvider model;
  final SettingValue value;

  SettingSwitchListTile({required this.model, required this.value});

  @override
  _SettingSwitchListTileState createState() => _SettingSwitchListTileState();
}

class _SettingSwitchListTileState extends State<SettingSwitchListTile> {
  SettingValue _currentValue = SettingValue.NoTheme;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.value;
    if (widget.model.animated) {
      _currentValue = SettingValue.animatedTheme;
      return;
    }
    if (widget.model.mode == ThemeMode.dark)
      _currentValue = SettingValue.darkTheme;
    if (widget.model.mode == ThemeMode.light)
      _currentValue = SettingValue.lightTheme;
    if (widget.model.mode == ThemeMode.system)
      _currentValue = SettingValue.NoTheme;
  }

  void _toggleValue() {
    SettingValue newValue;
    switch (_currentValue) {
      case SettingValue.NoTheme:
        newValue = SettingValue.lightTheme;
        widget.model.setLight();
        break;
      case SettingValue.lightTheme:
        newValue = SettingValue.darkTheme;
        widget.model.setDark();
        break;
      case SettingValue.darkTheme:
        newValue = SettingValue.animatedTheme;
        widget.model.setAnimated();
        break;
      case SettingValue.animatedTheme:
        newValue = SettingValue.NoTheme;
        widget.model.setSystem();
        break;
    }

    setState(() {
      _currentValue = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: _currentValue != SettingValue.NoTheme,
      onChanged: (bool newValue) => _toggleValue(),
      title: Text(_settingValueToString(_currentValue)),
      controlAffinity: ListTileControlAffinity.leading,
    );
  }

  String _settingValueToString(SettingValue value) {
    switch (value) {
      case SettingValue.NoTheme:
        return 'System';
      case SettingValue.lightTheme:
        return 'Light';
      case SettingValue.darkTheme:
        return 'Dark';
      case SettingValue.animatedTheme:
        return 'Animated';
    }
  }
}
