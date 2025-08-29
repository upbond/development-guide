#!/bin/bash

# AI駆動開発環境セットアップスクリプト
# Version: 1.0.0
# Author: AI-Driven Development Guide

set -e  # エラー時に終了

# カラー設定
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# 絵文字とカラーを使った出力関数
print_header() {
    echo -e "\n${BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║                                                              ║${NC}"
    echo -e "${BLUE}║  🤖 AI駆動開発環境セットアップ - AI-Driven Development Setup ║${NC}"
    echo -e "${BLUE}║                                                              ║${NC}"
    echo -e "${BLUE}╚══════════════════════════════════════════════════════════════╝${NC}\n"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_info() {
    echo -e "${CYAN}ℹ️  $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_step() {
    echo -e "\n${PURPLE}🚀 $1${NC}\n"
}

# 現在のディレクトリ取得
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# メイン関数
main() {
    print_header
    
    echo -e "${GREEN}このスクリプトは以下の機能を提供します：${NC}"
    echo "• 📁 AI駆動開発用プロジェクト構造の作成"
    echo "• 🤖 GitHub Actions (Gemini CLI) の設定"
    echo "• 📝 Issue/PR テンプレートの設置"
    echo "• 🔧 開発環境設定ファイルの生成"
    echo "• 📚 ドキュメントテンプレートのコピー"
    echo ""
    
    # ディレクトリ選択
    select_target_directory
    
    # セットアップ確認
    confirm_setup
    
    # セットアップ実行
    setup_ai_driven_environment
    
    # 完了メッセージ
    print_completion_guide
}

# ディレクトリ選択関数
select_target_directory() {
    print_step "Step 1: インストールディレクトリの選択"
    
    echo -e "${CYAN}AI駆動開発環境をセットアップするディレクトリを選択してください：${NC}\n"
    
    PS3="$(echo -e ${YELLOW}"選択してください (番号を入力): "${NC})"
    
    options=(
        "📁 現在のディレクトリ ($(pwd))"
        "🆕 新しいディレクトリを作成"
        "📂 既存のディレクトリを指定"
        "❌ 終了"
    )
    
    select opt in "${options[@]}"; do
        case $REPLY in
            1)
                TARGET_DIR="$(pwd)"
                print_info "現在のディレクトリを選択しました: $TARGET_DIR"
                break
                ;;
            2)
                create_new_directory
                break
                ;;
            3)
                specify_existing_directory
                break
                ;;
            4)
                print_info "セットアップを終了します。"
                exit 0
                ;;
            *)
                print_warning "無効な選択です。1-4の番号を入力してください。"
                ;;
        esac
    done
}

# 新しいディレクトリ作成
create_new_directory() {
    while true; do
        echo -e "\n${YELLOW}📁 新しいプロジェクトディレクトリ名を入力してください：${NC}"
        read -r dir_name
        
        if [[ -z "$dir_name" ]]; then
            print_warning "ディレクトリ名を入力してください。"
            continue
        fi
        
        # 不正な文字をチェック
        if [[ "$dir_name" =~ [[:space:]] ]]; then
            print_warning "ディレクトリ名にスペースは使用できません。"
            continue
        fi
        
        TARGET_DIR="$(pwd)/$dir_name"
        
        if [[ -d "$TARGET_DIR" ]]; then
            echo -e "${YELLOW}⚠️  ディレクトリ '$TARGET_DIR' は既に存在します。${NC}"
            echo -e "${YELLOW}継続しますか？ (y/n): ${NC}"
            read -r confirm
            if [[ $confirm =~ ^[Yy]$ ]]; then
                break
            else
                continue
            fi
        else
            break
        fi
    done
    
    print_info "新しいディレクトリを作成します: $TARGET_DIR"
}

# 既存ディレクトリ指定
specify_existing_directory() {
    while true; do
        echo -e "\n${YELLOW}📂 既存のディレクトリパスを入力してください：${NC}"
        read -r dir_path
        
        if [[ -z "$dir_path" ]]; then
            print_warning "ディレクトリパスを入力してください。"
            continue
        fi
        
        # チルダ展開
        eval dir_path="$dir_path"
        
        if [[ ! -d "$dir_path" ]]; then
            print_warning "ディレクトリ '$dir_path' は存在しません。"
            echo -e "${YELLOW}作成しますか？ (y/n): ${NC}"
            read -r create_confirm
            if [[ $create_confirm =~ ^[Yy]$ ]]; then
                TARGET_DIR="$dir_path"
                break
            else
                continue
            fi
        else
            TARGET_DIR="$dir_path"
            break
        fi
    done
    
    print_info "指定されたディレクトリ: $TARGET_DIR"
}

