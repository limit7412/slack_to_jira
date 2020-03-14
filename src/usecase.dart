import 'dart:io' show Platform;
import './repository.dart';
import './models.dart';

class DraftUsecase {
  DraftUsecase();

  Future<void> run(String text) async {
    final jira = new JiraRepository();

    final isSuccess = await jira.createTask(
        new JiraTask(Platform.environment['JIRA_PROJECT'], text, text));

    if (isSuccess) {
      final slack = new SlackRepository(Platform.environment['WEBHOOK_URL']);
      await slack.sendPost([new SlackPost('', '課題を作成しました', '', '', '', '')]);
    } else {
      throw 'faild to create task.';
    }
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
