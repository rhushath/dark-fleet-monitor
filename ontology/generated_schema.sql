-- Generated from ontology/ontology.yaml. Do not edit manually.

CREATE EXTENSION IF NOT EXISTS postgis;

CREATE TABLE IF NOT EXISTS "Vessel" (
  "imo" TEXT NOT NULL,
  "status" TEXT,
  "source_id" TEXT,
  "pipeline_version" TEXT,
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  "updated_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  PRIMARY KEY ("imo")
);

CREATE TABLE IF NOT EXISTS "UnresolvedAISIdentity" (
  "id" TEXT NOT NULL,
  "mmsi" TEXT,
  "first_seen" TIMESTAMPTZ,
  "last_seen" TIMESTAMPTZ,
  "candidate_imo" TEXT,
  "resolution_status" TEXT,
  "source_id" TEXT,
  "pipeline_version" TEXT,
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  "updated_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "VesselIdentity" (
  "id" TEXT NOT NULL,
  "vessel_imo" TEXT,
  "mmsi" TEXT,
  "name" TEXT,
  "flag_code" TEXT,
  "ship_type" INTEGER,
  "valid_from" TIMESTAMPTZ,
  "valid_to" TIMESTAMPTZ,
  "recorded_at" TIMESTAMPTZ,
  "source_id" TEXT,
  "pipeline_version" TEXT,
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  "updated_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "Company" (
  "id" TEXT NOT NULL,
  "name" TEXT,
  "jurisdiction" TEXT,
  "incorporation_date" DATE,
  "source_id" TEXT,
  "pipeline_version" TEXT,
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  "updated_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "Address" (
  "id" TEXT NOT NULL,
  "normalized_address" TEXT,
  "country" TEXT,
  "location" geometry(Point,4326),
  "source_id" TEXT,
  "pipeline_version" TEXT,
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  "updated_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "Flag" (
  "code" TEXT NOT NULL,
  "country_name" TEXT,
  "source_id" TEXT,
  "pipeline_version" TEXT,
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  "updated_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  PRIMARY KEY ("code")
);

