# slack_to_jira
[![serverless](https://github.com/limit7412/slack_to_jira/actions/workflows/serverless-prod.yml/badge.svg?branch=master)](https://github.com/limit7412/slack_to_jira/actions/workflows/serverless-prod.yml)

  - slackに来る問い合わせとかをjiraのタスクに自動で起こすように
  - dart、serverless framework

## 環境変数
```
ALERT_WEBHOOK_URL: 内部エラーのアラート先webhook
SLACK_ID: アラート時のメンション先
SLACK_TOKEN: Event Subscriptionsのtoken
TARGET: この文字列が含まれるとき起票する（メンションなどを指定する想定なので空文字へ置換してしまいます）
JIRA_WORKSPACE: jiraの投稿先
JIRA_PROJECT: プロジェクトのキー
JIRA_USERNAME: ベーシック認証のユーザー
JIRA_TOKEN: ベーシック認証のパスワード
```

### デプロイ
  - deploy.sh
    - slsを利用したデプロイスクリプト
    - 要: docker, sls
  - build.sh
    - slsが使えない環境用で手動アップロードのためにzipを作成
    - 要: docker
