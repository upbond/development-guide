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
    echo "• 🤖 GitHub Actions設定ガイダンス（複数LLMプロバイダー対応）"
    echo "• 📝 Issue/PR テンプレートの自動設置"
    echo "• 🔧 オプション設定ファイルの対話式生成"
    echo "• 📚 AI駆動開発ドキュメントの提供"
    echo ""
    
    echo -e "${BLUE}💡 どんなプロジェクトでも3分でAI駆動開発環境が構築できます${NC}"
    echo ""
    
    # ディレクトリ選択
    select_target_directory
    
    # セットアップ確認
    confirm_setup
    
    # セットアップ実行
    setup_ai_driven_environment
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
    echo "• 🤖 GitHub Actions 設定ガイダンス"
    echo "• 📝 Issue/PR テンプレートの設置"
    echo "• 🔧 オプション設定ファイルの生成"
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
    
    # GitHub設定ファイルをコピー
    setup_github_configuration
    
    # オプション設定ファイル生成の選択
    select_optional_files
    
    
    print_success "AI駆動開発環境のセットアップが完了しました！"
    
    # 次のステップの案内
    print_next_steps
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

# GitHub ディレクトリ構造作成
create_github_structure() {
    print_info "📁 GitHub設定用ディレクトリを作成中..."
    
    # GitHub関連ディレクトリのみ作成
    github_dirs=(
        ".github/ISSUE_TEMPLATE"
        ".github/workflows"
    )
    
    for dir in "${github_dirs[@]}"; do
        mkdir -p "$dir"
        print_success "作成: $dir/"
    done
}

# GitHub設定のセットアップ
setup_github_configuration() {
    print_info "🤖 GitHub Actions設定ガイダンス"
    
    # GitHub ディレクトリ構造作成
    create_github_structure
    
    # テンプレートファイルをコピー
    copy_github_templates
    
    # LLMプロバイダーの選択
    select_llm_provider
    
    # 選択されたプロバイダーに応じたガイダンスを表示
    display_llm_setup_guide
}

# GitHubテンプレートのコピー
copy_github_templates() {
    print_info "📝 GitHub テンプレートを設置中..."
    
    # Issue テンプレートをコピー
    if [[ -d "$SCRIPT_DIR/templates/ISSUE_TEMPLATE" ]]; then
        cp -r "$SCRIPT_DIR/templates/ISSUE_TEMPLATE/"* ".github/ISSUE_TEMPLATE/"
        print_success "Issue テンプレートをコピーしました。"
    else
        print_warning "Issue テンプレートが見つかりません: $SCRIPT_DIR/templates/ISSUE_TEMPLATE"
    fi
    
    # PR テンプレートをコピー
    if [[ -f "$SCRIPT_DIR/templates/pull_request_template.md" ]]; then
        cp "$SCRIPT_DIR/templates/pull_request_template.md" ".github/"
        print_success "PR テンプレートをコピーしました。"
    else
        print_warning "PR テンプレートが見つかりません: $SCRIPT_DIR/templates/pull_request_template.md"
    fi
}

# LLMプロバイダー選択関数
select_llm_provider() {
    print_step "LLMプロバイダーの選択"
    
    echo -e "${CYAN}GitHub Actionsで用いるLLMプロバイダーを選択してください：${NC}\n"
    
    local options=(
        "🤖 Gemini CLI - Google AI による自動化"
        "⚡ Claude Code - Anthropic によるコード生成"  
        "🧠 OpenAI GPT - ChatGPT 統合"
        "👨‍💻 GitHub Copilot - リアルタイムコード補完"
        "🔧 カスタム - 独自のLLMプロバイダー"
    )
    
    PS3="$(echo -e ${YELLOW}"選択してください (番号を入力): "${NC})"
    
    select opt in "${options[@]}"; do
        case $REPLY in
            1)
                SELECTED_LLM_PROVIDER="gemini-cli"
                print_success "選択されたプロバイダー: Gemini CLI"
                break
                ;;
            2)
                SELECTED_LLM_PROVIDER="claude-code"
                print_success "選択されたプロバイダー: Claude Code"
                break
                ;;
            3)
                SELECTED_LLM_PROVIDER="openai-gpt"
                print_success "選択されたプロバイダー: OpenAI GPT"
                break
                ;;
            4)
                SELECTED_LLM_PROVIDER="github-copilot"
                print_success "選択されたプロバイダー: GitHub Copilot"
                break
                ;;
            5)
                SELECTED_LLM_PROVIDER="custom"
                print_success "選択されたプロバイダー: カスタム"
                break
                ;;
            *)
                print_warning "無効な選択です。1-5の番号を入力してください。"
                ;;
        esac
    done
}

