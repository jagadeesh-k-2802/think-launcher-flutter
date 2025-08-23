// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get appTitle => 'Think Launcher';

  @override
  String get settingsTitle => 'Instellingen';

  @override
  String get pressSettingsButtonToStart => 'Druk op de instellingenknop om te starten';

  @override
  String get numberOfApps => 'Aantal apps';

  @override
  String get back => 'Rug';

  @override
  String get showInformationPanel => 'Tijd, datum, weer weergeven?';

  @override
  String get searchApps => 'Zoek apps';

  @override
  String get showSearchButton => 'Toon zoekknop';

  @override
  String get longPressGestureDisabled => 'Lang indrukken is uitgeschakeld. Schakel het in bij gebarinstellingen om deze knop te verbergen.';

  @override
  String get useBoldFont => 'Gebruik vet lettertype';

  @override
  String get enableListScrolling => 'Scrollen in lijst inschakelen';

  @override
  String get showIcons => 'Toon pictogrammen';

  @override
  String get showStatusBar => 'Toon statusbalk';

  @override
  String get appFontSize => 'App lettergrootte';

  @override
  String get appIconSize => 'App pictogramgrootte';

  @override
  String get appList => 'App lijst';

  @override
  String appsSelected(int count, int total) {
    return '$count van $total apps geselecteerd';
  }

  @override
  String get reorderAppsFolders => 'Apps en mappen opnieuw ordenen';

  @override
  String get manageFolders => 'Mappen beheren';

  @override
  String get createAndOrganizeFolders => 'Maak en organiseer app-mappen';

  @override
  String get gestures => 'Gebaren';

  @override
  String get configureGestures => 'Configureer app-gebaren';

  @override
  String get save => 'Opslaan';

  @override
  String get delete => 'Verwijderen';

  @override
  String get cancel => 'Annuleren';

  @override
  String get pressSettingsToStart => 'Druk op de instellingenknop om te beginnen';

  @override
  String get loading => 'Laden...';

  @override
  String get errorLoadingApps => 'Fout bij laden van applicaties';

  @override
  String get noAppsSelected => 'Geen applicaties geselecteerd';

  @override
  String get createFolder => 'Map maken';

  @override
  String get renameApp => 'App hernoemen';

  @override
  String get moveToFolder => 'Verplaats naar map';

  @override
  String get noOtherFoldersAvailable => 'Er zijn geen andere mappen beschikbaar om deze app naartoe te verplaatsen.';

  @override
  String get selectFolder => 'Selecteer map';

  @override
  String get resetAppName => 'App-naam resetten';

  @override
  String get folderName => 'Mapnaam';

  @override
  String get editFolder => 'Map bewerken';

  @override
  String get deleteFolder => 'Map verwijderen';

  @override
  String deleteFolderConfirm(String name) {
    return 'Weet je zeker dat je \"$name\" wilt verwijderen?';
  }

  @override
  String manageAppsInFolder(String name) {
    return 'Apps beheren in $name';
  }

  @override
  String get reOrderApps => 'Apps opnieuw ordenen';

  @override
  String get errorSavingSettings => 'Fout bij opslaan van instellingen';

  @override
  String get gestureSettings => 'Gebareninstellingen';

  @override
  String get swipeUp => 'Omhoog vegen';

  @override
  String get longPress => 'Lang indrukken';

  @override
  String get doubleTap => 'Dubbeltikken';

  @override
  String get selectAction => 'Selecteer actie';

  @override
  String get noAction => 'Geen actie';

  @override
  String get folderManagement => 'Mappenbeheer';

  @override
  String get addAppsToFolder => 'Apps toevoegen aan map';

  @override
  String get removeAppsFromFolder => 'Apps verwijderen uit map';

  @override
  String get reorderAppsInFolder => 'Apps opnieuw ordenen';

  @override
  String get noFolders => 'Nog geen mappen gemaakt';

  @override
  String get selectAppsForFolder => 'Selecteer apps voor map';

  @override
  String get folderCreated => 'Map succesvol aangemaakt';

  @override
  String get folderUpdated => 'Map succesvol bijgewerkt';

  @override
  String get folderDeleted => 'Map succesvol verwijderd';

  @override
  String get selectApps => 'Apps selecteren';

  @override
  String get searchAppsHint => 'Zoek apps op naam';

  @override
  String get selectAll => 'Alles selecteren';

  @override
  String get deselectAll => 'Alles deselecteren';

  @override
  String get appInfo => 'App-info';

  @override
  String get uninstallApp => 'App verwijderen';

  @override
  String confirmUninstall(String appName) {
    return 'Weet je zeker dat je $appName wilt verwijderen?';
  }

  @override
  String get appOptions => 'App-opties';

  @override
  String get couldNotOpenApp => 'Kon de applicatie niet openen';

  @override
  String get selectAppsTitle => 'Apps selecteren';

  @override
  String get gesturesTitle => 'Gebaren';

  @override
  String get selectAppTitle => 'App selecteren';

  @override
  String appsInFolder(int count) {
    return '$count apps';
  }

  @override
  String get notSelected => 'Niet geselecteerd';

  @override
  String selectedAppsCount(int count) {
    return '$count apps geselecteerd';
  }

  @override
  String get autoFocusSearch => 'Automatisch zoeken focussen';

  @override
  String get autoFocusSearchDescription => 'Cursor wordt in het zoekveld geplaatst bij openen';

  @override
  String errorGettingAppInfo(String packageName) {
    return 'Fout bij ophalen van app-info voor $packageName';
  }

  @override
  String get errorUpdatingWeather => 'Fout bij bijwerken van het weer';
}
