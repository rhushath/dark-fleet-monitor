# Schema limitations and Phase 5 tasks

1. Generated SQL is a reproducible **initial schema**, not reversible migrations. Introduce migrations before real deployment.
2. Link endpoint IDs are polymorphic strings: service-layer validation and authorization are mandatory. Consider typed relation tables if they become a correctness bottleneck.
3. `owned_by` and related links must be created from cited `OwnershipRecord` evidence and must respect valid time ranges.
4. `Assessment` target links and action logs require transactional atomicity in Phase 5.
5. `source_id` references the SourceDataset logically; FK and provenance cardinality rules need tightening in Phase 5.
6. AISTrack geometry is a summary, not the raw AIS points. Raw AIS messages remain in the data lake/Parquet.
7. Ports/anchorages geometries may be points, polygons, or mixed source formats. Anchorage boundary JSON is placeholder pending a licensed polygon dataset.
8. The system must not conflate no data, intentional shutdown, spoofing, or sanctions violation.
9. Every event should link to Evidence and rule/config version; this is currently a policy, not a database-enforced invariant.
10. The generator validates names/types, not all semantic constraints (IMO check digits, timestamps order, valid coordinates, cardinalities).
