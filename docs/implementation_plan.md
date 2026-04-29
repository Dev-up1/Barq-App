# Barq Recharge - Phase 1 Implementation Plan

## Status
- Phase: Foundation and planning only
- UI implementation: Not started
- Business logic implementation: Not started
- Flutter CLI scaffold: Blocked in this environment because `flutter` is not installed
- Figma live canvas extraction: Blocked because no Figma `fileKey` or node reference was provided to the connected MCP session
- Design reference source available locally from exported UI project:
  - `C:\Users\Administrator\Downloads\Barq Recharge Mobile UI Screens`

## Product Summary
Barq Recharge (برق للشحن الفوري) is a local Yemeni instant recharge and digital goods application. The app uses Yemeni Rial (YER) only and operates on a pre-funded local agent balance. No international payment gateway support is allowed.

## Design Direction
The initial design assumptions are derived from the provided brief and validated against the exported UI source in `Downloads\Barq Recharge Mobile UI Screens` until a live Figma canvas is connected:
- RTL-first Arabic UX
- Typography preference: Tajawal or Cairo
- Minimalist modern layout
- Selective glassmorphism on cards, balance panels, and quick actions
- Dual-tab dashboard:
  - Telecom
  - Gaming
- Clear YER pricing and tax breakdown on every purchase flow

## Extracted Design Tokens From Exported UI Source
Source files reviewed:
- `src/styles/theme.css`
- `src/styles/fonts.css`
- `src/app/components/DualTabDashboard.tsx`

Color tokens:
- Background: `#FAF9F6`
- Foreground: `#1A1A2E`
- Card: `#FFFFFF`
- Primary brand: `#10B981`
- Secondary accent: `#A5D6F3`
- Muted text: `#717182`
- Border: `rgba(0, 0, 0, 0.1)`
- Input glass background: `rgba(255, 255, 255, 0.5)`
- Dark background: `#0F1E3D`
- Dark card: `#1A2847`

Typography tokens:
- Font stack: `Cairo`, `Tajawal`, `sans-serif`
- Base font size: `16px`
- Normal weight: `400`
- Medium weight: `500`

Shape and effects:
- Base radius: `1rem`
- Frequent card rounding in components: `rounded-2xl` and `rounded-3xl`
- Glassmorphism pattern:
  - backdrop blur enabled
  - white translucent layers
  - low-opacity borders
- Main page background:
  - soft diagonal gradient from primary tint to background to secondary tint

Interaction patterns:
- Main segmented dashboard uses two tabs:
  - Services and Recharge
  - Gaming and Subscriptions
- Offline banner explicitly activates SMS mode messaging
- Agent balance appears in a large green gradient summary card
- Service tiles use 4-column grid with colored icons
- Gaming products use 2-column cards with soft gradients

## Constraints and Non-Negotiables
- Currency is strictly `YER`
- No Visa, Mastercard, PayPal, or other international checkout methods
- Recharge operations depend on pre-funded local wallet balance
- PSI codes must remain exact and centrally managed
- Tax engine must support category-based taxation
- Offline fallback must support SMS command dispatch when the internet drops

## Proposed Technical Stack
- Flutter
- Riverpod for state management and dependency injection
- Go Router for navigation
- Drift + SQLite for local persistence
- Dio for API communication
- Freezed + Json Serializable for immutable models
- Flutter Secure Storage for bearer token and sensitive local credentials
- Connectivity Plus for connectivity awareness
- Telephony or platform channel integration for offline SMS fallback

## Proposed Project Structure
```text
lib/
  app/
  bootstrap/
  core/
    config/
    constants/
    errors/
    networking/
    rtl/
    taxation/
    utils/
  data/
    db/
    models/
    repositories/
    services/
  features/
    auth/
    dashboard/
    wallet/
    telecom/
    gaming/
    transactions/
    settings/
    offline_sms/
  shared/
    widgets/
    theme/
docs/
```

## Core Modules

### 1. App Shell
- Bootstrap app configuration
- Enforce RTL locale defaults
- Register theme tokens from Figma once connected
- Initialize local database and secure storage before app launch

### 2. Authentication Module
- Store bearer token securely
- Refresh token policy to be confirmed with backend
- Fail closed on missing or expired token

### 3. Local Ledger Module
Local database planned with Drift over SQLite.

Tables:
- `local_wallet`
  - `id`
  - `agent_name`
  - `available_balance_yer`
  - `reserved_balance_yer`
  - `last_synced_at`
