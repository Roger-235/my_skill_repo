# dev

## quality — 代碼品質 (14 skills)
| Skill | 說明 | 觸發詞 |
|-------|------|--------|
| code-review | 寫完代碼後自動觸發審查 | review code, write code（自動觸發） |
| code-reviewer | PR 自動化代碼審查：複雜度、風險、SOLID 分析 | review pull request, analyze PR, code reviewer |
| code-quality | 代碼品質分析：SOLID、smell、複雜度 | check code quality, find code smells, 分析代碼品質 |
| refactor | 系統化重構（保持行為不變） | refactor, clean up code, extract method, 重構 |
| debug | 系統化除錯流程 | debug, find the bug, error, crash, 找 bug |
| build-fix | 診斷並修復建置/編譯錯誤，找出根因 | build fails, compilation error, 建置失敗 |
| dependency-auditor | 稽核依賴套件：過時版本、安全漏洞、授權風險 | audit dependencies, outdated packages, dependency security |
| env-secrets-manager | 環境變數與密鑰管理：安全存取、輪換策略 | env vars, secrets management, environment variables |
| pr-review-expert | 專家級 PR 審查：架構、效能、安全性深度分析 | expert PR review, deep code review, senior review |
| tech-debt-tracker | 掃描技術債、評分嚴重性、生成優先修復計畫 | tech debt, code health, debt scoring, cleanup sprint |
| code-convention-auditor | 掃描代碼對照命名、格式、匯入規範，輸出中文違規報告 | 檢查代碼規範, 命名規範, 代碼風格, convention audit |
| unified-quality-auditor | 統一品質閘道：自動偵測目標類型，同時執行 skill 診斷與代碼規範審查 | unified quality audit, quality gate, 統一品質審查, 全面品質掃描 |
| pr-description-writer | 從 git diff 自動生成 PR 描述：Summary、Changes、Testing、Breaking Changes | write PR description, generate PR body, 寫 PR 描述 |
| dead-code-auditor | 掃描未使用的 export、zombie function、不可達程式碼、未使用的 import | dead code, unused code, zombie functions, 死碼 |

## patterns — 語言規範 (4 skills)
| Skill | 說明 | 觸發詞 |
|-------|------|--------|
| typescript-patterns | TypeScript strict mode 與型別標注最佳實踐 | TypeScript patterns, TS strict, 寫 TypeScript |
| python-patterns | PEP 8、型別標注、Google docstring | Python patterns, PEP 8, 寫 Python |
| go-patterns | Go 慣用模式：小介面、錯誤包裝、並發安全 | Go patterns, Golang idioms, 寫 Go |
| react-patterns | React hooks 規則與 Next.js Server Components | React patterns, hooks rules, 寫 React |

## testing — 測試 (5 skills)
| Skill | 說明 | 觸發詞 |
|-------|------|--------|
| tdd-guide | 測試驅動開發：紅綠重構循環，先寫失敗測試 | TDD, test-driven, write tests first, 先寫測試 |
| webapp-testing | Playwright 瀏覽器自動化測試 | test webapp, take screenshot, run Playwright |
| playwright-pro | 生產級 Playwright 測試工具組：55 範本、修復 flaky | Playwright tests, E2E testing, fix flaky tests |
| playwright-mcp-setup | 設定 @playwright/mcp MCP server，讓 Claude 直接控制瀏覽器 | playwright MCP, browser control, @playwright/mcp |
| senior-qa | 為 React/Next.js 生成測試並分析覆蓋率缺口 | generate tests, write unit tests, test coverage |

