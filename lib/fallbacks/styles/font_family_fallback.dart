import "dart:io" show Platform;

const windowsFonts = [
  "Segoe UI",
  "Times New Roman",
];

const appleFonts = [
  "SF Pro Text",
  ".SF UI Text",
  "Helvetica Neue",
];

const androidFonts = [
  "Roboto",
  "Noto Sans",
];

const linuxFonts = [
  "Ubuntu",
  "Cantarell",
  "DejaVu Sans",
  "Liberation Sans",
];

// Very common fonts
const commonFonts = [
  "Arial",
  "Roboto",
];

List<String> resolveFontFamilyFallback({bool useRuntime = true}) {

  final Set<String> fonts = {
    ...commonFonts,
  };

  if (!useRuntime) {
    fonts
      ..addAll(windowsFonts)
      ..addAll(appleFonts)
      ..addAll(androidFonts)
      ..addAll(linuxFonts);
  } else if (Platform.isWindows) {
    fonts.addAll(windowsFonts);
  } else if (Platform.isMacOS || Platform.isIOS) {
    fonts.addAll(appleFonts);
  } else if (Platform.isAndroid) {
    fonts.addAll(androidFonts);
  } else if (Platform.isLinux) {
    fonts.addAll(linuxFonts);
  }

  return fonts.toList();
}
