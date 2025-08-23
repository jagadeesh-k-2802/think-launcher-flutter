import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:think_launcher/l10n/app_localizations.dart';
import 'package:think_launcher/utils/no_grow_scroll_behaviour.dart';

// Theme and style constants
const _kFontSize = 18.0;
const _kSubtitleFontSize = 12.0;

class GestureSettingsScreen extends StatefulWidget {
  final SharedPreferences prefs;

  const GestureSettingsScreen({super.key, required this.prefs});

  @override
  State<GestureSettingsScreen> createState() => _GestureSettingsScreenState();
}

class _GestureSettingsScreenState extends State<GestureSettingsScreen> {
  bool _autoFocusSearch = true;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  void _loadSettings() {
    setState(() {
      _autoFocusSearch = widget.prefs.getBool('autoFocusSearch') ?? true;
      _isLoading = false;
    });
  }

  Future<void> _saveSettings() async {
    await widget.prefs.setBool('autoFocusSearch', _autoFocusSearch);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.gesturesTitle),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: _isLoading
              ? Center(
                  child: Text(
                    AppLocalizations.of(context)!.loading,
                    style: const TextStyle(fontSize: _kFontSize),
                  ),
                )
              : Theme(
                  data: Theme.of(context).copyWith(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    focusColor: Colors.transparent,
                  ),
                  child: ScrollConfiguration(
                    behavior: NoGlowScrollBehavior(),
                    child: ListView(
                      physics: const ClampingScrollPhysics(),
                      children: [
                        SwitchListTile(
                          title: Text(
                            AppLocalizations.of(context)!.autoFocusSearch,
                            style: const TextStyle(
                              fontSize: _kFontSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            AppLocalizations.of(context)!
                                .autoFocusSearchDescription,
                            style:
                                const TextStyle(fontSize: _kSubtitleFontSize),
                          ),
                          value: _autoFocusSearch,
                          onChanged: (value) {
                            setState(() {
                              _autoFocusSearch = value;
                            });
                            _saveSettings();
                          },
                        ),

                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
