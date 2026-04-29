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
- [ ] Create Drift database and migrations
- [ ] Implement `local_wallet` table
- [ ] Implement `transactions` table
- [ ] Implement `services_catalog` table
- [ ] Add optional `pending_sms_queue` table
- [ ] Add repository interfaces for wallet, catalog, and transactions

## Service Layer Tasks
- [ ] Build bearer-auth HTTP client
- [ ] Create PSI registry abstraction
- [ ] Implement wallet sync service
- [ ] Implement services catalog sync service
- [ ] Implement recharge request service
- [ ] Add API error mapping

## Tax Engine Tasks
- [ ] Implement tax classification enum
- [ ] Implement 10% telecom tax rule
- [ ] Implement 5% general sales tax rule
- [ ] Add breakdown formatter for YER receipts
- [ ] Add unit tests for rounding and totals

## Offline Tasks
- [ ] Detect connectivity state
- [ ] Design SMS command templates per provider
- [ ] Queue offline SMS operations locally
- [ ] Add duplicate-submission guards
- [ ] Add reconciliation flow after reconnect

## UI Planning Tasks for Phase 2
- [x] Extract exact Figma tokens from exported source
- [x] Build dashboard shell
- [x] Build Telecom tab
- [x] Build Gaming tab
- [ ] Build wallet summary cards
- [ ] Build transaction history list
- [ ] Build recharge confirmation and receipt screens

## Open Decisions
- [ ] Confirm whether entered price includes tax or excludes tax
- [ ] Confirm exact backend auth lifecycle
- [ ] Confirm full PSI mapping list
- [ ] Confirm which services support SMS fallback
- [ ] Confirm preferred Arabic font: Tajawal or Cairo
