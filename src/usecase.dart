import 'dart:io' show Platform;
import './repository.dart';
import './models.dart';

class DraftUsecase {
  DraftUsecase();

  Future<void> run(String text) async {
    // final queue = new SearchQueueRepository();
    // await queue.putQueue(text, userID, channelID);
    final slack = new SlackRepository(Platform.environment['WEBHOOK_URL']);

    await slack.sendPost([new SlackPost('', 'test', '', text, '', '')]);
  }

  Future<void> err(err, StackTrace stack) async {
    final slack =
        new SlackRepository(Platform.environment['ALERT_WEBHOOK_URL']);
    final fallback = 'エラーみたい…確認してみよっか';

    await slack.sendPost([
      new SlackPost(
          fallback,
          '<@${Platform.environment['SLACK_ID']}> ${fallback}',
          err.toString(),
          stack.toString(),
          '#EB4646',
          'slack_to_jira')
    ]);
  }
}
