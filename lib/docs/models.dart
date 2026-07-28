import "package:flutter_first_app/docs/builds.dart" show docsBuildCode;

class BadUsageMessage {
  final String id;
  final String prefix;
  final String owner;
  final String message;

  const BadUsageMessage({
    required this.id,
    required this.prefix,
    required this.owner,
    required this.message,
  });

  String get code => docsBuildCode(
    prefix: prefix,
    id: id,
  );

  String warn() {
    return "--------------- [$owner] $message ($code) ---------------";
  }

  @override
  String toString() {
    return "--------------- [$owner] $message ($code) ---------------";
  }
}