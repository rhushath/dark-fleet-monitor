"""Validate the single ontology contract and generate deterministic PostGIS DDL."""
import argparse
from pathlib import Path
import re
import yaml

TYPES = {
    'string': 'TEXT', 'integer': 'INTEGER', 'float': 'DOUBLE PRECISION',
    'boolean': 'BOOLEAN', 'timestamp': 'TIMESTAMPTZ', 'date': 'DATE',
    'json': 'JSONB', 'point': 'geometry(Point,4326)',
    'linestring': 'geometry(LineString,4326)',
}
IDENTIFIER = re.compile(r'^[A-Za-z][A-Za-z0-9_]*$')


def safe_identifier(name):
    if not isinstance(name, str) or not IDENTIFIER.fullmatch(name):
        raise ValueError(f'Unsafe SQL identifier: {name!r}')
    return '"' + name + '"'


def load_and_validate(path):
    spec = yaml.safe_load(Path(path).read_text(encoding='utf-8'))
    if not isinstance(spec, dict) or not spec.get('objects'):
        raise ValueError('Ontology must contain objects')
    for obj, definition in spec['objects'].items():
        safe_identifier(obj)
        props = definition['properties']
        if definition['key'] not in props:
            raise ValueError(f'{obj}: key must be defined as property')
        for prop, type_name in props.items():
            safe_identifier(prop)
            if type_name not in TYPES:
                raise ValueError(f'{obj}.{prop}: unknown type {type_name!r}')
    for link in spec.get('links', []):
        safe_identifier(link['name'])
        for side in ('from', 'to'):
            if link[side] not in spec['objects']:
                raise ValueError(f'Unknown link {side}: {link[side]}')
    for action, item in spec.get('actions', {}).items():
        safe_identifier(action)
        if any(t not in spec['objects'] for t in item['target']):
            raise ValueError(f'{action}: unknown target')
    for name, val in spec.get('thresholds', {}).items():
        safe_identifier(name)
        if not isinstance(val, (float, int)) or isinstance(val, bool) or val < 0:
            raise ValueError(f'{name}: threshold must be nonnegative number')
    return spec


def generate_sql(spec):
    # Defensive validation even if the generator is called directly.
    for definition in spec['objects'].values():
        for typ in definition['properties'].values():
            if typ not in TYPES:
                raise ValueError(f'Unknown type: {typ}')
    output = ['-- Generated from ontology/ontology.yaml. Do not edit manually.',
              'CREATE EXTENSION IF NOT EXISTS postgis;']
    for name, definition in spec['objects'].items():
        key = definition['key']
        cols = []
        for prop, typ in definition['properties'].items():
            cols.append(f'  {safe_identifier(prop)} {TYPES[typ]}' + (' NOT NULL' if prop == key else ''))
        for attr, typ in [('source_id', 'TEXT'), ('pipeline_version', 'TEXT'),
                          ('created_at', 'TIMESTAMPTZ NOT NULL DEFAULT NOW()'),
                          ('updated_at', 'TIMESTAMPTZ NOT NULL DEFAULT NOW()')]:
            if attr not in definition['properties']:
                cols.append(f'  {safe_identifier(attr)} {typ}')
        cols.append(f'  PRIMARY KEY ({safe_identifier(key)})')
        output.append(f'CREATE TABLE IF NOT EXISTS {safe_identifier(name)} (\n' + ',\n'.join(cols) + '\n);')
    output.append('''CREATE TABLE IF NOT EXISTS ontology_links (
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
);''')
    output.append('CREATE INDEX IF NOT EXISTS ontology_links_source_idx ON ontology_links (from_type, from_id, link_name);')
    output.append('CREATE INDEX IF NOT EXISTS ontology_links_target_idx ON ontology_links (to_type, to_id);')
    return '\n\n'.join(output) + '\n'


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--ontology', default='ontology/ontology.yaml')
    parser.add_argument('--output', default='ontology/generated_schema.sql')
    parser.add_argument('--check', action='store_true', help='validate and verify generated file is current')
    args = parser.parse_args()
    sql = generate_sql(load_and_validate(args.ontology))
    path = Path(args.output)
    if args.check:
        if not path.exists() or path.read_text(encoding='utf-8') != sql:
            raise SystemExit('Schema missing or stale; regenerate with python scripts/ontology.py')
        print('Ontology valid; schema is up to date.')
    else:
        path.write_text(sql, encoding='utf-8')
        print(f'Generated {path}')


if __name__ == '__main__':
    main()
