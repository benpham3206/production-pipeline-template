# Interface Contracts

> All component and API boundaries must be documented here before implementation.

---

## Rule

**No component may be implemented without an interface defined in this file.**

If an interface needs to change, create an Architecture Decision Record (ADR) in `docs/adr/`.

---

## Interface Template

```typescript
// ============================================================================
// Component: [Name]
// Purpose: [One sentence]
// Owner: [Human/Team name]
// Status: draft | approved | deprecated
// ============================================================================

interface [ComponentName]Props {
  [prop]: [type];  // [description]
}

// Behavior:
// - [requirement 1]
// - [requirement 2]

// Validation:
// - [rule 1]
// - [rule 2]

// Error Handling:
// - [scenario 1] → [behavior]
// - [scenario 2] → [behavior]
```

---

## Example: API Endpoint

```typescript
// ============================================================================
// Endpoint: POST /api/users
// Purpose: Create a new user account
// Owner: Backend Team
// Status: approved
// ============================================================================

interface CreateUserRequest {
  email: string;       // Validated with Zod email schema
  name: string;        // 1-100 characters
  role: 'user' | 'admin'; // Defaults to 'user'
}

interface CreateUserResponse {
  id: string;
  email: string;
  name: string;
  role: string;
  createdAt: string;   // ISO 8601
}

// Behavior:
// - Returns 201 on success
// - Returns 409 if email already exists
// - Rate limited to 10 requests per minute per IP

// Validation:
// - Email must be valid format
// - Name must be 1-100 characters
// - Role must be 'user' or 'admin'

// Error Handling:
// - Invalid email → 400 { error: 'Invalid email format' }
// - Duplicate email → 409 { error: 'Email already exists' }
// - Rate limit exceeded → 429 { error: 'Too many requests' }
```

---

## Example: UI Component

```typescript
// ============================================================================
// Component: <DataTable />
// Purpose: Display paginated, sortable tabular data
// Owner: Frontend Team
// Status: draft
// ============================================================================

interface DataTableProps<T> {
  data: T[];                    // Required
  columns: ColumnDef<T>[];      // Required
  pageSize?: number;            // Default: 25
  sortable?: boolean;           // Default: true
  onRowClick?: (row: T) => void;
}

interface ColumnDef<T> {
  key: keyof T;
  header: string;
  width?: string;
  align?: 'left' | 'center' | 'right';
}

// Behavior:
// - Renders empty state when data.length === 0
// - Sorts by first column ascending by default
// - Fires onRowClick only when row is clicked (not header)

// Validation:
// - columns must have at least 1 entry
// - pageSize must be > 0

// Error Handling:
// - Invalid columns → Render error boundary fallback
// - data is undefined → Render loading skeleton
```

---

## Active Interfaces

*(None yet — define your first interface here before implementing it.)*

---

## Deprecated Interfaces

*(Move retired interfaces here with deprecation date and reason.)*
