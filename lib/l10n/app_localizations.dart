import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_nl.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('nl')
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Think Launcher'**
  String get appTitle;

  /// Title for the settings screen
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// content for initial text
  ///
  /// In en, this message translates to:
  /// **'Press the settings button to start'**
  String get pressSettingsButtonToStart;

  /// Label for number of apps setting
  ///
  /// In en, this message translates to:
  /// **'Number of apps'**
  String get numberOfApps;

  /// Label for back
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// Label for showing information panel
  ///
  /// In en, this message translates to:
  /// **'Show information panel'**
  String get showInformationPanel;

  /// Title for search apps
  ///
  /// In en, this message translates to:
  /// **'Search apps'**
  String get searchApps;

  /// Label for search button visibility setting
  ///
  /// In en, this message translates to:
  /// **'Show search button'**
  String get showSearchButton;

  /// Message shown when long press gesture is disabled
  ///
  /// In en, this message translates to:
  /// **'Long press gesture is disabled. Enable it in gesture settings to hide this button.'**
  String get longPressGestureDisabled;

  /// Label for bold font setting
  ///
  /// In en, this message translates to:
  /// **'Use bold font'**
  String get useBoldFont;

  /// Label for list scrolling setting
  ///
  /// In en, this message translates to:
  /// **'Enable list scrolling'**
  String get enableListScrolling;

  /// Label for icon visibility setting
  ///
  /// In en, this message translates to:
  /// **'Show icons'**
  String get showIcons;

  /// Label for status bar visibility setting
  ///
  /// In en, this message translates to:
  /// **'Show status bar'**
  String get showStatusBar;

  /// Label for app font size setting
  ///
  /// In en, this message translates to:
  /// **'App font size'**
  String get appFontSize;

  /// Label for app icon size setting
  ///
  /// In en, this message translates to:
  /// **'App icon size'**
  String get appIconSize;

  /// Label for app list section
  ///
  /// In en, this message translates to:
  /// **'App list'**
  String get appList;

  /// Shows how many apps are selected out of total
  ///
  /// In en, this message translates to:
  /// **'{count} of {total} apps selected'**
  String appsSelected(int count, int total);

  /// Label for reorder apps option
  ///
  /// In en, this message translates to:
  /// **'Reorder apps & folders'**
  String get reorderAppsFolders;

  /// Label for manage folders option
  ///
  /// In en, this message translates to:
  /// **'Manage folders'**
  String get manageFolders;

  /// Description for manage folders option
  ///
  /// In en, this message translates to:
  /// **'Create and organize app folders'**
  String get createAndOrganizeFolders;

  /// Label for gestures option
  ///
  /// In en, this message translates to:
  /// **'Gestures'**
  String get gestures;

  /// Description for gestures option
  ///
  /// In en, this message translates to:
  /// **'Configure application gestures'**
  String get configureGestures;

  /// Delete button text
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Cancel button text
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Message shown when no apps are selected
  ///
  /// In en, this message translates to:
  /// **'Press the settings button to start'**
  String get pressSettingsToStart;

  /// Loading message
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// Error message when apps fail to load
  ///
  /// In en, this message translates to:
  /// **'Error loading applications'**
  String get errorLoadingApps;

  /// Message shown when no apps are selected
  ///
  /// In en, this message translates to:
  /// **'No applications selected'**
  String get noAppsSelected;

  /// Title for create folder dialog
  ///
  /// In en, this message translates to:
  /// **'Create Folder'**
  String get createFolder;

  /// Title for rename app dialog
  ///
  /// In en, this message translates to:
  /// **'Rename App'**
  String get renameApp;

  /// Title for move to folder dialog
  ///
  /// In en, this message translates to:
  /// **'Move to Folder'**
  String get moveToFolder;

  /// content for move to folder dialog
  ///
  /// In en, this message translates to:
  /// **'No other folders available to move this app to.'**
  String get noOtherFoldersAvailable;

  /// Title for folder selection dialog
  ///
  /// In en, this message translates to:
  /// **'Select Folder'**
  String get selectFolder;

  /// Title for reset app name option
  ///
  /// In en, this message translates to:
  /// **'Reset App Name'**
  String get resetAppName;

  /// Label for folder name input
  ///
  /// In en, this message translates to:
  /// **'Folder Name'**
  String get folderName;

  /// Title for edit folder dialog
  ///
  /// In en, this message translates to:
  /// **'Edit Folder'**
  String get editFolder;

  /// Title for delete folder dialog
  ///
  /// In en, this message translates to:
  /// **'Delete Folder'**
  String get deleteFolder;

  /// Confirmation message for folder deletion
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{name}\"?'**
  String deleteFolderConfirm(String name);

  /// Title for manage apps in folder dialog
  ///
  /// In en, this message translates to:
  /// **'Manage Apps in {name}'**
  String manageAppsInFolder(String name);

  /// Title for reorder apps
  ///
  /// In en, this message translates to:
  /// **'Reorder Apps'**
  String get reOrderApps;

  /// Error message shown when settings fail to save
  ///
  /// In en, this message translates to:
  /// **'Error saving settings'**
  String get errorSavingSettings;

  /// Title for gesture settings screen
  ///
  /// In en, this message translates to:
  /// **'Gesture Settings'**
  String get gestureSettings;

  /// Label for swipe up gesture
  ///
  /// In en, this message translates to:
  /// **'Swipe Up'**
  String get swipeUp;

  /// Label for long press gesture
  ///
  /// In en, this message translates to:
  /// **'Long Press'**
  String get longPress;

  /// Label for double tap gesture
  ///
  /// In en, this message translates to:
  /// **'Double Tap'**
  String get doubleTap;

  /// Label for selecting gesture action
  ///
  /// In en, this message translates to:
  /// **'Select Action'**
  String get selectAction;

  /// Label for no action option
  ///
  /// In en, this message translates to:
  /// **'No Action'**
  String get noAction;

  /// Title for folder management screen
  ///
  /// In en, this message translates to:
  /// **'Folder Management'**
  String get folderManagement;

  /// Button text for adding apps to folder
  ///
  /// In en, this message translates to:
  /// **'Add Apps to Folder'**
  String get addAppsToFolder;

  /// Button text for removing apps from folder
  ///
  /// In en, this message translates to:
  /// **'Remove Apps from Folder'**
  String get removeAppsFromFolder;

  /// Button text for reordering apps in folder
  ///
  /// In en, this message translates to:
  /// **'Reorder Apps'**
  String get reorderAppsInFolder;

  /// Message shown when no folders exist
  ///
  /// In en, this message translates to:
  /// **'No folders created yet'**
  String get noFolders;

  /// Title for app selection for folder
  ///
  /// In en, this message translates to:
  /// **'Select apps for folder'**
  String get selectAppsForFolder;

  /// Message shown when folder is created
  ///
  /// In en, this message translates to:
  /// **'Folder created successfully'**
  String get folderCreated;

  /// Message shown when folder is updated
  ///
  /// In en, this message translates to:
  /// **'Folder updated successfully'**
  String get folderUpdated;

  /// Message shown when folder is deleted
  ///
  /// In en, this message translates to:
  /// **'Folder deleted successfully'**
  String get folderDeleted;

  /// Title for app selection screen
  ///
  /// In en, this message translates to:
  /// **'Select Apps'**
  String get selectApps;

  /// Hint text for app search field
  ///
  /// In en, this message translates to:
  /// **'Search apps by name'**
  String get searchAppsHint;

  /// Button text to select all apps
  ///
  /// In en, this message translates to:
  /// **'Select All'**
  String get selectAll;

  /// Button text to deselect all apps
  ///
  /// In en, this message translates to:
  /// **'Deselect All'**
  String get deselectAll;

  /// Label for app info option
  ///
  /// In en, this message translates to:
  /// **'App Info'**
  String get appInfo;

  /// Label for uninstall app option
  ///
  /// In en, this message translates to:
  /// **'Uninstall App'**
  String get uninstallApp;

  /// Confirmation message for app uninstallation
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to uninstall {appName}?'**
  String confirmUninstall(String appName);

  /// Title for app options dialog
  ///
  /// In en, this message translates to:
  /// **'App Options'**
  String get appOptions;

  /// Error message when app cannot be opened
  ///
  /// In en, this message translates to:
  /// **'Could not open the application'**
  String get couldNotOpenApp;

  /// Title for app selection screen
  ///
  /// In en, this message translates to:
  /// **'Select apps'**
  String get selectAppsTitle;

  /// Title for gestures screen
  ///
  /// In en, this message translates to:
  /// **'Gestures'**
  String get gesturesTitle;

  /// Title for app selection dialog
  ///
  /// In en, this message translates to:
  /// **'Select app'**
  String get selectAppTitle;

  /// Number of apps in a folder
  ///
  /// In en, this message translates to:
  /// **'{count} apps'**
  String appsInFolder(int count);

  /// Label for when no app is selected
  ///
  /// In en, this message translates to:
  /// **'Not selected'**
  String get notSelected;

  /// Shows how many apps are selected
  ///
  /// In en, this message translates to:
  /// **'{count} apps selected'**
  String selectedAppsCount(int count);

  /// Label for auto focus search setting
  ///
  /// In en, this message translates to:
  /// **'Auto focus search'**
  String get autoFocusSearch;

  /// Description for auto focus search setting
  ///
  /// In en, this message translates to:
  /// **'Cursor will be positioned in the search field when opened'**
  String get autoFocusSearchDescription;

  /// Error message when app info fails to load
  ///
  /// In en, this message translates to:
  /// **'Error getting app info for {packageName}'**
  String errorGettingAppInfo(String packageName);

  /// Error message when weather update fails
  ///
  /// In en, this message translates to:
  /// **'Error updating weather'**
  String get errorUpdatingWeather;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'nl'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'nl': return AppLocalizationsNl();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