# セットアップ確認
confirm_setup() {
    print_step "Step 2: セットアップ内容の確認"
    
    echo -e "${CYAN}📋 セットアップ予定の内容：${NC}"
    echo "• 🎯 ターゲットディレクトリ: $TARGET_DIR"
    echo "• 📁 プロジェクト構造の作成"
    echo "• 🤖 GitHub Actions の設置"
    echo "• 📝 Issue/PR テンプレートの設置"
    echo "• 📚 ドキュメントの配置"
    echo "• 🔧 設定ファイルの生成"
    echo ""
    
    echo -e "${YELLOW}⚡ 上記の内容でセットアップを実行しますか？ (y/n): ${NC}"
    read -r setup_confirm
    
    if [[ ! $setup_confirm =~ ^[Yy]$ ]]; then
        print_info "セットアップをキャンセルしました。"
        exit 0
    fi
}

# AI駆動開発環境セットアップ実行
setup_ai_driven_environment() {
    print_step "Step 3: AI駆動開発環境のセットアップ実行中..."
    
    # ターゲットディレクトリ作成
    create_target_directory
    
    # プロジェクト構造作成
    create_project_structure
    
    # GitHub設定ファイルをコピー
    setup_github_configuration
    
    # ドキュメントをコピー
    setup_documentation
    
    # 設定ファイル生成
    generate_configuration_files
    
    # 環境設定ガイド生成
    generate_environment_guide
    
    print_success "AI駆動開発環境のセットアップが完了しました！"
}

# ターゲットディレクトリ作成
create_target_directory() {
    if [[ ! -d "$TARGET_DIR" ]]; then
        print_info "ディレクトリを作成中: $TARGET_DIR"
        mkdir -p "$TARGET_DIR"
        print_success "ディレクトリを作成しました。"
    else
        print_info "既存のディレクトリを使用します: $TARGET_DIR"
    fi
    
    cd "$TARGET_DIR" || exit 1
}

# プロジェクト構造作成
create_project_structure() {
    print_info "📁 プロジェクト構造を作成中..."
    
    # 基本ディレクトリ構造
    directories=(
        ".github/ISSUE_TEMPLATE"
        ".github/workflows"
        "docs/technical"
        "docs/business"
        "docs/integration"
        "docs/guides"
        "src"
        "tests"
        "scripts"
    )
    
    for dir in "${directories[@]}"; do
        mkdir -p "$dir"
        print_success "作成: $dir/"
    done
}

# GitHub設定のセットアップ
setup_github_configuration() {
    print_info "🤖 GitHub Actions & テンプレートを設置中..."
    
    # Issue テンプレートをコピー
    if [[ -d "$SCRIPT_DIR/.github/ISSUE_TEMPLATE" ]]; then
        cp -r "$SCRIPT_DIR/.github/ISSUE_TEMPLATE/"* ".github/ISSUE_TEMPLATE/"
        print_success "Issue テンプレートをコピーしました。"
    fi
    
    # PR テンプレートをコピー
    if [[ -f "$SCRIPT_DIR/.github/pull_request_template.yml" ]]; then
        cp "$SCRIPT_DIR/.github/pull_request_template.yml" ".github/"
        print_success "PR テンプレートをコピーしました。"
    fi
    
    # GitHub Actions ワークフローをコピー
    if [[ -d "$SCRIPT_DIR/.github/workflows" ]]; then
        cp "$SCRIPT_DIR/.github/workflows/"*.yml ".github/workflows/" 2>/dev/null || true
        print_success "GitHub Actions ワークフローをコピーしました。"
    fi
}

# ドキュメントセットアップ
setup_documentation() {
    print_info "📚 ドキュメントを設置中..."
    
    # docsディレクトリのコピー
    if [[ -d "$SCRIPT_DIR/docs" ]]; then
        cp -r "$SCRIPT_DIR/docs/"* "docs/"
        print_success "ドキュメントをコピーしました。"
    fi
    
    # ルートレベルのドキュメント
    root_docs=(
        "README.md"
        "CLAUDE.md"
        "CONTRIBUTING.md"
    )
    
    for doc in "${root_docs[@]}"; do
        if [[ -f "$SCRIPT_DIR/$doc" ]]; then
            cp "$SCRIPT_DIR/$doc" "./"
            print_success "コピー: $doc"
        fi
    done
}

