# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is an **AI-driven development guide repository** that provides comprehensive guidelines, workflows, and tools for implementing AI-assisted software development processes. The repository serves as both documentation and a practical implementation framework for teams wanting to adopt AI-driven development practices.

## Key Architecture Components

### 1. Documentation Structure
- **README.md**: Main project overview and quick start guide
- **docs/technical/sample-development-guide.md**: Complete technical implementation guide with dev.sh integration
- **docs/business/business-development-collaboration-guide.md**: Business-focused guide for non-technical stakeholders
- **docs/integration/openai-integration-guide.md**: OpenAI systems integration guide
- **CONTRIBUTING.md**: AI-first contribution guidelines and workflows

### 2. GitHub Integration System
The repository implements a comprehensive GitHub Actions-based AI workflow system:

#### Core Workflows (located in `.github/workflows/`):
- **gemini-cli.yml**: General-purpose AI development assistance via `@gemini-cli` mentions
- **gemini-pr-review.yml**: Automated code review triggered by PR creation or `@gemini-cli /review`
- **gemini-issue-automated-triage.yml**: Real-time issue classification and labeling
- **gemini-issue-scheduled-triage.yml**: Periodic issue management (hourly cron job)

#### Usage Patterns:
```markdown
# In Issues/PRs, use these mention patterns:
@gemini-cli investigate and fix this authentication error
@gemini-cli /review focus on security and performance
@gemini-cli /triage classify this issue
```

### 3. Issue Templates System
Located in `.github/ISSUE_TEMPLATE/`, includes:
- **bug_report.md**: Structured bug reporting with AI integration prompts
- **feature_request.md**: Feature requests optimized for AI assistance
- **documentation.md**: Documentation improvement requests
- **task.md**: General development tasks
- **config.yml**: Template configuration supporting AI-driven workflows

## Development Workflow Philosophy

This repository follows an **AI-first development approach** where:

1. **Issue Creation**: Uses natural language descriptions that AI can parse and act upon
2. **Automatic Triage**: Gemini AI automatically classifies and prioritizes issues
3. **AI-Assisted Development**: Claude Code and other AI tools are primary development aids
4. **Automated Quality Assurance**: Multi-layered AI reviews before human review
5. **Continuous Learning**: AI systems learn from project patterns and improve over time

## Branch Strategy

```
main                           # Production-ready documentation
├── feature/issue-123-*        # New features and enhancements
├── bugfix/issue-124-*         # Bug fixes
├── docs/issue-125-*           # Documentation updates
├── hotfix/issue-126-*         # Critical urgent fixes
└── ai-enhancement/*           # AI tool improvements
```

## Commit Message Convention

```
#<issue-number> <type>: <summary>

<optional detailed description>

AI-assisted: [Claude Code | Gemini CLI | Manual]
Closes #<issue-number>
```

**Types**: `feat`, `fix`, `docs`, `refactor`, `test`, `chore`, `ai-enhance`

## Common Development Commands

### Environment Setup
This repository is documentation-focused, so there's no complex build system, but the following patterns are referenced throughout:

```bash
# If dev.sh exists (referenced in documentation):
chmod +x dev.sh
./dev.sh  # Interactive development environment

# Standard operations:
git clone <repository>
cd development-guide
```

### Testing and Quality Assurance
While this is primarily a documentation repository, it references standardized testing patterns:

```bash
# Lint and format checks (if applicable)
npm run lint        # or equivalent
npm run format      # or equivalent

# Documentation validation
markdown-link-check *.md  # if using markdown link checker
```

### AI Integration Commands
```bash
# Gemini CLI integration (if gemini CLI is installed)
gemini -p 'analyze this repository structure'
gemini -p 'suggest improvements for this documentation'
```

## Working with This Repository

### When Making Changes

1. **Analyze the Full Context**: This repository provides guidance for implementing AI-driven development in other projects. Understand how your changes affect both the guidance provided and real-world implementations.

2. **Maintain Consistency**: The documentation uses consistent terminology:
   - "AI-driven development" (not "AI-assisted" or "AI-powered")  
   - "Issue-driven workflow" for the GitHub-centric approach
   - "Human-AI collaboration" for the development philosophy