## infra — 基礎設施 (12 skills)
| Skill | 說明 | 觸發詞 |
|-------|------|--------|
| docker-patterns | Dockerfile 最佳實踐：multi-stage、最小映像、非 root | Dockerfile, Docker, containerize, 容器化 |
| docker-development | Docker 開發環境優化：compose 編排、容器安全強化 | docker development, docker-compose, container security |
| git-workflow | 分支命名、Conventional Commits、PR 模板、合併策略 | git workflow, branching strategy, commit conventions |
| ci-cd-pipeline-builder | CI/CD 管線建構：GitHub Actions / GitLab CI | CI/CD pipeline, GitHub Actions, build pipeline |
| helm-chart-builder | Helm chart 開發：chart 架構、values 設計、安全強化 | Helm chart, Kubernetes deploy, helm template |
| terraform-patterns | Terraform IaC 模式：模組設計、狀態管理、安全強化 | Terraform, IaC, infrastructure as code |
| observability-designer | 可觀測性架構：metrics、logging、tracing、告警策略 | observability, monitoring, metrics, logging, tracing |
| senior-devops | 資深 DevOps：CI/CD、IaC、雲端平台、部署自動化 | DevOps, deployment automation, cloud platform |
| senior-secops | 資深 SecOps：SAST/DAST、CVE 修復、合規驗證 | SecOps, SAST, DAST, CVE remediation |
| senior-security | 安全工程工具組：威脅建模、漏洞分析、滲透測試準備 | security review, threat modeling, STRIDE, OWASP |
| slo-engineer | 定義 SLO/SLI、計算 error budget、設計 burn rate 警報 | SLO, SLI, error budget, burn rate alert, 服務等級, 99.9% |
| project-bootstrap | 一個指令建出生產就緒專案骨架：Clean Architecture、Dockerfile、CI/CD | bootstrap project, scaffold project, 建立新專案, 初始化專案 |

## tools — 工具擴充 (3 skills)
| Skill | 說明 | 觸發詞 |
|-------|------|--------|
| mcp-maker | 建立 MCP server（Python FastMCP / TypeScript standalone） | create MCP server, build MCP tool, FastMCP |
| mcp-server-builder | MCP Server Builder：進階 MCP server 建構與配置 | build MCP server, MCP server builder |
| auto-mcp | Claude 無法完成某功能時自動產生 MCP server | cannot access, unable to perform（自動觸發） |

## agents — AI 代理 (4 skills)
| Skill | 說明 | 觸發詞 |
|-------|------|--------|
| agent-designer | 設計自主 AI 代理：目標、記憶架構、工具選擇與執行循環 | design agent, build agent, agent architecture |
| agent-workflow-designer | 設計多步驟代理工作流程：編排、分支、平行執行 | agent workflow, multi-step agent, orchestrate agents |
| rag-architect | 設計 RAG 系統：切塊策略、嵌入模型、向量資料庫 | design RAG, build RAG, retrieval-augmented generation |
| autoresearch-agent | 自主規劃多輪搜尋並最佳化目標指標的研究代理 | auto research, autonomous research, optimize metric |

## architecture — 系統架構 (4 skills)
| Skill | 說明 | 觸發詞 |
|-------|------|--------|
| aws-solution-architect | AWS 雲端架構設計：服務選型、網路、IAM、成本估算 | design AWS architecture, cloud architecture, deploy on AWS |
| senior-architect | 資深架構師：系統設計、取捨評估、SPOF 識別、ADR 產出 | review architecture, design system architecture, ADR |
| tech-stack-evaluator | 加權評估矩陣比較技術選項，識別風險，產出明確推薦 | evaluate tech stack, choose technology, compare frameworks |
| interview-system-designer | 結構化系統設計面試：需求釐清、容量估算、設計、取捨 | system design interview, design a system, system design question |

## api — API 與資料庫 (4 skills)
| Skill | 說明 | 觸發詞 |
|-------|------|--------|
| api-design-reviewer | 審查 REST/GraphQL/RPC API 設計一致性、安全性、開發者體驗 | review API design, audit API, evaluate REST API |
| api-test-suite-builder | 為 API 端點生成覆蓋 Happy Path、驗證、安全性的完整測試套件 | build API tests, generate API test suite, test this API |
| database-designer | 設計完整資料庫架構：類型選型、索引策略、分割、複寫 | design database, database architecture, choose database |
| database-schema-designer | 產出生產就緒的資料庫 Schema DDL 與 UP/DOWN 遷移腳本 | design schema, write DDL, create table, database migration |

## frontend — 前端開發 (3 skills)
| Skill | 說明 | 觸發詞 |
|-------|------|--------|
| senior-frontend | 資深前端工程師：無障礙、效能、元件架構 | build UI, implement component, accessibility audit, web vitals |
| epic-design | 頂尖 UI/UX 設計師：電影級動畫、玻璃擬態、微互動、粒子特效 | epic design, stunning UI, cinematic animation, glassmorphism |
| accessibility-audit | WCAG 2.2 Level AA 無障礙稽核：色彩對比、ARIA、鍵盤導航、螢幕閱讀器 | accessibility audit, WCAG, a11y, screen reader, color contrast, 無障礙 |

