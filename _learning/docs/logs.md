# Logs in Dart

## Avoiding:  Don't invoke 'print'

When using:
```dart
print(age);
```

This warning may occur:
```terminal
_learning\variables.dart:17:3 • Don't invoke 'print' in production code. Try using a logging framework. • avoid_print
```

### To avoid

#### Option A — dart:developer (built-in, recommended baseline)

```dart
import 'dart:developer' as dev;

dev.log('Something happened');
```

Also add metadata:

```dart
dev.log(
  'User logged in',
  name: 'auth',
  level: 800,
);
```

#### Option B — logger package (most common third-party choice)

```YAML
dependencies:
  logger: ^2.0.0
```

Usage:

```dart
import 'package:logger/logger.dart';

final logger = Logger();

logger.d('Debug message');
logger.i('Info message');
logger.w('Warning message');
logger.e('Error message');
```

#### Option C — Conditional logging (custom approach)

```dart
import 'package:flutter/foundation.dart';

void log(String message) {
  if (kDebugMode) {
    print(message);
  }
}
```