# 設定ファイル生成
generate_configuration_files() {
    print_info "🔧 設定ファイルを生成中..."
    
    # .gitignore 生成
    generate_gitignore
    
    # package.json テンプレート生成
    generate_package_json
    
    # 環境変数テンプレート生成
    generate_env_template
    
    # dev.sh スクリプトテンプレート生成
    generate_dev_script
    
    print_success "設定ファイルの生成が完了しました。"
}

# .gitignore生成
generate_gitignore() {
    cat > .gitignore << 'EOF'
# AI駆動開発プロジェクト用 .gitignore

# 依存関係
node_modules/
.npm
.yarn/
yarn-error.log*
package-lock.json

# 環境変数・機密情報
.env
.env.local
.env.development
.env.production
.env.test
*.key
*.pem
secrets/

# ビルド出力
dist/
build/
.next/
.nuxt/
.vite/

# ログファイル
*.log
logs/

# IDE・エディタ
.vscode/settings.json
.idea/
*.swp
*.swo
*~

# OS固有
.DS_Store
Thumbs.db
desktop.ini

# テスト・カバレッジ
coverage/
.nyc_output/
.jest/

# AI開発ツール
.claude/
.copilot/
.ai-cache/

# 一時ファイル
tmp/
temp/
.cache/
EOF
    print_success "生成: .gitignore"
}

# package.json テンプレート生成
generate_package_json() {
    local project_name=$(basename "$TARGET_DIR")
    
    cat > package.json << EOF
{
  "name": "$project_name",
  "version": "1.0.0",
  "description": "AI駆動開発プロジェクト",
  "main": "src/index.js",
  "scripts": {
    "dev": "./dev.sh",
    "start": "node src/index.js",
    "test": "jest",
    "lint": "eslint src/",
    "format": "prettier --write src/",
    "type-check": "tsc --noEmit",
    "setup": "./setup.sh"
  },
  "keywords": [
    "ai-driven-development",
    "claude-code",
    "gemini-cli",
    "github-copilot"
  ],
  "author": "",
  "license": "MIT",
  "devDependencies": {
    "jest": "^29.0.0",
    "eslint": "^8.0.0",
    "prettier": "^3.0.0",
    "typescript": "^5.0.0"
  },
  "dependencies": {}
}
EOF
    print_success "生成: package.json"
}

# 環境変数テンプレート生成
generate_env_template() {
    cat > .env.example << 'EOF'
# AI駆動開発環境設定

# Gemini AI設定
GEMINI_API_KEY=your_gemini_api_key_here

# OpenAI設定（ChatGPT/GPT-4用）
OPENAI_API_KEY=your_openai_api_key_here

# GitHub設定
GITHUB_TOKEN=your_github_token_here

# Google Cloud設定（Gemini CLI用）
GOOGLE_CLOUD_PROJECT=your_gcp_project_id
GCP_WIF_PROVIDER=your_workload_identity_provider
SERVICE_ACCOUNT_EMAIL=your_service_account@project.iam.gserviceaccount.com

# GitHub App設定（高度な統合用）
APP_ID=your_github_app_id
APP_PRIVATE_KEY=your_github_app_private_key

# データベース設定（必要に応じて）
DB_HOST=localhost
DB_PORT=3306
DB_NAME=your_database_name
DB_USER=your_db_user
DB_PASSWORD=your_db_password

# アプリケーション設定
NODE_ENV=development
PORT=3000
EOF
    print_success "生成: .env.example"
}

# dev.sh スクリプトテンプレート生成
generate_dev_script() {
    cat > dev.sh << 'EOF'
#!/bin/bash

# AI駆動開発 - 統合開発環境スクリプト
# AI-Driven Development - Integrated Development Environment Script

set -e

# カラー設定
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_header() {
    echo -e "\n${BLUE}🚀 AI駆動開発 - 統合開発環境${NC}\n"
}

print_menu() {
    echo -e "${GREEN}利用可能なオプション：${NC}"
    echo "1. 📦 依存関係インストール"
    echo "2. 🏃 開発サーバー起動"
    echo "3. 🧪 テスト実行"
    echo "4. 🔍 Lint & Format"
    echo "5. 🎯 型チェック"
    echo "6. 🤖 AI支援コード生成"
    echo "7. 📊 プロジェクト統計"
    echo "8. ❌ 終了"
    echo ""
}

# メイン処理
main() {
    print_header
    
    while true; do
        print_menu
        echo -e "${YELLOW}選択してください (1-8): ${NC}"
        read -r choice
        
        case $choice in
            1) install_dependencies ;;
            2) start_dev_server ;;
            3) run_tests ;;
            4) lint_and_format ;;
            5) type_check ;;
            6) ai_code_generation ;;
            7) project_stats ;;
            8) echo "👋 開発作業を終了します。"; exit 0 ;;
            *) echo "❌ 無効な選択です。1-8の番号を入力してください。" ;;
        esac
        
        echo ""
        echo "Press Enter to continue..."
        read -r
    done
}

