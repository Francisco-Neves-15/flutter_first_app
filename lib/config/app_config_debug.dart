import 'package:flutter/foundation.dart' show kReleaseMode;

const bool debugBlockLoadingAnimation = true;

const bool debugFront = false;
const bool debugBack = false;

const bool debugInDev = false;

void validateDebugConfig() {
  const debugOffInterface = debugBlockLoadingAnimation;
  const debugOffMain = debugFront || debugBack || debugInDev;
  if (kReleaseMode && debugOffInterface && debugOffMain) {
    throw StateError(
      'app-config-debug: debugging settings cannot be enabled in a production build.',
    );
  }
}

// Possibility

// bool.fromEnvironment

// E.g.: creating the variable and retrieving the flag present in the environment

// const bool debugFront = bool.fromEnvironment('DEBUG_FRONT', defaultValue: false);
// const bool debugBack = bool.fromEnvironment('DEBUG_BACK', defaultValue: false);
// const bool debugInDev = bool.fromEnvironment('DEBUG_IN_DEV', defaultValue: false);

// when running the app

// flutter run --dart-define=DEBUG_FRONT=true --dart-define=DEBUG_BACK=true --dart-define=DEBUG_IN_DEV=true

// when building the apk

// flutter build apk --release --dart-define=DEBUG_FRONT=true --dart-define=DEBUG_BACK=true --dart-define=DEBUG_IN_DEV=true
