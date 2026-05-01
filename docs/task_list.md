# Barq Recharge - Task List

## Phase 1 Completed Deliverables
- [x] Define product constraints for Yemeni local recharge only
- [x] Draft implementation plan
- [x] Draft task list
- [x] Define proposed Flutter architecture
- [x] Define local ledger database schema
- [x] Define API architecture assumptions
- [x] Define Yemen tax engine requirements
- [x] Define offline SMS fallback requirements

## Environment Blockers
- [ ] Install Flutter SDK and confirm `flutter doctor`
- [x] Prepare manual Flutter scaffold in repo while SDK is unavailable
- [ ] Connect Figma file via MCP with `fileKey` or active canvas reference
- [ ] Confirm complete PSI code catalog from backend/business source

## Foundation Tasks
- [x] Create Flutter app scaffold
- [x] Add Riverpod, Drift, Dio, Go Router, Secure Storage dependencies
- [ ] Configure linting and analysis options
- [x] Set up Arabic locale and RTL defaults
- [x] Set up theme token files
- [x] Create app bootstrap flow
- [x] Link local repo to GitHub origin
- [x] Add Supabase environment-based initialization

## Data Layer Tasks
- [x] Create Drift database and migrations boilerplate
- [x] Implement `local_wallet` table
- [x] Implement `transactions` table
- [x] Implement `services_catalog` table
- [x] Add optional `pending_sms_queue` table
- [x] Add repository interfaces for wallet, catalog, and transactions

## Service Layer Tasks
- [x] Build bearer-auth HTTP client
- [x] Create PSI registry abstraction
- [ ] Implement wallet sync service
- [ ] Implement services catalog sync service
- [x] Implement recharge request service
- [ ] Add API error mapping

## Tax Engine Tasks
- [x] Implement tax classification enum
- [x] Implement 10% telecom tax rule
- [x] Implement 5% general sales tax rule
- [ ] Add breakdown formatter for YER receipts
- [x] Add unit tests for rounding and totals

## Offline Tasks
- [x] Detect connectivity state
- [x] Design SMS command templates per provider
- [x] Queue offline SMS operations locally
- [ ] Add duplicate-submission guards
- [ ] Add reconciliation flow after reconnect

## Phase 4 Tasks
- [x] Require biometric verification before recharge submission
- [x] Add wallet daily/monthly spending limits to local database
- [x] Add sub-account management tables and repository layer
- [x] Add commission logs table and monthly PDF export service
- [x] Add spending-limit guard for owner and sub-account flows
- [x] Add WhatsApp support launcher with prefilled dispute context
- [x] Add persistent support entry point in the app UI
- [x] Add agent dashboard with summary cards and sub-account controls

## UI Planning Tasks for Phase 2
- [x] Extract exact Figma tokens from exported source
- [x] Build dashboard shell
- [x] Build Telecom tab
- [x] Build Gaming tab
- [x] Build wallet summary cards
- [ ] Build transaction history list
- [x] Build recharge confirmation and receipt screens

## Open Decisions
- [ ] Confirm whether entered price includes tax or excludes tax
- [ ] Confirm exact backend auth lifecycle
- [ ] Confirm full PSI mapping list
- [ ] Confirm which services support SMS fallback
- [ ] Confirm preferred Arabic font: Tajawal or Cairo