# LLM設定ガイド表示関数
display_llm_setup_guide() {
    print_step "🤖 $SELECTED_LLM_PROVIDER 設定ガイド"
    
    case "$SELECTED_LLM_PROVIDER" in
        "gemini-cli")
            display_gemini_cli_guide
            ;;
        "claude-code")
            display_claude_code_guide
            ;;
        "openai-gpt")
            display_openai_gpt_guide
            ;;
        "github-copilot")
            display_github_copilot_guide
            ;;
        "custom")
            display_custom_llm_guide
            ;;
    esac
}

# Gemini CLI設定ガイド
display_gemini_cli_guide() {
    echo -e "${GREEN}🤖 Gemini CLI 設定ガイド${NC}\n"
    
    echo -e "${CYAN}Gemini CLI GitHub Actions を設定するには以下の手順に従ってください：${NC}\n"
    
    echo "1. 📋 公式テンプレートの参照:"
    echo -e "   ${YELLOW}https://github.com/google-github-actions/run-gemini-cli${NC}"
    echo ""
    
    echo "2. 🔧 必要なファイル設定:"
    echo "   • GitHub Actions ワークフローファイル"
    echo "   • Issue/PR テンプレート"
    echo "   • 環境変数とシークレット"
    echo ""
    
    echo "3. 🗝️  必要なシークレット:"
    echo "   • GEMINI_API_KEY"
    echo "   • GOOGLE_CLOUD_PROJECT"
    echo "   • その他のGCP認証情報"
    echo ""
    
    echo -e "${BLUE}💡 詳細な設定手順は上記URLで最新情報を確認してください。${NC}\n"
}

# Claude Code設定ガイド
display_claude_code_guide() {
    echo -e "${GREEN}⚡ Claude Code 設定ガイド${NC}\n"
    
    echo -e "${CYAN}Claude Code GitHub Actions を設定するには以下の手順に従ってください：${NC}\n"
    
    echo "1. 📋 公式GitHub Actions ガイドの参照:"
    echo -e "   ${YELLOW}https://docs.anthropic.com/ja/docs/claude-code/github-actions${NC}"
    echo ""
    
    echo "2. 🌐 Claude Code へのアクセス:"
    echo -e "   ${YELLOW}https://claude.ai/code${NC}"
    echo ""
    
    echo "3. 🔧 必要なファイル設定:"
    echo "   • GitHub Actions ワークフローファイル"
    echo "   • Issue/PR テンプレート"
    echo "   • Claude Code 統合設定"
    echo ""
    
    echo "4. 🤝 GitHub 統合機能:"
    echo "   • GitHub Issues での自動分析"
    echo "   • PR作成・レビューの自動化"
    echo "   • リアルタイムコード生成・修正"
    echo ""
    
    echo -e "${BLUE}💡 詳細な設定手順は上記URLで最新情報を確認してください。${NC}\n"
}

# OpenAI GPT設定ガイド
display_openai_gpt_guide() {
    echo -e "${GREEN}🧠 OpenAI GPT 設定ガイド${NC}\n"
    
    echo -e "${CYAN}ChatGPT API を使用したGitHub Actions：${NC}\n"
    
    echo "1. 🔑 API キーの取得:"
    echo -e "   ${YELLOW}https://platform.openai.com/api-keys${NC}"
    echo ""
    
    echo "2. 🤖 GitHub Actions設定例:"
    echo "   • openai/gpt-action などのアクションを使用"
    echo "   • カスタムワークフローの作成"
    echo ""
    
    echo "3. 🗝️  必要なシークレット:"
    echo "   • OPENAI_API_KEY"
    echo "   • その他の設定値"
    echo ""
    
    echo -e "${BLUE}💡 コミュニティ作成のアクションを参考に設定してください。${NC}\n"
}