CREATE TABLE IF NOT EXISTS "Port" (
  "id" TEXT NOT NULL,
  "name" TEXT,
  "country_code" TEXT,
  "location" geometry(Point,4326),
  "source_id" TEXT,
  "pipeline_version" TEXT,
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  "updated_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "Anchorage" (
  "id" TEXT NOT NULL,
  "name" TEXT,
  "boundary" JSONB,
  "source_id" TEXT,
  "pipeline_version" TEXT,
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  "updated_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "AISTrack" (
  "id" TEXT NOT NULL,
  "vessel_imo" TEXT,
  "start_time" TIMESTAMPTZ,
  "end_time" TIMESTAMPTZ,
  "geometry" geometry(LineString,4326),
  "raw_dataset_id" TEXT,
  "source_id" TEXT,
  "pipeline_version" TEXT,
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  "updated_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "DarkGap" (
  "id" TEXT NOT NULL,
  "vessel_imo" TEXT,
  "start_time" TIMESTAMPTZ,
  "end_time" TIMESTAMPTZ,
  "start_position" geometry(Point,4326),
  "end_position" geometry(Point,4326),
  "duration_hours" DOUBLE PRECISION,
  "displacement_km" DOUBLE PRECISION,
  "implied_speed_knots" DOUBLE PRECISION,
  "coverage_status" TEXT,
  "coverage_peer_count" INTEGER,
  "rule_version" TEXT,
  "review_status" TEXT,
  "source_id" TEXT,
  "pipeline_version" TEXT,
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  "updated_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "SpoofingEvent" (
  "id" TEXT NOT NULL,
  "vessel_imo" TEXT,
  "event_time" TIMESTAMPTZ,
  "location" geometry(Point,4326),
  "anomaly_type" TEXT,
  "implied_speed_knots" DOUBLE PRECISION,
  "rule_version" TEXT,
  "review_status" TEXT,
  "source_id" TEXT,
  "pipeline_version" TEXT,
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  "updated_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "ShipToShipEvent" (
  "id" TEXT NOT NULL,
  "vessel_a_imo" TEXT,
  "vessel_b_imo" TEXT,
  "start_time" TIMESTAMPTZ,
  "end_time" TIMESTAMPTZ,
  "location" geometry(Point,4326),
  "duration_hours" DOUBLE PRECISION,
  "closest_distance_m" DOUBLE PRECISION,
  "distance_to_port_km" DOUBLE PRECISION,
  "distance_to_anchorage_km" DOUBLE PRECISION,
  "rule_version" TEXT,
  "review_status" TEXT,
  "source_id" TEXT,
  "pipeline_version" TEXT,
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  "updated_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "LoiteringEvent" (
  "id" TEXT NOT NULL,
  "vessel_imo" TEXT,
  "start_time" TIMESTAMPTZ,
  "end_time" TIMESTAMPTZ,
  "location" geometry(Point,4326),
  "avg_speed_knots" DOUBLE PRECISION,
  "rule_version" TEXT,
  "review_status" TEXT,
  "source_id" TEXT,
  "pipeline_version" TEXT,
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  "updated_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "SARDetection" (
  "id" TEXT NOT NULL,
  "acquisition_time" TIMESTAMPTZ,
  "location" geometry(Point,4326),
  "scene_id" TEXT,
  "vessel_imo" TEXT,
  "match_status" TEXT,
  "match_distance_m" DOUBLE PRECISION,
  "detector_version" TEXT,
  "source_id" TEXT,
  "pipeline_version" TEXT,
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  "updated_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "SanctionEntry" (
  "id" TEXT NOT NULL,
  "source_list" TEXT,
  "source_record_id" TEXT,
  "designated_name" TEXT,
  "effective_from" DATE,
  "effective_to" DATE,
  "fetched_at" TIMESTAMPTZ,
  "source_url" TEXT,
  "source_id" TEXT,
  "pipeline_version" TEXT,
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  "updated_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "Evidence" (
  "id" TEXT NOT NULL,
  "source_name" TEXT,
  "observed_at" TIMESTAMPTZ,
  "collected_at" TIMESTAMPTZ,
  "source_url" TEXT,
  "file_sha256" TEXT,
  "rule_or_model_version" TEXT,
  "source_record_id" TEXT,
  "description" TEXT,
  "source_id" TEXT,
  "pipeline_version" TEXT,
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  "updated_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "Assessment" (
  "id" TEXT NOT NULL,
  "analyst_id" TEXT,
  "assessment_time" TIMESTAMPTZ,
  "verdict" TEXT,
  "confidence" DOUBLE PRECISION,
  "notes" TEXT,
  "source_id" TEXT,
  "pipeline_version" TEXT,
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  "updated_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "OwnershipRecord" (
  "id" TEXT NOT NULL,
  "vessel_imo" TEXT,
  "company_id" TEXT,
  "role" TEXT,
  "valid_from" TIMESTAMPTZ,
  "valid_to" TIMESTAMPTZ,
  "recorded_at" TIMESTAMPTZ,
  "evidence_id" TEXT,
  "source_id" TEXT,
  "pipeline_version" TEXT,
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  "updated_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "InvestigationCase" (
  "id" TEXT NOT NULL,
  "title" TEXT,
  "status" TEXT,
  "opened_at" TIMESTAMPTZ,
  "opened_by" TEXT,
  "source_id" TEXT,
  "pipeline_version" TEXT,
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  "updated_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "ActionLog" (
  "id" TEXT NOT NULL,
  "action_name" TEXT,
  "actor_id" TEXT,
  "acted_at" TIMESTAMPTZ,
  "target_type" TEXT,
  "target_id" TEXT,
  "reason" TEXT,
  "payload" JSONB,
  "source_id" TEXT,
  "pipeline_version" TEXT,
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  "updated_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "WatchlistEntry" (
  "id" TEXT NOT NULL,
  "vessel_imo" TEXT,
  "created_by" TEXT,
  "created_at" TIMESTAMPTZ,
  "reason" TEXT,
  "source_id" TEXT,
  "pipeline_version" TEXT,
  "updated_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "SourceDataset" (
  "id" TEXT NOT NULL,
  "provider" TEXT,
  "source_url" TEXT,
  "downloaded_at" TIMESTAMPTZ,
  "checksum_sha256" TEXT,
  "license_notes" TEXT,
  "source_id" TEXT,
  "pipeline_version" TEXT,
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  "updated_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS ontology_links (
  id TEXT PRIMARY KEY,
  link_name TEXT NOT NULL,
  from_type TEXT NOT NULL,
  from_id TEXT NOT NULL,
  to_type TEXT NOT NULL,
  to_id TEXT NOT NULL,
  valid_from TIMESTAMPTZ,
  valid_to TIMESTAMPTZ,
  evidence_id TEXT REFERENCES "Evidence"("id"),
  recorded_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  pipeline_version TEXT
);

CREATE INDEX IF NOT EXISTS ontology_links_source_idx ON ontology_links (from_type, from_id, link_name);

CREATE INDEX IF NOT EXISTS ontology_links_target_idx ON ontology_links (to_type, to_id);
