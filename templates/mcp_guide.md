# MCP (Model Context Protocol) 統合ガイド 🔗

## 概要

MCP (Model Context Protocol) は、AI アプリケーションとデータソースやツールとの間の標準化された接続を提供するプロトコルです。このガイドでは、AI駆動開発環境でMCPを活用してLLMツールの機能を拡張する方法を説明します。

## 🤖 MCPとは

MCPを使用することで、AI開発ツールが以下のようなリソースに安全にアクセスできるようになります：

- **📁 ファイルシステム**: プロジェクトファイルの読み書き
- **🌐 Web API**: 外部サービスとの統合
- **🗄️ データベース**: データの取得・更新
- **🛠️ 開発ツール**: Git、Docker、テストフレームワークなど
- **📊 監視システム**: ログ、メトリクス、アラート

## 🚀 AI駆動開発でのMCP活用

### Claude Code + MCP
```bash
# Claude Code は自動的にMCPサーバーを検出
# プロジェクトルートにmcp.jsonを配置
```

### OpenAI Codex + MCP
```bash
# Codex CLI でMCPサーバーを設定
codex config add-mcp-server <server-name> <server-config>
```

### Cursor IDE + MCP
```bash
# Cursor の設定でMCPサーバーを有効化
# .cursor/mcp.json で設定
```

## 📋 プロジェクト固有のMCP設定

### 1. プロジェクト情報アクセス
```json
{
  "mcpServers": {
    "project-info": {
      "command": "node",
      "args": ["./scripts/mcp-project-server.js"],
      "env": {
        "PROJECT_ROOT": "."
      }
    }
  }
}
```

### 2. データベース統合
```json
{
  "mcpServers": {
    "database": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-postgres"],
      "env": {
        "POSTGRES_CONNECTION_STRING": "${DATABASE_URL}"
      }
    }
  }
}
```

### 3. GitHub API統合
```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "${GITHUB_TOKEN}"
      }
    }
  }
}
```

### 4. Web検索統合
```json
{
  "mcpServers": {
    "web-search": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-brave-search"],
      "env": {
        "BRAVE_API_KEY": "${BRAVE_API_KEY}"
      }
    }
  }
}
```

## 🛠️ プロジェクト用MCPサーバーの実装例

### scripts/mcp-project-server.js
```javascript
#!/usr/bin/env node

const { Server } = require('@modelcontextprotocol/sdk/server/index.js');
const { StdioServerTransport } = require('@modelcontextprotocol/sdk/server/stdio.js');
const fs = require('fs');
const path = require('path');

class ProjectMCPServer {
  constructor() {
    this.server = new Server(
      {
        name: 'project-info-server',
        version: '1.0.0',
      },
      {
        capabilities: {
          resources: {},
          tools: {},
        },
      }
    );

    this.setupResourceHandlers();
    this.setupToolHandlers();
  }

  setupResourceHandlers() {
    this.server.setRequestHandler('resources/list', async () => {
      return {
        resources: [
          {
            uri: 'project://package.json',
            name: 'Package Configuration',
            description: 'プロジェクトの依存関係と設定',
            mimeType: 'application/json',
          },
          {
            uri: 'project://structure',
            name: 'Project Structure',
            description: 'プロジェクトのディレクトリ構造',
            mimeType: 'text/plain',
          },
        ],
      };
    });

    this.server.setRequestHandler('resources/read', async (request) => {
      const uri = request.params.uri;
      
      if (uri === 'project://package.json') {
        const packagePath = path.join(process.cwd(), 'package.json');
        if (fs.existsSync(packagePath)) {
          const content = fs.readFileSync(packagePath, 'utf8');
          return {
            contents: [
              {
                uri,
                mimeType: 'application/json',
                text: content,
              },
            ],
          };
        }
      }
      
      if (uri === 'project://structure') {
        const structure = this.getProjectStructure();
        return {
          contents: [
            {
              uri,
              mimeType: 'text/plain',
              text: structure,
            },
          ],
        };
      }
      
      throw new Error(`Unknown resource: ${uri}`);
    });
  }

  setupToolHandlers() {
    this.server.setRequestHandler('tools/list', async () => {
      return {
        tools: [
          {
            name: 'run_tests',
            description: 'プロジェクトのテストスイートを実行',
            inputSchema: {
              type: 'object',
              properties: {
                pattern: {
                  type: 'string',
                  description: 'テストファイルパターン（例: *auth*）',
                },
                coverage: {
                  type: 'boolean',
                  description: 'カバレッジレポートを生成するか',
                },
              },
            },
          },
          {
            name: 'build_project',
            description: 'プロジェクトをビルド',
            inputSchema: {
              type: 'object',
              properties: {
                mode: {
                  type: 'string',
                  enum: ['development', 'production'],
                  description: 'ビルドモード',
                },
              },
            },
          },
        ],
      };
    });

    this.server.setRequestHandler('tools/call', async (request) => {
      const { name, arguments: args } = request.params;
      
      if (name === 'run_tests') {
        return this.runTests(args);
      }
      
      if (name === 'build_project') {
        return this.buildProject(args);
      }
      
      throw new Error(`Unknown tool: ${name}`);
    });
  }

  getProjectStructure() {
    // 簡略化された実装
    return 'プロジェクト構造の取得...';
  }

  async runTests(args) {
    // テスト実行の実装
    return {
      content: [
        {
          type: 'text',
          text: `テスト実行完了: パターン=${args.pattern || 'all'}`,
        },
      ],
    };
  }

  async buildProject(args) {
    // ビルド実行の実装
    return {
      content: [
        {
          type: 'text',
          text: `ビルド完了: モード=${args.mode || 'development'}`,
        },
      ],
    };
  }

  async run() {
    const transport = new StdioServerTransport();
    await this.server.connect(transport);
  }
}

if (require.main === module) {
  const server = new ProjectMCPServer();
  server.run().catch(console.error);
}
```

