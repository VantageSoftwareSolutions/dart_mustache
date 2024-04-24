import 'src/lambda_context.dart';
import 'src/template.dart';

export 'src/lambda_context.dart';
export 'src/template.dart';
export 'src/template_exception.dart';

typedef PartialResolver = Template? Function(String);

typedef LambdaFunction = Object Function(LambdaContext context);
