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
