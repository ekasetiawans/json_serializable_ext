import 'package:build/build.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:json_serializable_ext/bool_helper.dart';
import 'package:json_serializable_ext/double_helper.dart';
import 'package:json_serializable_ext/int_helper.dart';
import 'package:json_serializable_ext/string_helper.dart';
import 'package:source_gen/source_gen.dart';
import 'package:json_serializable/json_serializable.dart';

import 'date_time_helper.dart';

/// Supports `package:build_runner` creation and configuration of
/// `json_serializable`.
///
/// Not meant to be invoked by hand-authored code.
Builder jsonSerializable(BuilderOptions options) {
  try {
    final config = JsonSerializable.fromJson(options.config);
    return SharedPartBuilder([
      JsonSerializableGenerator.withDefaultHelpers(
        const [
          DateTimeHelperX(),
          IntHelperX(),
          DoubleHelperX(),
          StringHelperX(),
          BoolHelperX(),
        ],
        config: config,
      ),
      const JsonLiteralGenerator()
    ], 'json_serializable');
  } on CheckedFromJsonException catch (e) {
    final lines = <String>[
      'Could not parse the options provided for `json_serializable`.'
    ];

    if (e.key != null) {
      lines.add('There is a problem with "${e.key}".');
    }
    if (e.message != null) {
      lines.add(e.message);
    } else if (e.innerError != null) {
      lines.add(e.innerError.toString());
    }

    throw StateError(lines.join('\n'));
  }
}
