import 'dart:convert';
import 'dart:io' show Platform;
import './runtime.dart';
import './usecase.dart';

void main() {
  lambdaHandler("subscribe", (event) async {
    final uc = new DraftUsecase();
    try {
      final Map<String, dynamic> body = json.decode(event['body']);
      if (body['token'] != Platform.environment['SLACK_TOKEN']) {
        throw Exception("token does not match");
      }

      switch (body['type']) {
        case "url_verification":
          return {
            'statusCode': 200,
            'headers': {
              'Content-Type': 'text/plain',
            },
            'body': body['challenge'],
          };
          break;

        case "event_callback":
          if (body['event']['text'].contains(Platform.environment['TARGET']) &&
              body['event']['thread_ts'] == null) {
            await uc.run(body['event']['text']);
          }
          break;
      }

      return {
        'statusCode': 200,
        'headers': {
          'Content-Type': 'application/json',
        },
        'body': json.encode({'msg': 'ok'}),
      };
    } on Exception catch (err) {
      return {
        // NOTE: It is set to 200 to display Response in the console of slack API
        'statusCode': 200,
        'headers': {
          'Content-Type': 'application/json',
        },
        'body': json.encode({'msg': err.toString()}),
      };
    } catch (err, stack) {
      await uc.err(err, stack);
      throw err;
    }
  });

  lambdaHandler("echo", (event) async {
    final uc = new DraftUsecase();
    try {
      return {
        'statusCode': 200,
        'headers': {
          'Content-Type': 'application/json',
        },
        'body': event['body'],
      };
    } catch (err, stack) {
      await uc.err(err, stack);
      throw err;
    }
  });
}