## 🔧 設定手順

### 1. MCP設定ファイルの作成

**Claude Code 用 (mcp.json):**
```json
{
  "mcpServers": {
    "project-info": {
      "command": "node",
      "args": ["./scripts/mcp-project-server.js"]
    },
    "filesystem": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-filesystem", "."]
    },
    "github": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "${GITHUB_TOKEN}"
      }
    }
  }
}
```

**Cursor IDE 用 (.cursor/mcp.json):**
```json
{
  "mcpServers": {
    "project-tools": {
      "command": "node",
      "args": ["./scripts/mcp-project-server.js"]
    }
  }
}
```

### 2. 依存関係のインストール

```bash
# MCP SDK のインストール
npm install @modelcontextprotocol/sdk

# 公式MCPサーバーのインストール（必要に応じて）
npm install -g @modelcontextprotocol/server-filesystem
npm install -g @modelcontextprotocol/server-github
npm install -g @modelcontextprotocol/server-postgres
```

### 3. 環境変数の設定

```bash
# .env ファイルに追加
GITHUB_TOKEN=your_github_token_here
DATABASE_URL=postgresql://user:pass@localhost:5432/dbname
BRAVE_API_KEY=your_brave_api_key_here
```

## 🎯 AI駆動開発でのMCP活用例

### シナリオ1: プロジェクト分析
```markdown
# AIへの指示例
「MCPを使ってこのプロジェクトの構造を分析し、
 改善点を提案してください」

# MCPが提供する情報:
- package.json の依存関係
- ディレクトリ構造
- 既存のテストファイル
- GitHub Issues/PRの履歴
```

### シナリオ2: 自動テスト実行
```markdown
# AIへの指示例
「認証機能のテストを実行して、
 結果を分析してください」

# MCPツールの実行:
- run_tests(pattern: "*auth*")
- テスト結果の解析
- 失敗原因の特定
- 修正提案の生成
```

### シナリオ3: データベース連携
```markdown
# AIへの指示例
「ユーザーテーブルのスキーマを確認し、
 新しいフィールド追加のマイグレーションを作成してください」

# MCPデータベースサーバーが提供:
- 現在のスキーマ情報
- テーブル関係性
- インデックス情報
- マイグレーション履歴
```

## 📚 利用可能なMCPサーバー

### 公式MCPサーバー
- **@modelcontextprotocol/server-filesystem** - ファイルシステムアクセス
- **@modelcontextprotocol/server-github** - GitHub API統合
- **@modelcontextprotocol/server-postgres** - PostgreSQL統合
- **@modelcontextprotocol/server-sqlite** - SQLite統合
- **@modelcontextprotocol/server-brave-search** - Web検索

### 推奨サードパーティMCPサーバー

