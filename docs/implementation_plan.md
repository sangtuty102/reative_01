# Windows Packaging with Inno Setup & Auto-Update Capability

This plan details how to bundle the release build of the Windows application using Inno Setup for distribution, and implement an auto-update feature within the Flutter app that downloads and executes the new installer from a server.

## User Review Required

> [!IMPORTANT]
> - **Inno Setup Required:** You will need to install Inno Setup on your Windows machine to compile the `.iss` file into the installer `.exe`. You can download it from [jrsoftware.org](https://jrsoftware.org/isdl.php).
> - **Update Server Hosting:** The auto-updater expects a server where you host:
>   1. A `version.json` metadata file (e.g., indicating version, release notes, and setup URL).
>   2. The compiled setup `.exe` installer.
> - **AppMutex:** We configure a mutex `reative_01_mutex` in both the Flutter app and Inno Setup so that the installer can automatically close the running app before overwriting files.

---

## Proposed Changes

### 1. Dependencies Setup

We need to add packages to fetch remote metadata, download the installer file, and get temporary directories.

#### [MODIFY] [pubspec.yaml](file:///E:/reative_01/pubspec.yaml)
Add the following dependencies:
- `package_info_plus`: To read the current app version.
- `path_provider`: To get the local temp directory for downloading the update installer.
- `http`: To request the update check file (`version.json`) and stream the installer download.

---

### 2. Auto-Update Logic

We will create an updater service to handle version checking, downloading, and running the installer.

#### [NEW] [update_service.dart](file:///E:/reative_01/lib/services/update_service.dart)
This service will:
- Check for updates by downloading `version.json` from a specified URL.
- Compare the server's version string (e.g., `1.0.1`) with the local version (e.g., `1.0.0`).
- If a new version exists, download the installer `.exe` with download progress callback.
- Execute the installer detached from the current process:
  - Run the installer `.exe` using `Process.start` with silent args (optional) or regular setup UI.
  - Call `exit(0)` to close the Flutter app immediately, allowing the installer to overwrite files.

---

### 3. UI Update Check Trigger

#### [MODIFY] [main.dart](file:///E:/reative_01/lib/main.dart)
Add a button or trigger in `MyHomePage` to check for updates:
- Check for update on launch or manually.
- If an update is available:
  - Show a dialog detailing the new version, changelog, and a button to "Update Now".
  - Show a download progress bar while downloading the installer.
- Initialize the App Mutex on Windows startup to coordinate with the installer.

---

### 4. Inno Setup Script

#### [NEW] [setup.iss](file:///E:/reative_01/windows/setup.iss)
Create an Inno Setup Script (`.iss`) to package the application files. Key settings include:
- `AppId`: A unique GUID identifying this application.
- `AppName`: Dynamic based on the application name.
- `AppMutex`: `reative_01_mutex` (crucial so that the installer knows to shut down the app before updating).
- `CloseApplications`: `yes` (closes the app automatically).
- Source path: `..\build\windows\x64\runner\Release\*` (bundles the app and its dependencies).
- Output: `..\build\windows\installer\reative_setup.exe`.

---

## Verification Plan

### Manual Verification

1. **Local Setup Compilation:**
   - Build the Windows app in release mode:
     ```powershell
     fvm flutter build windows --release
     ```
   - Run Inno Setup on `windows/setup.iss` to compile `reative_setup.exe`.
   - Install the application on the local computer.

2. **Update flow simulation:**
   - Start the installed application (Version `1.0.0`).
   - Host `version.json` and a new installer `.exe` (Version `1.0.1`) locally (e.g. using `python -m http.server` or a local node server).
   - Click "Check for Update" in the app.
   - Confirm it prompts with the new version, downloads, starts the installer, closes the app, and installs version `1.0.1` successfully.
