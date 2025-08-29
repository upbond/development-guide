# セットアップ完了後のやることリスト 📋

## 🎉 setup.sh 実行お疲れさまでした！

以下の手順に従って、AI駆動開発環境を完全に稼働させましょう。

## ✅ 必須設定

### 1. 環境変数の設定（必要に応じて）
プロジェクトでAPIキーが必要な場合は、.envファイルを作成して設定してください。

### 2. GitHub Secrets の設定
GitHub リポジトリの Settings > Secrets and variables > Actions で以下を設定：

**選択したLLMプロバイダーに応じて：**

#### 🤖 Gemini CLI を選択した場合
- `GEMINI_API_KEY`: [Google AI Studio](https://makersuite.google.com/app/apikey) で取得
- `GOOGLE_CLOUD_PROJECT`: GCPプロジェクトID
- その他のGCP認証情報

#### ⚡ Claude Code を選択した場合
- Claude Code の設定ガイドに従って認証情報を設定
- 参照: https://docs.anthropic.com/ja/docs/claude-code/github-actions

#### 🧠 OpenAI GPT を選択した場合
- `OPENAI_API_KEY`: [OpenAI Platform](https://platform.openai.com/api-keys) で取得

#### 👨‍💻 GitHub Copilot を選択した場合
- GitHub Copilot の契約確認
- IDE での拡張機能インストール

### 3. GitHub Actions の動作確認
```bash
# テスト用Issueを作成して動作確認
# または実際のIssue/PRを作成してAIの反応を確認
```

## 🔧 オプション設定（該当ファイルを作成した場合）

### dev.sh を作成した場合
```bash
# dev.sh の実行権限を確認
chmod +x dev.sh

# 開発環境の起動テスト
./dev.sh
```

## 🚀 AI駆動開発の開始

### 基本的な開発フロー
1. **Issue作成**: GitHub で新しいIssue を作成
2. **AI分析**: 選択したLLMプロバイダーで要件分析
3. **開発**: AI支援でコード実装
4. **テスト**: 自動テスト・レビューの実行
5. **デプロイ**: 継続的インテグレーション

### 推奨する最初のステップ
- [ ] GitHub Actions の動作確認
- [ ] 簡単なIssueを作成してAIの反応をテスト
- [ ] プロジェクト固有のドキュメント作成（README.md、CLAUDE.md等）
- [ ] 開発チームへの導入説明

## 📚 参考リンク

選択したLLMプロバイダーの詳細ドキュメント：
- **Gemini CLI**: https://github.com/google-github-actions/run-gemini-cli
- **Claude Code**: https://docs.anthropic.com/ja/docs/claude-code/github-actions
- **OpenAI**: https://platform.openai.com/docs
- **GitHub Copilot**: https://docs.github.com/copilot

## 🆘 困ったときは

### よくある問題
- **APIキーエラー**: GitHub Secrets の設定を確認
- **権限エラー**: GitHub Token やサービスアカウントの権限を確認
- **ワークフローエラー**: `.github/workflows/` のYAMLファイルの構文を確認

### サポート
- GitHub Issues でバグ報告・質問
- 選択したLLMプロバイダーのサポートドキュメントを参照

---

**🎯 これで準備完了！AI駆動開発をお楽しみください！**