
class LoggingTrace {
  final StackTrace _trace;

  LoggingTrace(StackTrace trace) : _trace = trace {
    _parseTrace();
  }

  late String fileName;
  late int column;
  late int line;

  void _parseTrace() {
    final traceString = _trace.toString().split('\n')[3];
    var indexOfFileName = traceString.indexOf(RegExp(r'[A-Za-z_]+.dart'));
    var fileInfoString = traceString.substring(indexOfFileName);
    var fileInfo = fileInfoString.split(":");
    fileName = fileInfo[0];
    line = int.parse(fileInfo[1]);
    var columnStr = fileInfo[2];
    columnStr = columnStr.replaceFirst(")", "");
    column = int.parse(columnStr);
  }

  @override
  String toString() {
    return "file name = $fileName, column = $column, line = $line";
  }
}