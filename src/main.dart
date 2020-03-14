import 'dart:convert';
import 'dart:io' show Platform;
import './runtime.dart';
import './usecase.dart';

void main() {
  lambdaHandler("subscribe", (event) async {
    final uc = new DraftUsecase();
    try {
      final Map<String, dynamic> body = json.decode(event['body']);
      switch (body['type']) {
        case "url_verification":
          if (body['token'] == Platform.environment['TOKEN']) {
            return {
              'statusCode': 200,
              'body': json.encode({'challenge': body['challenge']}),
            };
          } else {
            throw Exception("token does not match");
          }
          break;

        default:
          await uc.run(body.toString());
          return {
            'statusCode': 200,
            'body': json.encode({'msg': 'ok'}),
          };
      }
    } on Exception catch (err) {
      return {
        'statusCode': 400,
        'body': json.encode({'msg': err.toString()}),
      };
    } catch (err, stack) {
      await uc.err(err, stack);
      throw err;
    }
  });
}
