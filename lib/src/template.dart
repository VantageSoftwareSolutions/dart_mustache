import '../mustache.dart';
import 'node.dart';
import 'parser.dart' as parser;
import 'renderer.dart';

/// A Template can be efficiently rendered multiple times with different
/// values.
class Template {
  /// The constructor parses the template source and throws [TemplateException]
  /// if the syntax of the source is invalid.
  /// Tag names may only contain characters a-z, A-Z, 0-9, underscore, and minus,
  /// unless lenient mode is specified.
  Template(
    this.source, {
    this.lenient = false,
    this.htmlEscapeValues = true,
    this.name,
    this.partialResolver,
    this.rendererBuilder,
    String delimiters = '{{ }}',
  }) : nodes = parser.parse(source, lenient, name, delimiters);

  final String source;
  final List<Node> nodes;
  final bool lenient;
  final bool htmlEscapeValues;
  final String? name;
  final PartialResolver? partialResolver;
  final Renderer Function()? rendererBuilder;

  /// [values] can be a combination of Map, List, String. Any non-String object
  /// will be converted using toString(). Null values will cause a
  /// [TemplateException], unless lenient module is enabled.
  String renderString(values) {
    var buf = StringBuffer();
    render(values, buf);
    return buf.toString();
  }

  /// [values] can be a combination of Map, List, String. Any non-String object
  /// will be converted using toString(). Null values will cause a
  /// [TemplateException], unless lenient module is enabled.
  void render(values, StringSink sink) {
    var renderer = rendererBuilder?.call() ?? Renderer(sink, [values], lenient, htmlEscapeValues, partialResolver, name, '', source);
    renderer.render(nodes);
  }
}
