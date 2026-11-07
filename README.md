# Dark Fleet Monitor — Phase 0

Ontology-first maritime risk-indicator research using legally obtained public data. **Events are anomalies, not accusations.**

## Quick start (Python 3.11+)

```bash
python3 -m venv .venv
source .venv/bin/activate
python -m pip install -r requirements.txt
python scripts/ontology.py --check
python -m unittest discover -s tests -v
```

To modify the ontology, edit `ontology/ontology.yaml`, run `python scripts/ontology.py` and commit YAML and generated SQL together.

## Boundaries
- Phase 0 creates only the ontology, a deterministic PostGIS DDL generator, tests, and source/decision documents.
- No data downloads, live feeds, detections or deployed database are performed yet.
- `ontology/generated_schema.sql` is generated for **Phase 5**, not executed in Phase 0. It requires PostgreSQL with PostGIS.
- Generic `ontology_links` records are validated against object/link types in the future service, not by SQL foreign keys. This is a deliberate limitation.
- Source lineage fields are provided on object tables; `SourceDataset` captures download checksums, and `Evidence` captures direct citations.
- IMO is canonical when validated. AIS reports lacking verified IMO belong in `UnresolvedAISIdentity` until resolved.

See `docs/DATA_SOURCES.md`, `docs/DESIGN_DECISIONS.md` and `docs/SCHEMA_LIMITATIONS.md`.