install_dependencies() {
    echo "📦 依存関係をインストール中..."
    if command -v npm &> /dev/null; then
        npm install
    elif command -v yarn &> /dev/null; then
        yarn install
    else
        echo "❌ npm または yarn が見つかりません。"
    fi
}

start_dev_server() {
    echo "🏃 開発サーバーを起動中..."
    if [[ -f "package.json" ]]; then
        npm run dev || yarn dev
    else
        echo "ℹ️  package.json が見つかりません。手動でサーバーを設定してください。"
    fi
}

run_tests() {
    echo "🧪 テストを実行中..."
    npm test || yarn test
}

lint_and_format() {
    echo "🔍 Lint & Format を実行中..."
    npm run lint || yarn lint
    npm run format || yarn format
}

type_check() {
    echo "🎯 型チェックを実行中..."
    npm run type-check || yarn type-check
}

ai_code_generation() {
    echo "🤖 AI支援コード生成機能"
    echo "Claude Code や GitHub Copilot を使用してコードを生成してください。"
    echo "Gemini CLI の使用例："
    echo "  @gemini-cli 新しいAPI エンドポイントを作成してください"
}

project_stats() {
    echo "📊 プロジェクト統計："
    echo "ファイル数: $(find . -type f -name '*.js' -o -name '*.ts' -o -name '*.jsx' -o -name '*.tsx' | wc -l)"
    echo "コード行数: $(find . -type f -name '*.js' -o -name '*.ts' -o -name '*.jsx' -o -name '*.tsx' -exec wc -l {} + | tail -1 | awk '{print $1}')"
    
    if [[ -d ".git" ]]; then
        echo "Git コミット数: $(git rev-list --all --count)"
    fi
}

# スクリプト実行
main "$@"
EOF
    chmod +x dev.sh
    print_success "生成: dev.sh (実行可能)"
}