#### 🌟 SERENA MCP (おすすめ)
**概要**: AI開発に特化した包括的なMCPサーバーセット。開発ワークフロー、プロジェクト管理、コード分析などの機能を統合的に提供します。

**主な機能:**
- **🔍 プロジェクト解析**: ファイル構造、依存関係、技術スタックの自動分析
- **🧪 テスト統合**: 複数のテストフレームワーク対応
- **🚀 デプロイ支援**: CI/CD パイプラインとの連携
- **📊 メトリクス収集**: 開発効率とコード品質の測定
- **🔐 セキュリティスキャン**: 脆弱性検出とセキュリティ推奨事項

**公式サイト**: https://serena-mcp.dev  
**GitHub**: https://github.com/serena-mcp/serena-mcp

**インストール:**
```bash
npm install -g serena-mcp
```

**設定例:**
```json
{
  "mcpServers": {
    "serena": {
      "command": "serena-mcp",
      "args": ["--project-root", "."],
      "env": {
        "GITHUB_TOKEN": "${GITHUB_TOKEN}",
        "PROJECT_TYPE": "web-application"
      }
    }
  }
}
```

### カスタムMCPサーバー開発
```javascript
// 独自のMCPサーバーを開発してプロジェクト固有の機能を提供
class CustomProjectMCPServer {
  // プロジェクト固有のリソースとツールを定義
  // 例: デプロイメント、監視、分析など
}
```

## 🔐 セキュリティ考慮事項

### 1. 権限管理
```json
{
  "mcpServers": {
    "read-only-fs": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-filesystem", ".", "--read-only"]
    }
  }
}
```

### 2. 機密情報の保護
```bash
# .env ファイルでAPIキーを管理
# MCPサーバーには環境変数経由でのみアクセス許可
MCP_ALLOWED_PATHS="./src,./docs,./tests"
MCP_FORBIDDEN_PATHS="./.env,./.git,./node_modules"
```

### 3. ネットワークアクセス制限
```json
{
  "mcpServers": {
    "restricted-web": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-web"],
      "env": {
        "ALLOWED_DOMAINS": "api.github.com,docs.example.com"
      }
    }
  }
}
```

## 🎯 ベストプラクティス

### 1. プロジェクト構造
```
project/
├── mcp.json                    # Claude Code用MCP設定
├── .cursor/mcp.json           # Cursor IDE用MCP設定  
├── scripts/
│   └── mcp-project-server.js  # カスタムMCPサーバー
├── .env                       # 環境変数
└── .env.example              # 環境変数テンプレート
```

### 2. 段階的導入
```bash
# Phase 1: 基本的なファイルアクセス
{
  "mcpServers": {
    "filesystem": { /* 設定 */ }
  }
}

# Phase 2: GitHub統合
{
  "mcpServers": {
    "filesystem": { /* 設定 */ },
    "github": { /* 設定 */ }
  }
}

# Phase 3: フル統合
{
  "mcpServers": {
    "filesystem": { /* 設定 */ },
    "github": { /* 設定 */ },
    "database": { /* 設定 */ },
    "project-tools": { /* 設定 */ }
  }
}
```

### 3. エラーハンドリング
```javascript
// MCPサーバーでの適切なエラーハンドリング
try {
  const result = await executeCommand(args);
  return { success: true, result };
} catch (error) {
  return { 
    success: false, 
    error: error.message,
    troubleshooting: "設定ファイルとAPIキーを確認してください"
  };
}
```

## 🔗 参考リンク

- **[MCP 公式ドキュメント](https://modelcontextprotocol.io/docs)** - プロトコルの詳細仕様
- **[MCP GitHub リポジトリ](https://github.com/modelcontextprotocol)** - 公式実装とサンプル
- **[Claude Code MCP ガイド](https://docs.anthropic.com/claude/docs/mcp)** - Claude Code での使用方法
- **[MCP サーバー一覧](https://github.com/modelcontextprotocol/servers)** - 利用可能なサーバー

## 🚀 次のステップ

1. **MCPサーバーの選択**: プロジェクトに必要な機能を特定
2. **設定ファイルの作成**: mcp.json または .cursor/mcp.json
3. **環境変数の設定**: APIキーとアクセス権限
4. **動作確認**: AI開発ツールでMCP機能をテスト
5. **カスタムサーバー開発**: プロジェクト固有の機能実装

---

**🎯 MCPを活用して、AI開発ツールの可能性を最大限に引き出しましょう！**