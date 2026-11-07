# Design decisions log

| ID | Decision | Why | Tradeoff / revisit |
|---|---|---|---|
| ADR-001 | Start with Danish terrestrial historical AIS | Free and locally manageable | Coverage gaps may masquerade as dark events; preserve coverage status |
| ADR-002 | Vessel primary key is validated IMO; unresolved MMSI-only records separate | IMO is generally stable across name/flag changes | Need identity resolution rules and false-merge controls |
| ADR-003 | One YAML ontology source of truth | Avoids hand-maintained application/DB model drift | Generator is small, limited type system |
| ADR-004 | Generate PostGIS SQL now; run migrations in Phase 5 | Verify model early without setting up infrastructure | DDL is not a production migration framework |
| ADR-005 | Time-bounded identity/ownership and link records | Historical correctness; prevent hindsight leakage | Requires careful temporal joins |
| ADR-006 | Explicit Evidence, SourceDataset and pipeline_version | Reproducible, inspectable investigative claims | More rows and ingestion complexity |
| ADR-007 | Require analyst approval for mutating actions | Auditable human accountability | Slower than automatic case closure |
| ADR-008 | STS claims are proximity indicators, not proof of cargo transfer | AIS alone cannot observe cargo operations | SAR can corroborate ship presence, not transfer |
| ADR-009 | GFW is optional; tanker-tanker detection is first-party | Documented GFW encounter types do not explicitly support tanker-tanker | Must benchmark our own algorithm |
| ADR-010 | Only raw input tables may be accessed by ingestion code; app/agent read ontology | Stable interface for UI and tools | Need API authorization enforcement later |
| ADR-011 | Relationships are generic timestamped links | Enables graph traversal and flexible types | Generic SQL cannot enforce endpoints; API must check |
