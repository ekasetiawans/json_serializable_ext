import 'package:analyzer/dart/element/type.dart';
import 'package:json_serializable/type_helper.dart';
import 'package:source_gen/source_gen.dart';

const typeChecker = TypeChecker.fromRuntime(double);

class DoubleHelperX extends TypeHelper {
  const DoubleHelperX();

  @override
  String serialize(
    DartType targetType,
    String expression,
    TypeHelperContext context,
  ) {
    if (!typeChecker.isAssignableFromType(targetType)) {
      return null;
    }

    return "$expression";
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

    return "$expression != null && $expression is String && ($expression as String).isNotEmpty ? num.tryParse($expression as String).toDouble() : ($expression as num)?.toDouble()";
  }
}