# GitHub Copilot設定ガイド
display_github_copilot_guide() {
    echo -e "${GREEN}👨‍💻 GitHub Copilot 設定ガイド${NC}\n"
    
    echo -e "${CYAN}GitHub Copilot の活用：${NC}\n"
    
    echo "1. 💳 GitHub Copilot の有効化:"
    echo "   • GitHub アカウントでCopilot を契約"
    echo "   • IDE でCopilot 拡張機能をインストール"
    echo ""
    
    echo "2. 🔧 IDE統合:"
    echo "   • VS Code、IntelliJ IDEA などでの使用"
    echo "   • リアルタイムコード補完"
    echo ""
    
    echo "3. 🤖 GitHub Actions との連携:"
    echo "   • Copilot Chat での自動化相談"
    echo "   • コードレビューでの活用"
    echo ""
    
    echo -e "${BLUE}💡 GitHub Copilot は主にIDE内での使用がメインです。${NC}\n"
}

# カスタムLLM設定ガイド
display_custom_llm_guide() {
    echo -e "${GREEN}🔧 カスタムLLM 設定ガイド${NC}\n"
    
    echo -e "${CYAN}独自のLLMプロバイダーを使用する場合：${NC}\n"
    
    echo "1. 📝 GitHub Actions ワークフローの作成:"
    echo "   • .github/workflows/ にYAMLファイルを作成"
    echo "   • カスタムAPIとの統合"
    echo ""
    
    echo "2. 🔐 認証とシークレット:"
    echo "   • 必要なAPIキーをGitHub Secretsに設定"
    echo "   • 適切なアクセス権限の設定"
    echo ""
    
    echo "3. 🧪 テストと検証:"
    echo "   • ワークフローの動作確認"
    echo "   • エラーハンドリングの実装"
    echo ""
    
    echo -e "${BLUE}💡 GitHub Actions のドキュメントを参考に独自の統合を構築してください。${NC}\n"
}


# オプション設定ファイル生成の選択
select_optional_files() {
    print_step "追加設定ファイルの選択"
    
    echo -e "${CYAN}どの設定ファイルを作成しますか？（複数選択可能）${NC}\n"
    
    echo -e "${YELLOW}以下から作成したいファイルを選択してください：${NC}"
    
    local files_to_create=()
    
    # .gitignore
    if ask_yes_no "📁 .gitignore を作成しますか？"; then
        files_to_create+=("gitignore")
    fi
    
    # dev.sh
    if ask_yes_no "🚀 dev.sh (開発スクリプト) を作成しますか？"; then
        files_to_create+=("devsh")
    fi
    
    # SETUP_GUIDE.md
    if ask_yes_no "📋 SETUP_GUIDE.md (セットアップガイド) を作成しますか？"; then
        files_to_create+=("setupguide")
    fi
    
    # sample-development-guide.md
    if ask_yes_no "📚 sample-development-guide.md (開発者向け詳細ガイド) を作成しますか？"; then
        files_to_create+=("devguide")
    fi
    
    echo ""
    print_info "選択されたファイルを生成中..."
    
    # 選択されたファイルを生成
    for file in "${files_to_create[@]}"; do
        case "$file" in
            "gitignore")
                generate_gitignore_safe
                ;;
            "devsh")
                generate_dev_script_safe
                ;;
            "setupguide")
                copy_setup_guide
                ;;
            "devguide")
                copy_dev_guide
                ;;
        esac
    done
    
    if [[ ${#files_to_create[@]} -eq 0 ]]; then
        print_info "追加設定ファイルはスキップされました。"
    else
        print_success "選択されたファイルの生成が完了しました。"
    fi
}

# Yes/No 質問関数
ask_yes_no() {
    local question="$1"
    while true; do
        echo -e "${YELLOW}$question (y/n): ${NC}"
        read -r response
        case "$response" in
            [Yy]*)
                return 0  # Yes
                ;;
            [Nn]*)
                return 1  # No
                ;;
            *)
                print_warning "y または n で回答してください。"
                ;;
        esac
    done
}

