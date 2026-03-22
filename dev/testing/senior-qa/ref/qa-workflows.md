# QA Workflows

Step-by-step guides for the three main QA workflows.

---

## Unit Test Generation Workflow

Use when setting up tests for new or existing React components.

**Step 1: Scan project for untested components**
```bash
python scripts/test_suite_generator.py src/components/ --scan-only
```

**Step 2: Generate test stubs**
```bash
python scripts/test_suite_generator.py src/components/ --output __tests__/
```

**Step 3: Review and customize generated tests**
```typescript
// __tests__/Button.test.tsx (generated)
import { render, screen, fireEvent } from '@testing-library/react';
import { Button } from '../src/components/Button';

describe('Button', () => {
  it('renders with label', () => {
    render(<Button>Click me</Button>);
    expect(screen.getByRole('button', { name: /click me/i })).toBeInTheDocument();
  });

  it('calls onClick when clicked', () => {
    const handleClick = jest.fn();
    render(<Button onClick={handleClick}>Click</Button>);
    fireEvent.click(screen.getByRole('button'));
    expect(handleClick).toHaveBeenCalledTimes(1);
  });

  // TODO: Add your specific test cases
});
```

**Step 4: Run tests and check coverage**
```bash
npm test -- --coverage
python scripts/coverage_analyzer.py coverage/coverage-final.json
```

---

## Coverage Analysis Workflow

Use when improving test coverage or preparing for release.

**Step 1: Generate coverage report**
```bash
npm test -- --coverage --coverageReporters=json
```

**Step 2: Analyze coverage gaps**
```bash
python scripts/coverage_analyzer.py coverage/coverage-final.json --threshold 80
```

**Step 3: Identify critical paths**
```bash
python scripts/coverage_analyzer.py coverage/ --critical-paths
```

**Step 4: Generate missing test stubs**
```bash
python scripts/test_suite_generator.py src/ --uncovered-only --output __tests__/
```

**Step 5: Verify improvement**
```bash
npm test -- --coverage
python scripts/coverage_analyzer.py coverage/ --compare previous-coverage.json
```

---

## E2E Test Setup Workflow

Use when setting up Playwright for a Next.js project.

**Step 1: Initialize Playwright (if not installed)**
```bash
npm init playwright@latest
```

**Step 2: Scaffold E2E tests from routes**
```bash
python scripts/e2e_test_scaffolder.py src/app/ --output e2e/
```

**Step 3: Configure authentication fixtures**
```typescript
// e2e/fixtures/auth.ts (generated)
import { test as base } from '@playwright/test';

export const test = base.extend({
  authenticatedPage: async ({ page }, use) => {
    await page.goto('/login');
    await page.fill('[name="email"]', 'test@example.com');
    await page.fill('[name="password"]', 'password');
    await page.click('button[type="submit"]');
    await page.waitForURL('/dashboard');
    await use(page);
  },
});
```

**Step 4: Run E2E tests**
```bash
npx playwright test
npx playwright show-report
```

**Step 5: Add to CI pipeline**
```yaml
# .github/workflows/e2e.yml
- name: "run-e2e-tests"
  run: npx playwright test
- name: "upload-report"
  uses: actions/upload-artifact@v3
  with:
    name: "playwright-report"
    path: playwright-report/
```
