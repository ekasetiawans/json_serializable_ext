import 'package:analyzer/dart/element/type.dart';
import 'package:json_serializable/type_helper.dart';
import 'package:source_gen/source_gen.dart';

const typeChecker = TypeChecker.fromRuntime(bool);

class BoolHelperX extends TypeHelper {
  const BoolHelperX();

  @override
  String serialize(
    DartType targetType,
    String expression,
    TypeHelperContext context,
  ) {
    if (!typeChecker.isAssignableFromType(targetType)) {
      return null;
    }

    return "$expression ? 1 : 0";
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

    return "$expression is bool ? $expression as bool : ($expression != null && ($expression is String && ($expression as String).isNotEmpty && ($expression == 'true' || $expression == '1')) || ($expression is int && ($expression as int) == 1))";
  }
}
