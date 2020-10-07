import 'package:analyzer/dart/element/type.dart';
import 'package:json_serializable/type_helper.dart';
import 'package:source_gen/source_gen.dart';

const typeChecker = TypeChecker.fromRuntime(DateTime);

class DateTimeHelperX extends TypeHelper {
  const DateTimeHelperX();

  @override
  String serialize(
    DartType targetType,
    String expression,
    TypeHelperContext context,
  ) {
    if (!typeChecker.isAssignableFromType(targetType)) {
      return null;
    }

    return "$expression?.toUtc()?.toIso8601String()";
  }

  @override
  String deserialize(
    DartType targetType,
    String expression,
    TypeHelperContext context,
  ) {
    if (!typeChecker.isAssignableFromType(targetType)) {
      return null;
    }

    if (context.nullable) {
      return "$expression == null || ($expression as String).isEmpty ? null : DateTime.parse(($expression as String).length > 10 && !($expression as String).contains('Z') ? $expression + 'Z' : $expression).toLocal()";
    }

    return "DateTime.parse(($expression as String).length > 10 && !($expression as String).contains('Z') ? $expression + 'Z' : $expression)?.toLocal()";
  }
}