3. **Update Related Documents**: Changes to one guide often require updates to related documents:
   - Technical changes: Update docs/technical/sample-development-guide.md
   - Business impact: Update docs/business/business-development-collaboration-guide.md
   - OpenAI integration: Update docs/integration/openai-integration-guide.md
   - Process changes: Update CONTRIBUTING.md
   - Quick reference: Update README.md

### Documentation Standards

- **Mermaid Diagrams**: Extensively used for workflow visualization
- **Emoji Conventions**: Consistent emoji usage for different content types (🤖 for AI, 🚀 for performance, 🛡️ for security)
- **Code Blocks**: Use proper language identifiers (`bash`, `yaml`, `markdown`, etc.)
- **Measurements**: Always provide quantifiable metrics (e.g., "93% faster", "65% cost reduction")

### AI Integration Patterns

When working with this repository, leverage AI tools effectively:

1. **Use @gemini-cli** for issue analysis and feature planning
2. **Use Claude Code** for documentation improvements and technical writing
3. **Document AI usage** in commit messages and PR descriptions
4. **Test AI-generated content** for accuracy and consistency

### Key Architectural Concepts

#### The dev.sh Pattern
Referenced throughout documentation as a standardized development environment script that provides:
- One-command environment setup
- Integrated testing workflows  
- Standardized port configurations (8120, 8121, 8122, 3809)
- CI/CD pipeline simulation

#### GitHub Actions Integration Architecture
The repository documents a comprehensive GitHub Actions system with:
- **Workload Identity Federation** for secure GCP integration
- **Multi-AI tool coordination** (Gemini + Claude Code)
- **Automated issue lifecycle management**
- **Real-time collaboration features**

#### Business-Technical Bridge
Unlike typical technical documentation, this repository explicitly bridges business and technical concerns with:
- **ROI calculations** and financial justifications
- **Non-technical stakeholder guidance**  
- **Change management strategies**
- **Organizational impact assessments**

## Important Context for AI Assistants

1. **This is Meta-Documentation**: You're working on documentation that helps others implement AI-driven development, so consider the recursive nature of AI helping to document AI assistance.

2. **Practical Implementation Focus**: All guidance should be actionable and tested in real-world scenarios, not theoretical.

3. **Community-Driven Evolution**: This repository serves as a living example of AI-driven development practices and should demonstrate continuous improvement.

4. **Cross-Platform Compatibility**: While examples may show Unix-style commands, consider Windows and macOS compatibility in recommendations.

## Communication Language

### Japanese Language Preference
When working with this repository, **use Japanese (日本語) for all communication** including:

- **Issue discussions**: GitHub Issues でのやり取り
- **Pull Request descriptions**: PRの説明や議論
- **Code comments**: 日本語でのコメント記述
- **Commit messages**: 日本語での詳細説明（英語のタイプは保持）
- **Documentation updates**: ドキュメントの更新や追加説明

### Language Guidelines
```markdown
# コミットメッセージ例
#123 feat: 新しい認証システムの実装

新しいOAuth2.0ベースの認証システムを追加しました。
セキュリティ強化と管理者権限の細分化を実現。

AI-assisted: Claude Code
Closes #123
```

### Communication Examples
```markdown
# Issue作成例
@gemini-cli この認証エラーの原因を調査して修正案を提案してください

# PRレビュー依頼例  
@gemini-cli /review セキュリティとパフォーマンスに重点を置いてレビューしてください

# 技術的な相談例
@gemini-cli この機能を実装するための最適なアーキテクチャを日本語で説明してください
```

### Documentation Language Strategy
- **Technical content**: 日本語での詳細な説明を優先
- **Code examples**: 英語のコメント併記も可
- **International audience**: README.mdは英語、詳細ガイドは日本語
- **AI interactions**: 日本語での自然なコミュニケーション

## Quality Standards

- **Accuracy**: All technical details, especially regarding GitHub Actions and API integrations, must be accurate
- **Completeness**: Documentation should be sufficient for implementation without external resources
- **Maintainability**: Structure content so it remains accurate as AI tools and platforms evolve
- **Accessibility**: Write for both technical and non-technical audiences where appropriate
- **Language Consistency**: Use Japanese for detailed discussions while maintaining English for international compatibility