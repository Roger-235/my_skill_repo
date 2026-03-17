# Claude Code Skill Library

A personal skill library for [Claude Code](https://claude.ai/code). Skills are markdown instructions that tell Claude when and how to perform specific tasks automatically.

## 使用方式

將需要的 skill 資料夾複製到目標專案的 `.claude/skill/<category>/` 目錄下即可啟用：

```bash
cp -r skill/dev/quality/code-review /your-project/.claude/skill/dev/quality/
```

## 目錄結構

```
skill/
├── business/
│   ├── c-suite/       28 skills（CEO/CFO/CTO advisor、strategic tools）
│   ├── marketing/     43 skills（SEO、CRO、content、social、paid ads）
│   ├── product/       13 skills（strategy、discovery、analytics、design）
│   ├── finance/       2 skills（financial-analyst、saas-metrics-coach）
│   ├── compliance/    12 skills（FDA、GDPR、ISO 13485/27001、MDR）
│   ├── project-mgmt/  6 skills（Jira、Confluence、Atlassian、scrum）
│   └── growth/        4 skills（contract、customer success、rev ops、sales）
├── data/              db-schema · financial-modeling · market-research
├── design/            ui-ux-pro-max
├── dev/
│   ├── quality/       code-review · code-quality · refactor · debug · build-fix
│   ├── patterns/      typescript · python · go · react
│   ├── testing/       tdd-guide · webapp-testing · playwright-pro
│   ├── infra/         docker-patterns · git-workflow · mcp-maker · auto-mcp
│   ├── agents/        agent-designer · agent-workflow-designer · rag-architect · autoresearch-agent
│   ├── architecture/  aws-solution-architect · senior-architect · tech-stack-evaluator · interview-system-designer
│   ├── api/           api-design-reviewer · api-test-suite-builder · database-designer · database-schema-designer
│   ├── frontend/      epic-design · senior-frontend
│   ├── backend/       senior-backend · senior-fullstack · stripe-integration-expert
│   ├── data-ml/       senior-data-engineer · senior-data-scientist · senior-ml-engineer · senior-computer-vision · senior-prompt-engineer
│   ├── workspace/     email-template-builder · google-workspace-cli · ms365-tenant-manager · incident-commander
│   ├── productivity/  codebase-onboarding · git-worktree-manager · monorepo-navigator · performance-profiler · migration-architect
│   └── release/       changelog-generator · release-manager · runbook-generator
├── meta/
│   ├── skill-system/  skill-design · skill-maker · skill-edit · skill-audit
│   │                  skill-readme-sync · skill-index-sync · skill-library-lint
│   └── session/       task-planner · checkpoint-recovery · continuous-learning
│                      token-optimizer · pre-output-review
├── ops/               ci-cd-pipeline · deploy-ops
├── security/          security-audit
└── writing/           article-writing · content-engine
```

每個 category 資料夾包含：
- `_index.md` — 該類別所有 skill 的快速索引
- `<category>-guide/` — 路由導覽 skill（「我該用哪個 skill？」時觸發）
- `<skill-name>/SKILL.md` + `README.md`

## 可用 Skill

### business
| Subcategory | Skills |
|-------------|--------|
| c-suite | ceo-advisor · cfo-advisor · cto-advisor · cmo-advisor · coo-advisor · cpo-advisor · cro-advisor · chro-advisor · ciso-advisor · chief-of-staff · executive-mentor · founder-coach · board-deck-builder · board-meeting · agent-protocol · change-management · company-os · competitive-intel · context-engine · cs-onboard · culture-architect · decision-logger · internal-narrative · intl-expansion · ma-playbook · org-health-diagnostic · scenario-war-room · strategic-alignment |
| marketing | seo-audit · ai-seo · programmatic-seo · schema-markup · site-architecture · content-strategy · content-production · content-creator · content-humanizer · copywriting · copy-editing · cold-email · email-sequence · social-media-manager · social-content · social-media-analyzer · x-twitter-growth · paid-ads · ad-creative · brand-guidelines · marketing-strategy-pmm · marketing-demand-acquisition · marketing-ops · campaign-analytics · analytics-tracking · marketing-psychology · marketing-ideas · marketing-context · launch-strategy · page-cro · form-cro · onboarding-cro · signup-flow-cro · paywall-upgrade-cro · popup-cro · ab-test-setup · churn-prevention · referral-program · free-tool-strategy · competitor-alternatives · pricing-strategy · app-store-optimization · prompt-engineer-toolkit |
| product | product-strategist · product-manager-toolkit · agile-product-owner · product-discovery · product-analytics · roadmap-communicator · ux-researcher-designer · competitive-teardown · research-summarizer · experiment-designer · saas-scaffolder · landing-page-generator · ui-design-system |
| finance | financial-analyst · saas-metrics-coach |
| compliance | fda-consultant-specialist · gdpr-dsgvo-expert · quality-manager-qms-iso13485 · information-security-manager-iso27001 · risk-management-specialist · capa-officer · isms-audit-expert · mdr-745-specialist · qms-audit-expert · quality-documentation-manager · quality-manager-qmr · regulatory-affairs-head |
| project-mgmt | jira-expert · confluence-expert · atlassian-admin · atlassian-templates · scrum-master · senior-pm-enterprise |
| growth | contract-and-proposal-writer · customer-success-manager · revenue-operations · sales-engineer |

### dev
| Subcategory | Skills |
|-------------|--------|
| quality | code-review · code-quality · refactor · debug · build-fix |
| patterns | typescript-patterns · python-patterns · go-patterns · react-patterns |
| testing | tdd-guide · webapp-testing · playwright-pro |
| infra | docker-patterns · git-workflow · mcp-maker · auto-mcp |
| agents | agent-designer · agent-workflow-designer · rag-architect · autoresearch-agent |
| architecture | aws-solution-architect · senior-architect · tech-stack-evaluator · interview-system-designer |
| api | api-design-reviewer · api-test-suite-builder · database-designer · database-schema-designer |
| frontend | epic-design · senior-frontend |
| backend | senior-backend · senior-fullstack · stripe-integration-expert |
| data-ml | senior-data-engineer · senior-data-scientist · senior-ml-engineer · senior-computer-vision · senior-prompt-engineer |
| workspace | email-template-builder · google-workspace-cli · ms365-tenant-manager · incident-commander |
| productivity | codebase-onboarding · git-worktree-manager · monorepo-navigator · performance-profiler · migration-architect |
| release | changelog-generator · release-manager · runbook-generator |

### design
| Skill | 功能 |
|-------|------|
| `ui-ux-pro-max` | UI/UX 全能：50 樣式、9 stack、20 圖表類型 |

### data
| Skill | 功能 |
|-------|------|
| `db-schema` | 資料庫設計：需求 → 實體建模 → ER 圖 → DDL → migration |
| `financial-modeling` | 財務建模：P&L、現金流、DCF 估值、情境分析 |
| `market-research` | 市場調查：競品分析、SWOT、TAM/SAM/SOM 計算 |

### ops
| Skill | 功能 |
|-------|------|
| `ci-cd-pipeline` | CI/CD pipeline 設計與設定（GitHub Actions / GitLab CI 等） |
| `deploy-ops` | 正式環境部署清單、健康檢查、回滾流程 |

### security
| Skill | 功能 |
|-------|------|
| `security-audit` | OWASP LLM Top 10、注入、hardcode secret 資安稽核 |

### writing
| Skill | 功能 |
|-------|------|
| `article-writing` | 結構化技術文章撰寫：受眾定義 → 大綱 → 草稿 → 格式化 |
| `content-engine` | 從一個核心主題批量衍生多種格式（部落格、LinkedIn、推文等） |

### meta（管理 skill 本身）
| Skill | 功能 |
|-------|------|
| `skill-design` | 網路研究 + 選擇題蒐集需求，產出完整 spec 交給 skill-maker |
| `skill-maker` | 依據確認的 spec 建立 skill 資料夾與檔案 |
| `skill-edit` | 修改或刪除現有 skill，同步 guide + README + audit |
| `skill-audit` | 新 skill 的結構完整性 + 資安稽核（skill-maker 後自動觸發） |
| `skill-readme-sync` | SKILL.md 編輯後自動檢查 README 是否同步 |
| `skill-index-sync` | skill 增刪改名後自動同步 `_index.md`、`README.md`、`CLAUDE.md` |
| `skill-library-lint` | 整個 skill 庫結構規範稽核（命名、index、guide 完整性）|
| `pre-output-review` | 每次輸出前自動品質審查 |
| `task-planner` | 將複雜任務分解為依賴有序的子任務，整合 TodoWrite 追蹤 |
| `checkpoint-recovery` | 儲存長任務進度，中斷後可從斷點恢復 |
| `continuous-learning` | 從對話提取可重用模式並存入持久記憶系統 |
| `token-optimizer` | 分析 context 用量，識別 token 浪費，建議壓縮策略 |

## 建立新 Skill

在這個 repo 工作時，`skill-maker` 會自動引導建立流程：

1. 說明 skill 的用途
2. skill-maker 會詢問觸發條件、步驟、輸出格式、規則
3. 進行 web research 確認無重複
4. 產生 `SKILL.md` + 中文 `README.md`
5. skill-audit 自動執行結構與資安稽核直到 PASS

## Skill 格式規範

參考 [`CLAUDE.md`](CLAUDE.md) 或 [`meta/skill-system/skill-maker/SKILL.md`](meta/skill-system/skill-maker/SKILL.md)。

重點約束：
- SKILL.md 上限 1000 行；每句話必須有其價值，不得冗長重複
- 資料夾名稱必須與 frontmatter `name` 欄位一致
- `allowed-tools` 不是有效的 frontmatter 欄位
- 每個 category 必須有一個 `<category>-guide` 路由 skill