# 既存ファイルの上書き確認関数
confirm_file_overwrite() {
    local file_path="$1"
    local file_name="$2"
    
    if [[ -f "$file_path" ]]; then
        echo -e "${YELLOW}⚠️  既存の '$file_name' が見つかりました。${NC}"
        echo -e "${YELLOW}上書きしますか？ (y/n/d): ${NC}"
        echo "  y: 上書きする"
        echo "  n: スキップする"
        echo "  d: 差分を表示して判断する"
        
        read -r choice
        case "$choice" in
            [Yy]*)
                return 0  # 上書きする
                ;;
            [Dd]*)
                if command -v diff &> /dev/null; then
                    echo -e "${CYAN}現在のファイルと新しいファイルの差分:${NC}"
                    # 一時ファイルを作成して差分表示（実装は簡略化）
                    echo "（差分表示機能は実装を簡略化しています）"
                fi
                echo -e "${YELLOW}上書きしますか？ (y/n): ${NC}"
                read -r choice2
                [[ "$choice2" =~ ^[Yy]$ ]] && return 0 || return 1
                ;;
            *)
                return 1  # スキップする
                ;;
        esac
    else
        return 0  # ファイルが存在しないので作成する
    fi
}

# .gitignore生成（安全版）
generate_gitignore_safe() {
    if [[ -f ".gitignore" ]]; then
        echo -e "${YELLOW}⚠️  既存の '.gitignore' が見つかりました。${NC}"
        echo -e "${YELLOW}どうしますか？ (m/o/c): ${NC}"
        echo "  m: AI開発用エントリを既存ファイルに追加する"
        echo "  o: 完全に上書きする"
        echo "  c: スキップする"
        
        read -r choice
        case "$choice" in
            [Mm]*)
                merge_gitignore
                ;;
            [Oo]*)
                generate_gitignore
                ;;
            *)
                print_info "スキップ: .gitignore"
                ;;
        esac
    else
        generate_gitignore
    fi
}

