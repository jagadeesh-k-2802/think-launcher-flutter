import 'package:flutter/material.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:think_launcher/l10n/app_localizations.dart';
import 'package:think_launcher/utils/no_grow_scroll_behaviour.dart';
import 'package:think_launcher/models/app_info.dart';
import 'package:think_launcher/models/folder.dart';
import 'dart:convert';

class AppSelectionScreen extends StatefulWidget {
  final SharedPreferences prefs;
  final List<String> selectedApps;

  const AppSelectionScreen({
    super.key,
    required this.prefs,
    required this.selectedApps,
  });

  @override
  State<AppSelectionScreen> createState() => _AppSelectionScreenState();
}

class _AppSelectionScreenState extends State<AppSelectionScreen> {
  List<AppInfo> apps = [];
  List<AppInfo> filteredApps = [];
  final TextEditingController _searchController = TextEditingController();
  String? errorMessage;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadApps();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadApps() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      final installedApps = await InstalledApps.getInstalledApps(
        false, // excludeSystemApps
        false, // withIcon
        '', // packageNamePrefix
      );

      final appInfos =
          installedApps.map((app) => AppInfo.fromInstalledApps(app)).toList();
      appInfos.sort((a, b) => a.name.compareTo(b.name));

      if (mounted) {
        setState(() {
          apps = appInfos;
          filteredApps = List.from(appInfos);
          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error loading apps: $e');
      if (mounted) {
        setState(() {
          errorMessage = 'Error loading applications';
          isLoading = false;
        });
      }
    }
  }

  void _filterApps(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredApps = List.from(apps);
      } else {
        filteredApps = apps
            .where(
                (app) => app.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  /// Updates the selected apps list and persists changes.
  /// This ensures immediate state updates and proper persistence.
  Future<void> _updateSelectedApps(List<String> newSelectedApps) async {
    try {
      setState(() {
        widget.selectedApps.clear();
        widget.selectedApps.addAll(newSelectedApps);
      });

      // Save changes immediately
      await widget.prefs.setStringList('selectedApps', widget.selectedApps);
    } catch (e) {
      debugPrint('Error updating selected apps: $e');
    }
  }

  /// Toggles selection state for a single app and handles folder cleanup.
  Future<void> _selectApp(String packageName) async {
    final newSelectedApps = List<String>.from(widget.selectedApps);
    final isDeselecting = newSelectedApps.contains(packageName);
    
    if (isDeselecting) {
      newSelectedApps.remove(packageName);
      
      // Clean up folders when app is deselected
      final foldersJson = widget.prefs.getString('folders') ?? '[]';
      final List<dynamic> decodedFolders = jsonDecode(foldersJson);
      final folders = decodedFolders.map((f) => Folder.fromJson(f)).toList();
      
      bool foldersChanged = false;
      
      // Remove app from any folders it's in
      for (int i = 0; i < folders.length; i++) {
        final folder = folders[i];
        if (folder.appPackageNames.contains(packageName)) {
          folders[i] = folder.copyWith(
            appPackageNames: folder.appPackageNames
                .where((app) => app != packageName)
                .toList(),
          );
          foldersChanged = true;
        }
      }
      
      // Remove empty folders
      folders.removeWhere((folder) => folder.appPackageNames.isEmpty);
      
      // Save updated folders if changed
      if (foldersChanged) {
        final updatedFoldersJson = jsonEncode(folders.map((f) => f.toJson()).toList());
        await widget.prefs.setString('folders', updatedFoldersJson);
      }
    } else {
      newSelectedApps.add(packageName);
    }
    
    await _updateSelectedApps(newSelectedApps);
  }

  /// Selects all available apps.
  Future<void> _selectAll() async {
    final newSelectedApps = apps.map((app) => app.packageName).toList();
    await _updateSelectedApps(newSelectedApps);
  }

  /// Deselects all apps.
  Future<void> _deselectAll() async {
    await _updateSelectedApps([]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.selectAppsTitle),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, widget.selectedApps),
              tooltip: AppLocalizations.of(context)!.cancel,
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.selectedAppsCount(
                        widget.selectedApps.length,
                      ),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: _selectAll,
                          child: Text(AppLocalizations.of(context)!.selectAll),
                        ),
                        const SizedBox(width: 8),
                        TextButton(
                          onPressed: _deselectAll,
                          child: Text(AppLocalizations.of(context)!.deselectAll),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _searchController,
                  autofocus: false,
                  showCursor: true,
                  cursorColor: Colors.black,
                  cursorWidth: 2,
                  cursorRadius: const Radius.circular(1),
                  cursorOpacityAnimates: false,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.searchAppsHint,
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor:
                        Theme.of(context).colorScheme.surfaceContainerHighest,
                  ),
                  onChanged: _filterApps,
                ),
              ),
              if (errorMessage != null)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    errorMessage!,
                    style: const TextStyle(color: Colors.black),
                  ),
                )
              else
                Expanded(
                  child: ScrollConfiguration(
                    behavior: NoGlowScrollBehavior(),
                    child: ListView.builder(
                      itemCount: filteredApps.length,
                      itemBuilder: (context, index) {
                        final app = filteredApps[index];
                        final isSelected =
                            widget.selectedApps.contains(app.packageName);

                        // Use custom app name if available
                        String displayName = app.customName?.isNotEmpty == true
                            ? app.customName!
                            : app.name;

                        return Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => _selectApp(app.packageName),
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      displayName,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                  if (isSelected)
                                    const Icon(
                                      Icons.check_circle,
                                      color: Colors.black,
                                    ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
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