## backend — 後端開發 (3 skills)
| Skill | 說明 | 觸發詞 |
|-------|------|--------|
| senior-backend | 資深後端工程師：API 設計、服務分層、認證授權、後端最佳實踐 | build API, backend architecture, authentication, 後端開發 |
| senior-fullstack | 資深全端工程師：端對端型別安全、前後端整合 | fullstack feature, end-to-end implementation, 全端開發 |
| stripe-integration-expert | Stripe 整合專家：付款、訂閱、Webhook、Connect、客戶入口 | Stripe integration, payment processing, subscription billing |

## data-ml — 資料與機器學習 (5 skills)
| Skill | 說明 | 觸發詞 |
|-------|------|--------|
| senior-data-engineer | 資深資料工程師：ETL/ELT 管線、倉儲建模、dbt、Airflow | data pipeline, ETL, dbt, Airflow, data warehouse |
| senior-data-scientist | 資深資料科學家：統計分析、假設檢定、A/B 測試、預測模型 | data analysis, EDA, statistical test, A/B test |
| senior-ml-engineer | 資深 ML 工程師：訓練管線、特徵工程、MLOps、漂移偵測 | ML pipeline, feature engineering, model serving, MLOps |
| senior-computer-vision | 資深電腦視覺工程師：物件偵測、分割、OCR、視頻分析 | computer vision, object detection, segmentation, OCR |
| senior-prompt-engineer | 資深提示詞工程師：系統提示、few-shot、RAG、結構化輸出 | write prompt, system prompt, few-shot, chain of thought |

## workspace — 工作區管理 (4 skills)
| Skill | 說明 | 觸發詞 |
|-------|------|--------|
| google-workspace-cli | Google Workspace API 自動化：Gmail、Drive、Calendar、Admin SDK | Google Workspace, Gmail API, Google Drive, Google Admin |
| ms365-tenant-manager | Microsoft 365 租戶管理：用戶、授權、Teams、Exchange Online | Microsoft 365, M365, Azure AD, tenant admin |
| incident-commander | 事故指揮官：從偵測到事後分析的端對端事故應對 | incident, outage, production down, P0, postmortem |
| email-template-builder | HTML 電子郵件範本：響應式、深色模式、ESP 相容、無障礙 | email template, HTML email, transactional email |

## productivity — 開發生產力 (8 skills)
| Skill | 說明 | 觸發詞 |
|-------|------|--------|
| codebase-onboarding | 陌生程式碼庫的結構化入職指南：架構、入口點、資料流 | onboarding, new codebase, understand codebase, codebase tour |
| git-worktree-manager | Git worktree 管理：並行分支開發，無需 stash 切換上下文 | git worktree, parallel branches, multiple branches |
| monorepo-navigator | Monorepo 導覽：Nx/Turborepo/Bazel 套件圖、受影響任務 | monorepo, nx, turborepo, bazel, affected packages |
| performance-profiler | 效能瓶頸診斷：CPU 熱點、記憶體洩漏、N+1 查詢 | performance, profiling, slow, memory leak, flame graph |
| migration-architect | 技術遷移架構：資料庫遷移、框架升級、零停機策略 | migration, migrate, upgrade, zero downtime |
| office-hours | YC 風格產品腦力激盪：六個強迫診斷問題，產出設計文件 | office hours, help me think through this, validate my idea, 想法驗證 |
| standup-notes | 從 git log 自動生成每日站會報告：Yesterday / Today / Blockers | standup, daily standup, scrum notes, 站會, 每日報告 |
| spec-writer | Spec-first：需求轉規格文件，定義介面合約與成功標準後再實作 | write a spec, spec first, 先寫 spec, technical spec, feature spec |

## release — 發布管理 (5 skills)
| Skill | 說明 | 觸發詞 |
|-------|------|--------|
| changelog-generator | 從 git 歷史/Conventional Commits 產生 CHANGELOG.md | changelog, release notes, conventional commits |
| release-manager | 完整軟體發布流程：SemVer 決策、標籤、CI 驗證、發布後驗證 | release, cut a release, ship, semantic versioning |
| runbook-generator | 操作 Runbook：部署、事故應對、維護、擴縮容、還原程序 | runbook, operational guide, SOP, on-call runbook |
| canary | 部署後回歸監控：比對 baseline，只在有變化時發出警報 | canary, 部署後監控, 上線後巡邏 |
| document-release | 發布後文件同步：讀取 git diff 更新 README/ARCHITECTURE/CHANGELOG 等 | document release, sync docs, update readme after ship, 更新文件 |