- `transactions`
  - `id`
  - `reference`
  - `service_type`
  - `psi_code`
  - `target_identifier`
  - `gross_amount_yer`
  - `tax_amount_yer`
  - `net_amount_yer`
  - `status`
  - `channel` (`api` or `sms_fallback`)
  - `created_at`
  - `synced_at`
- `services_catalog`
  - `id`
  - `name_ar`
  - `name_en`
  - `category`
  - `provider`
  - `psi_code`
  - `tax_class`
  - `is_active`
  - `last_updated_at`

Supporting tables recommended:
- `pending_sms_queue`
- `api_audit_log`
- `app_config_cache`

### 4. API Service Layer
- Bearer token authentication for all protected endpoints
- Central PSI registry to prevent hardcoded scattered values
- Strict request/response DTO separation
- Retry policy only for idempotent catalog or wallet sync requests
- Recharge transactions require:
  - service PSI code
  - target number or account
  - requested amount or package selection
  - computed tax payload
  - local reference ID

Initial PSI mapping placeholders from brief:
- Yemen Mobile Balance = `1`
- YOU Packages = `7`
- Additional PSI codes for Aden Net, PUBG UC, and others to be registered in a single source of truth once confirmed

### 5. Yemen Tax Compliance Engine
Category-based taxation service:
- Mobile telecom services: `10%`
- General sales, including Aden Net class examples: `5%`

Tax engine responsibilities:
- Determine tax class from `services_catalog`
- Compute gross, tax, and net values consistently
- Persist tax breakdown per transaction
- Expose formatted YER totals to UI
- Support future tax-rate versioning

Formula policy to validate with business owner:
- Option A: `total = base + tax`
- Option B: `base = entered amount`, `tax = derived`, `total = base + tax`
- Option C: `entered total includes tax`, requiring reverse extraction

Until clarified, store:
- `base_amount_yer`
- `tax_amount_yer`
- `total_amount_yer`

### 6. Offline Resilience and SMS Fallback
When connectivity is lost:
- Detect offline state before initiating API purchase
- Offer SMS fallback only for supported services
- Build provider-specific SMS command templates
- Queue SMS attempts locally with pending and sent states
- Mark resulting transactions with `sms_fallback` channel
- Reconcile later when connectivity returns

Offline safeguards:
- Show user warning before sending SMS
- Keep audit trail of SMS body template and timestamp
- Prevent duplicate submissions on reconnect

### 7. Catalog and Service Discovery
- Sync `services_catalog` from backend on login and periodic refresh
- Cache locally for offline browsing
- Separate catalog groups:
  - Telecom
  - Internet
  - Gaming
  - Other digital goods

### 8. Dashboard Planning
Primary dashboard zones:
- Balance summary
- Dual-tab switcher: Telecom / Gaming
- Quick service tiles
- Recent transactions
- Sync and connectivity status

### 9. Localization and RTL
- Arabic as primary locale
- Full RTL layout enforcement
- Numeric formatting for YER
- Avoid left-to-right leakage in cards, forms, and receipts

### 10. Error Handling and Auditability
- Typed failures for network, auth, tax, catalog, wallet, and SMS
- Persist critical failed attempts
- Human-readable Arabic error messages
- Distinguish retryable vs non-retryable operations

## Figma MCP Follow-Up
Once a Figma file reference is supplied, extract and map:
- color tokens
- typography styles
- spacing scale
- radii
- shadows and blur values for glassmorphism
- iconography rules
- tab and card component anatomy

These values should be committed into:
- `lib/shared/theme/app_colors.dart`
- `lib/shared/theme/app_typography.dart`
- `lib/shared/theme/app_spacing.dart`
- `lib/shared/theme/app_theme.dart`

## Delivery Sequence
1. Confirm Flutter SDK and generate actual Flutter app scaffold
2. Connect Figma file and extract concrete design tokens
3. Implement Drift schema and repository contracts
4. Implement service catalog and PSI registry
5. Implement tax engine with unit tests
6. Implement bearer-auth API client
7. Implement offline SMS queue and reconciliation flow
8. Build dashboard and purchase flows from approved Figma tokens

## Immediate Risks
- Flutter SDK missing in current environment
- Figma design cannot be read live without file or node reference
- SMS fallback implementation depends on device permissions and package choice
- Tax formula edge cases need business confirmation
- Exact PSI inventory is still incomplete beyond the provided examples
