import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:think_launcher/l10n/app_localizations.dart';
import 'package:think_launcher/utils/no_grow_scroll_behaviour.dart';
import 'package:think_launcher/screens/app_selection_screen.dart';
import 'package:think_launcher/screens/folder_management_screen.dart';
import 'package:think_launcher/screens/gesture_settings_screen.dart';
import 'package:think_launcher/screens/reorder_apps_screen.dart';

class SettingsScreen extends StatefulWidget {
  final SharedPreferences prefs;

  const SettingsScreen({super.key, required this.prefs});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool showDateTime = true;
  bool showSearchButton = true;
  double appFontSize = 18.0;
  double appIconSize = 35.0;
  bool enableScroll = true;
  bool showIcons = false;
  List<String> selectedApps = [];
  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  void _loadSettings() {
    setState(() {
      showDateTime = widget.prefs.getBool('showDateTime') ?? true;
      showSearchButton = widget.prefs.getBool('showSearchButton') ?? true;

      appFontSize = widget.prefs.getDouble('appFontSize') ?? 18.0;
      appIconSize = widget.prefs.getDouble('appIconSize') ?? 35.0;
      enableScroll = widget.prefs.getBool('enableScroll') ?? true;
      showIcons = widget.prefs.getBool('showIcons') ?? true;
      selectedApps = widget.prefs.getStringList('selectedApps') ?? [];
    });
  }

  Future<void> _saveSettings() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      await widget.prefs.setBool('showDateTime', showDateTime);
      await widget.prefs.setBool('showSearchButton', showSearchButton);

      await widget.prefs.setDouble('appFontSize', appFontSize);
      await widget.prefs.setDouble('appIconSize', appIconSize);
      await widget.prefs.setBool('enableScroll', enableScroll);
      await widget.prefs.setBool('showIcons', showIcons);
      await widget.prefs.setStringList('selectedApps', selectedApps);

