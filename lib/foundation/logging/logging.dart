import 'dart:developer';
import 'logging_trace.dart';

enum LoggingLevel {
  verbose,
  debug,
  info,
  warning,
  error,
}

LoggingLevel loggingLevel = LoggingLevel.verbose;
void setLoggingLevel(LoggingLevel level) {
  loggingLevel = level;
}

const int verboseValue = 0;
const int debugValue = 400;
const int infoValue = 800;
const int warningValue = 900;
const int errorValue = 1200;

extension LoggingLevelValue on LoggingLevel {
  int get value {
    switch (this) {
      case LoggingLevel.verbose:
        return verboseValue;
      case LoggingLevel.debug:
        return debugValue;
      case LoggingLevel.info:
        return infoValue;
      case LoggingLevel.warning:
        return warningValue;
      case LoggingLevel.error:
        return errorValue;
    }
  }

  String get prefix {
    switch (this) {
      case LoggingLevel.verbose:
        return '[🟣 Verbose]';
      case LoggingLevel.debug:
        return '[🔵 Debug]';
      case LoggingLevel.info:
        return '[🟢 Info]';
      case LoggingLevel.warning:
        return '[🟡 Warning]';
      case LoggingLevel.error:
        return '[🔴 Error]';
    }
  }
}

verbose(String message, {String? tag, Object? error}) {
  if (loggingLevel.value >= verboseValue) {
    return;
  }

  _log(message, LoggingLevel.verbose, tag, error);
}

debug(String message, {String? tag, Object? error}) {
  if (loggingLevel.value >= debugValue) {
    return;
  }

  _log(message, LoggingLevel.debug, tag, error);
}

info(String message, {String? tag, Object? error}) {
  if (loggingLevel.value >= infoValue) {
    return;
  }

  _log(message, LoggingLevel.info, tag, error);
}

warning(String message, {String? tag, Object? error}) {
  if (loggingLevel.value >= warningValue) {
    return;
  }

  _log(message, LoggingLevel.warning, tag, error);
}

error(String message, {String? tag, Object? error}) {
  if (loggingLevel.value >= errorValue) {
    return;
  }

  _log(message, LoggingLevel.error, tag, error);
}

_log(String message, LoggingLevel level, String? tag, Object? error) {
  assert(
    () {
      String name = '${DateTime.now()} ${level.prefix}';

      final stackTrace = StackTrace.current;

      final loggingTrace = LoggingTrace(stackTrace);
      name += ' ${loggingTrace.fileName} ⁃ line:${loggingTrace.line}';

      if (tag != null) {
        name += ' [🔹tag: $tag🔹]';
      }

      log(
        message,
        level: level.value,
        name: name,
        error: error,
        stackTrace: (error != null) ? stackTrace : null,
      );
      return true;
    }(),
  );
}