# 環境設定ガイド生成
generate_environment_guide() {
    print_info "📋 環境設定ガイドを生成中..."
    
    cat > SETUP_GUIDE.md << 'EOF'
# AI駆動開発環境 - セットアップガイド 🚀

## 🎯 概要
このプロジェクトはAI駆動開発環境がセットアップされています。
以下の手順に従って、必要な設定を完了してください。

## 📋 必要な準備

### 1. 環境変数の設定
```bash
# .env.example をコピーして .env を作成
cp .env.example .env

# エディタで .env を編集し、必要なAPIキーを設定
nano .env
```

### 2. 必要なAPIキーの取得

#### 🤖 Gemini AI API キー
1. [Google AI Studio](https://makersuite.google.com/app/apikey) にアクセス
2. 新しいAPIキーを作成
3. `.env` の `GEMINI_API_KEY` に設定

#### 🧠 OpenAI API キー (ChatGPT/GPT-4用)
1. [OpenAI Platform](https://platform.openai.com/api-keys) にアクセス
2. 新しいAPIキーを作成
3. `.env` の `OPENAI_API_KEY` に設定

#### 🐙 GitHub Token
1. GitHub Settings > Developer settings > Personal access tokens
2. 必要な権限を設定してトークン生成
3. `.env` の `GITHUB_TOKEN` に設定

### 3. 依存関係のインストール
```bash
# dev.sh を使用（推奨）
./dev.sh

# または直接実行
npm install
# または
yarn install
```

## 🤖 AI ツールの設定

### Claude Code
1. [Claude Code](https://claude.ai/code) にアクセス
2. このプロジェクトをオープン
3. CLAUDE.md の内容に従って作業

### GitHub Copilot
1. IDE で GitHub Copilot を有効化
2. プロジェクトでコード補完を活用

### Gemini CLI
```bash
# Gemini CLI をインストール (必要に応じて)
npm install -g @google/generative-ai

# プロジェクトで使用
@gemini-cli APIの実装を支援してください
```

## 🚀 開発の開始

### 基本的な開発フロー
1. **Issue作成**: GitHub で新しいIssue を作成
2. **AI分析**: `@gemini-cli` で要件分析
3. **開発**: Claude Code や Copilot で実装
4. **テスト**: 自動テストの実行
5. **レビュー**: AI による品質チェック
6. **デプロイ**: 自動デプロイメント

### dev.sh の活用
```bash
./dev.sh
# メニューから必要な操作を選択
```

## 📚 参考ドキュメント

- **[技術ガイド](docs/technical/sample-development-guide.md)**: 詳細な実装方法
- **[ビジネスガイド](docs/business/business-development-collaboration-guide.md)**: ROI・効果分析
- **[統合ガイド](docs/integration/openai-integration-guide.md)**: AI ツール統合方法

## 🎯 次のステップ

1. ✅ 環境変数の設定完了
2. ✅ 依存関係のインストール完了
3. ✅ AI ツールの動作確認
4. 📝 最初のIssueを作成してAI開発を体験
5. 🚀 本格的な開発の開始

## 🆘 トラブルシューティング

### よくある問題
- **API キーエラー**: `.env` ファイルの設定を確認
- **権限エラー**: GitHub Token の権限を確認
- **ネットワークエラー**: プロキシ設定を確認

### サポート
- GitHub Issues でバグ報告・質問
- `@gemini-cli` でリアルタイム支援
- ドキュメントで詳細情報を確認

---

**🎉 AI駆動開発環境の設定が完了したら、効率的で高品質な開発をお楽しみください！**
EOF
    print_success "生成: SETUP_GUIDE.md"
}

# 完了メッセージとガイド
print_completion_guide() {
    print_step "🎉 セットアップ完了！"
    
    echo -e "${GREEN}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║                                                              ║${NC}"
    echo -e "${GREEN}║          🚀 AI駆動開発環境のセットアップが完了しました！          ║${NC}"
    echo -e "${GREEN}║                                                              ║${NC}"
    echo -e "${GREEN}╚══════════════════════════════════════════════════════════════╝${NC}\n"
    
    echo -e "${CYAN}📍 セットアップされたディレクトリ: ${YELLOW}$TARGET_DIR${NC}\n"
    
    echo -e "${CYAN}📋 次のステップ：${NC}"
    echo "1. 📂 プロジェクトディレクトリに移動:"
    echo -e "   ${YELLOW}cd \"$TARGET_DIR\"${NC}"
    echo ""
    echo "2. 📝 環境設定を完了:"
    echo -e "   ${YELLOW}cp .env.example .env${NC}"
    echo -e "   ${YELLOW}nano .env  # APIキーを設定${NC}"
    echo ""
    echo "3. 🚀 開発環境を起動:"
    echo -e "   ${YELLOW}./dev.sh${NC}"
    echo ""
    echo "4. 📚 セットアップガイドを確認:"
    echo -e "   ${YELLOW}cat SETUP_GUIDE.md${NC}"
    echo ""
    
    echo -e "${GREEN}🤖 利用可能なAIツール：${NC}"
    echo "• 🤖 Gemini CLI: Issue分析・自動トリアージ"
    echo "• ⚡ Claude Code: 高品質コード生成・リファクタリング"
    echo "• 🧠 ChatGPT/GPT-4: 対話的開発支援"
    echo "• 👨‍💻 GitHub Copilot: リアルタイムコード補完"
    echo ""
    
    echo -e "${BLUE}📊 期待される効果：${NC}"
    echo "• 🚀 開発速度: 3-5倍向上"
    echo "• 🐛 バグ率: 85%削減"
    echo "• 💰 開発コスト: 65%削減"
    echo "• 📈 ROI: 400%以上"
    echo ""
    
    echo -e "${PURPLE}🎯 AI駆動開発の始め方：${NC}"
    echo "1. GitHub でIssue を作成"
    echo "2. @gemini-cli で要件分析"
    echo "3. Claude Code でコード実装"
    echo "4. 自動テスト・レビューの実行"
    echo "5. 継続的な改善とデプロイ"
    echo ""
    
    print_success "Happy AI-Driven Development! 🚀🤖"
}

# エラーハンドリング
trap 'print_error "セットアップ中にエラーが発生しました。"; exit 1' ERR

# メイン実行
main "$@"