# .gitignore にAI開発用エントリを追加
merge_gitignore() {
    print_info "AI開発用エントリを既存の.gitignoreに追加中..."
    
    # AI開発ツール用のエントリを追加
    cat >> .gitignore << 'EOF'

# AI開発ツール（setup.shによる追加）
.claude/
.copilot/
.ai-cache/

# 環境変数ファイル
.env
.env.local
.env.development
.env.production
.env.test
EOF
    
    print_success "AI開発用エントリを.gitignoreに追加しました。"
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



# dev.sh スクリプトテンプレート生成（安全版）
generate_dev_script_safe() {
    if confirm_file_overwrite "dev.sh" "dev.sh"; then
        generate_dev_script
    else
        print_info "スキップ: dev.sh"
    fi
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

# SETUP_GUIDE.md のコピーと動的置換
copy_setup_guide() {
    if [[ -f "$SCRIPT_DIR/templates/SETUP_GUIDE.md" ]]; then
        if confirm_file_overwrite "SETUP_GUIDE.md" "SETUP_GUIDE.md"; then
            # テンプレートをコピーして動的置換を実行
            sed "s/\[SELECTED_LLM_PROVIDER\]/$SELECTED_LLM_PROVIDER/g" "$SCRIPT_DIR/templates/SETUP_GUIDE.md" > "SETUP_GUIDE.md"
            print_success "コピー: SETUP_GUIDE.md (選択されたLLMプロバイダー: $SELECTED_LLM_PROVIDER)"
        else
            print_info "スキップ: SETUP_GUIDE.md"
        fi
    else
        print_warning "SETUP_GUIDE.mdテンプレートが見つかりません: $SCRIPT_DIR/templates/SETUP_GUIDE.md"
    fi
}

# sample-development-guide.md のコピーと動的追記
copy_dev_guide() {
    if [[ -f "$SCRIPT_DIR/templates/sample-development-guide.md" ]]; then
        if confirm_file_overwrite "sample-development-guide.md" "sample-development-guide.md"; then
            # ベースファイルをコピー
            cp "$SCRIPT_DIR/templates/sample-development-guide.md" "./"
            
            # 選択されたLLMプロバイダーに応じてコンテンツを追記
            if [[ "$SELECTED_LLM_PROVIDER" == "gemini-cli" ]]; then
                # Gemini CLI固有の内容を追記
                if [[ -f "$SCRIPT_DIR/templates/gemini-cli-addon.md" ]]; then
                    # プレースホルダーの位置にGemini CLI固有の内容を挿入
                    sed -i.bak '/<!-- AI_PROVIDER_SPECIFIC_CONTENT_PLACEHOLDER -->/r '$SCRIPT_DIR'/templates/gemini-cli-addon.md' sample-development-guide.md
                    # プレースホルダーを削除
                    sed -i.bak '/<!-- AI_PROVIDER_SPECIFIC_CONTENT_PLACEHOLDER -->/d' sample-development-guide.md
                    # バックアップファイルを削除
                    rm sample-development-guide.md.bak
                    print_success "コピー: sample-development-guide.md (Gemini CLI統合版)"
                else
                    print_success "コピー: sample-development-guide.md (標準版)"
                fi
            else
                # 他のプロバイダーの場合はプレースホルダーを削除
                sed -i.bak '/<!-- AI_PROVIDER_SPECIFIC_CONTENT_PLACEHOLDER -->/d' sample-development-guide.md
                rm sample-development-guide.md.bak
                print_success "コピー: sample-development-guide.md (標準版)"
            fi
        else
            print_info "スキップ: sample-development-guide.md"
        fi
    else
        print_warning "sample-development-guide.mdテンプレートが見つかりません: $SCRIPT_DIR/templates/sample-development-guide.md"
    fi
}

# 次のステップの案内
print_next_steps() {
    echo ""
    echo -e "${BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║                                                              ║${NC}"
    echo -e "${BLUE}║                    🚀 次のステップ                           ║${NC}"
    echo -e "${BLUE}║                                                              ║${NC}"
    echo -e "${BLUE}╚══════════════════════════════════════════════════════════════╝${NC}\n"
    
    echo -e "${GREEN}🎉 プロジェクトにAI駆動開発用のテンプレートファイルが作成されました！${NC}\n"
    
    if [[ -f "SETUP_GUIDE.md" ]]; then
        echo -e "${CYAN}📋 次の作業には SETUP_GUIDE.md を活用してください：${NC}"
        echo ""
        echo -e "${YELLOW}💡 AI駆動開発を最適化するためのヒント：${NC}"
        echo "1. SETUP_GUIDE.md の内容をClaude CodeやChatGPTに共有"
        echo "2. あなたのプロジェクトの詳細と合わせて相談"
        echo "3. プロジェクト固有の設定をAIに最適化してもらう"
        echo ""
        echo -e "${GREEN}例: 「このSETUP_GUIDE.mdの内容を見て、私のTypeScriptプロジェクトを${NC}"
        echo -e "${GREEN}     AI駆動開発に最適化してください」${NC}"
        echo ""
    else
        echo -e "${YELLOW}📋 SETUP_GUIDE.md を作成していない場合：${NC}"
        echo "SETUP_GUIDE.md には次のステップの詳細が記載されています。"
        echo "必要に応じてsetup.shを再実行してSETUP_GUIDE.mdを作成してください。"
        echo ""
    fi
    
    if [[ -f "sample-development-guide.md" ]]; then
        echo -e "${BLUE}📚 sample-development-guide.md が作成されました：${NC}"
        echo "• AI駆動開発の詳細な実装例とベストプラクティス"
        echo "• dev.sh統合開発環境の完全活用ガイド"
        echo "• Gemini CLI GitHub Actions システムの詳細"
        echo "• 開発チームへの教育・導入資料として活用可能"
        echo ""
    fi
    
    echo -e "${BLUE}🤖 AI駆動開発の準備ができました！${NC}"
    echo -e "${BLUE}選択したLLMプロバイダー: ${YELLOW}$SELECTED_LLM_PROVIDER${NC}"
    echo ""
    
    echo -e "${PURPLE}次にやること：${NC}"
    echo "• GitHub Secrets でAPIキーを設定"
    echo "• 最初のIssue/PRを作成してAIの動作を確認"
    echo "• Claude Code、Gemini CLI、ChatGPTなどでプロジェクトを最適化"
    echo ""
    
    print_success "Happy AI-Driven Development! 🚀🤖"
}


# エラーハンドリング
trap 'print_error "セットアップ中にエラーが発生しました。"; exit 1' ERR

# メイン実行
main "$@"