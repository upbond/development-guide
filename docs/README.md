# AI駆動開発ガイド - ドキュメント一覧 📚

このディレクトリには、AI駆動開発に関する包括的なドキュメントが整理されています。

## 📂 ディレクトリ構造

```
docs/
├── README.md                    # このファイル（ナビゲーション）
├── technical/                   # 技術者向けドキュメント
│   └── sample-development-guide.md
├── business/                    # ビジネス関係者向けドキュメント
│   └── business-development-collaboration-guide.md
├── integration/                 # AI統合・連携ガイド
│   └── openai-integration-guide.md
└── guides/                      # その他ガイド・チュートリアル
    └── (今後追加予定)
```

## 🎯 読み方ガイド

### 👨‍💼 **ビジネス関係者の方**
1. **[ビジネス×開発連携ガイド](business/business-development-collaboration-guide.md)** 📊
   - AI駆動開発のビジネス価値とROI
   - 非技術者向けの開発フロー解説
   - 投資判断のための財務分析

### 👨‍💻 **技術者・開発者の方**
1. **[開発技術ガイド](technical/sample-development-guide.md)** 🔧
   - 具体的な実装手順とdev.sh活用法
   - GitHub Actions統合システム
   - Gemini CLI活用パターン

2. **[OpenAI統合ガイド](integration/openai-integration-guide.md)** 🤖
   - ChatGPT/GPT-4との連携方法
   - GitHub Copilot統合活用
   - Claude Codeとの協働パターン

### 🎓 **AI駆動開発を学びたい方**
推奨読書順序：
1. ビジネス×開発連携ガイド（概要理解）
2. 開発技術ガイド（実践的な実装方法）
3. OpenAI統合ガイド（高度な統合技術）

## 🤖 各AIツールの役割分担

| ツール | 主な用途 | 参照ドキュメント |
|--------|---------|----------------|
| **🤖 Gemini CLI** | Issue分類・自動トリアージ | [開発技術ガイド](technical/sample-development-guide.md) |
| **⚡ Claude Code** | コード生成・品質保証 | 全ドキュメント |
| **🧠 ChatGPT/GPT-4** | 対話的開発支援 | [OpenAI統合ガイド](integration/openai-integration-guide.md) |
| **👨‍💻 GitHub Copilot** | リアルタイム補完 | [OpenAI統合ガイド](integration/openai-integration-guide.md) |

## 📈 効果・メトリクス

### 開発効率向上
- **開発速度**: 従来比3-5倍
- **品質向上**: バグ率85%削減  
- **コスト削減**: 65%の開発コスト削減

### ROI（投資対効果）
- **統合AI活用**: ROI 829%
- **投資回収期間**: 1.3ヶ月
- **年間削減効果**: 3,900万円

詳細な数値は各ドキュメントをご参照ください。

## 🚀 クイックスタート

### 1. **今すぐ始めたい方**
```bash
# リポジトリクローン
git clone https://github.com/upbond/development-guide.git
cd development-guide

# 開発環境起動（dev.shがある場合）
./dev.sh
```

### 2. **Issue作成でAI支援を体験**
```markdown
# GitHub Issueでの基本的な使い方
@gemini-cli この認証エラーを調査して修正してください
@gemini-cli /review セキュリティに重点を置いてレビューしてください
```

### 3. **AI協働開発の実践**
1. Issue作成 → AI自動トリアージ
2. AI支援コード生成 → 品質チェック
3. 自動レビュー → 人間最終承認
4. 自動デプロイ → Issue自動クローズ

## 🤝 コントリビューション

このドキュメントの改善にご協力ください：

1. **誤字・脱字の修正**
2. **実践例の追加**
3. **新しいAIツール統合事例**
4. **成功事例・失敗事例の共有**

詳細は [CONTRIBUTING.md](../CONTRIBUTING.md) をご覧ください。

## 📞 サポート・質問

- **GitHub Issues**: バグ報告・機能要求
- **GitHub Discussions**: 一般的な質問・議論
- **AI支援**: `@gemini-cli` でIssue内で質問
- **Email**: development-guide@upbond.io

## 🔗 関連リンク

- **[Claude Code](https://claude.ai/code)** - AI coding assistant
- **[GitHub Actions](https://github.com/features/actions)** - CI/CD automation  
- **[Gemini AI](https://deepmind.google/technologies/gemini/)** - Google's AI model
- **[OpenAI](https://openai.com/)** - ChatGPT/GPT-4 provider

---

**🎯 AI駆動開発で、開発効率と品質の両方を劇的に向上させましょう！**