# Dependencies

## Basic

File: `pubspec.yaml`

Lock File: `pubspec.lock`

After editing manually the `pubspec.yaml`, run: `flutter pub get`

## Installing dependencies

Execute this before starting the project, after "clone" or "pull" the repository.

```terminal
flutter pub get
```
or
```terminal
dart pub get
```

## Adding a package

```terminal
flutter pub add logger
```

This:
- adds dependency to pubspec.yaml
- runs `pub get` automatically

### Installing a specific version

#### Option A — edit `pubspec.yaml`

```YAML
dependencies:
  logger: 2.0.0
```

Then run:
```terminal
flutter pub get
```

#### Option B — use CLI (recommended)

Then run:
```terminal
flutter pub add logger:2.0.0
```

## Removing a package

```terminal
flutter pub remove logger
```

This:
- removes it from pubspec.yaml
- updates pubspec.lock

## Updating dependencies

To update within allowed version ranges:

```terminal
flutter pub upgrade
```

To see outdated packages:

```terminal
flutter pub outdated
```

## Locking a version (removing ^)

In pubspec.yaml:

From:
```terminal
logger: ^2.0.0
```

To:
```terminal
logger: 2.0.0
```
