import 'dart:io' show Platform;
import './repository.dart';
import './models.dart';

class DraftUsecase {
  DraftUsecase();

  Future<void> run(String text) async {
    final description = text
        .replaceAll(Platform.environment['TARGET'], '')
        .replaceAll(RegExp(r'\<.*?\>'), '');
    final summary =
        description.length > 40 ? description.substring(0, 40) : description;

    final jira = new JiraRepository();
    final isSuccess = await jira.createTask(new JiraTask(
        Platform.environment['JIRA_PROJECT'], summary, description));

    if (!isSuccess) {
      throw 'faild to create task.';
    }
  }

  Future<void> err(err, StackTrace stack) async {
    final slack =
        new SlackRepository(Platform.environment['ALERT_WEBHOOK_URL']);
    final fallback = 'Warning! An internal error has occurred!';

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