      // Update status bar visibility
      final showStatusBar = widget.prefs.getBool('showStatusBar') ?? false;
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: showStatusBar
            ? [SystemUiOverlay.top, SystemUiOverlay.bottom]
            : [SystemUiOverlay.bottom],
      );
    } catch (e) {
      debugPrint('Error saving settings: $e');
      if (mounted) {
        setState(() {
          errorMessage = AppLocalizations.of(context)!.errorSavingSettings;
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> _selectApps() async {
    final result = await Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return AppSelectionScreen(
            prefs: widget.prefs,
            selectedApps: List.from(selectedApps),
          );
        },
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );

    if (result != null && result is List<String>) {
      setState(() {
        selectedApps = List.from(result);
      });
      await _saveSettings();
    }
  }

  Future<void> _reorderApps() async {
    if (selectedApps.isEmpty) return;

    final result = await Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return ReorderAppsScreen(
            prefs: widget.prefs,
            folder: null
          );
        },
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );

    if (result != null && result is List<String>) {
      setState(() {
        selectedApps = result;
        _saveSettings();
      });
    }
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
            title: Text(AppLocalizations.of(context)!.settingsTitle),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: Stack(
            children: [
              Theme(
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
                      // 1. Show date, time and battery
                      SwitchListTile(
                        title: Text(
                          AppLocalizations.of(context)!.showInformationPanel,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        value: showDateTime,
                        onChanged: (value) {
                          setState(() {
                            showDateTime = value;
                          });
                          _saveSettings();
                        },
                      ),

                      // 2. Show search button
                      SwitchListTile(
                        title: Text(
                          AppLocalizations.of(context)!.showSearchButton,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        value: showSearchButton,
                        onChanged: (value) {
                          setState(() {
                            showSearchButton = value;
                          });
                          _saveSettings();
                        },
                      ),

                      // 3. Enable list scrolling
                      SwitchListTile(
                        title: Text(
                          AppLocalizations.of(context)!.enableListScrolling,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        value: enableScroll,
                        onChanged: (value) {
                          setState(() {
                            enableScroll = value;
                          });
                          _saveSettings();
                        },
                      ),

                      // 4. Show status bar
                      SwitchListTile(
                        title: Text(
                          AppLocalizations.of(context)!.showStatusBar,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        value: widget.prefs.getBool('showStatusBar') ?? false,
                        onChanged: (value) {
                          setState(() {
                            widget.prefs.setBool('showStatusBar', value);
                          });
                          _saveSettings();
                        },
                      ),

                      // 5. Show icons
                      SwitchListTile(
                        title: Text(
                          AppLocalizations.of(context)!.showIcons,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        value: showIcons,
                        onChanged: (value) {
                          setState(() {
                            showIcons = value;
                          });
                          _saveSettings();
                        },
                      ),

                      // 6. App font size
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          AppLocalizations.of(context)!.appFontSize,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: appFontSize > 14
                                  ? () {
                                      setState(() {
                                        appFontSize--;
                                      });
                                    }
                                  : null,
                              icon: const Icon(Icons.remove),
                            ),
                            Expanded(
                              child: SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  overlayShape: SliderComponentShape.noOverlay,
                                  valueIndicatorColor: Colors.transparent,
                                  valueIndicatorTextStyle:
                                      const TextStyle(color: Colors.black),
                                  thumbShape: const RoundSliderThumbShape(
                                    enabledThumbRadius: 12,
                                    elevation: 0,
                                    pressedElevation: 0,
                                  ),
                                  trackHeight: 2,
                                  activeTrackColor: Colors.black,
                                  inactiveTrackColor: Colors.grey,
                                  thumbColor: Colors.black,
                                  overlayColor: Colors.transparent,
                                  showValueIndicator: ShowValueIndicator.onlyForContinuous,
                                ),
                                child: Slider(
                                  value: appFontSize,
                                  min: 14,
                                  max: 32,
                                  label: appFontSize.toStringAsFixed(0),
                                  onChanged: (value) {
                                    setState(() {
                                      appFontSize = value.roundToDouble();
                                    });
                                    _saveSettings();
                                  },
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: appFontSize < 32
                                  ? () {
                                      setState(() {
                                        appFontSize++;
                                      });
                                    }
                                  : null,
                              icon: const Icon(Icons.add),
                            ),
                          ],
                        ),
                      ),

                      // 7. App icon size
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          AppLocalizations.of(context)!.appIconSize,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: appIconSize > 16
                                  ? () {
                                      setState(() {
                                        appIconSize--;
                                      });
                                    }
                                  : null,
                              icon: const Icon(Icons.remove),
                            ),
                            Expanded(
                              child: SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  overlayShape: SliderComponentShape.noOverlay,
                                  valueIndicatorColor: Colors.transparent,
                                  valueIndicatorTextStyle:
                                      const TextStyle(color: Colors.black),
                                  thumbShape: const RoundSliderThumbShape(
                                    enabledThumbRadius: 12,
                                    elevation: 0,
                                    pressedElevation: 0,
                                  ),
                                  trackHeight: 2,
                                  activeTrackColor: Colors.black,
                                  inactiveTrackColor: Colors.grey,
                                  thumbColor: Colors.black,
                                  overlayColor: Colors.transparent,
                                  showValueIndicator: ShowValueIndicator.onlyForContinuous,
                                ),
                                child: Slider(
                                  value: appIconSize,
                                  min: 16,
                                  max: 128,
                                  label: appIconSize.toStringAsFixed(0),
                                  onChanged: (value) {
                                    setState(() {
                                      appIconSize = value.roundToDouble();
                                    });
                                    _saveSettings();
                                  },
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: appIconSize < 128
                                  ? () {
                                      setState(() {
                                        appIconSize++;
                                      });
                                    }
                                  : null,
                              icon: const Icon(Icons.add),
                            ),
                          ],
                        ),
                      ),

                      // 8. App list
                      ListTile(
                        title: Text(
                          AppLocalizations.of(context)!.appList,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          AppLocalizations.of(context)!.selectedAppsCount(selectedApps.length),
                        ),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: _selectApps,
                      ),

                      // 9. Reorder apps
                      ListTile(
                        title: Text(
                          AppLocalizations.of(context)!.reorderAppsFolders,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: selectedApps.isEmpty ? null : _reorderApps,
                      ),

                      // 10. Manage folders
                      ListTile(
                        title: Text(
                          AppLocalizations.of(context)!.manageFolders,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(AppLocalizations.of(context)!.createAndOrganizeFolders),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) =>
                                  FolderManagementScreen(
                                prefs: widget.prefs,
                                selectedApps: selectedApps,
                              ),
                              transitionDuration: Duration.zero,
                              reverseTransitionDuration: Duration.zero,
                            ),
                          );
                        },
                      ),

                      // 11. Gestures
                      ListTile(
                        title: Text(
                          AppLocalizations.of(context)!.gestures,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(AppLocalizations.of(context)!.configureGestures),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation,
                                      secondaryAnimation) =>
                                  GestureSettingsScreen(prefs: widget.prefs),
                              transitionDuration: Duration.zero,
                              reverseTransitionDuration: Duration.zero,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              if (errorMessage != null)
                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          const Icon(Icons.error_outline, color: Colors.black),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              errorMessage!,
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, color: Colors.black),
                            onPressed: () {
                              setState(() {
                                errorMessage = null;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
