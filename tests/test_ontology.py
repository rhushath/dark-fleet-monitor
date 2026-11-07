import copy
import unittest
from pathlib import Path
from scripts.ontology import load_and_validate, generate_sql

ROOT = Path(__file__).resolve().parents[1]

class TestOntology(unittest.TestCase):
    def setUp(self):
        self.spec = load_and_validate(ROOT / 'ontology/ontology.yaml')

    def test_sql_is_deterministic(self):
        self.assertEqual(generate_sql(self.spec), generate_sql(self.spec))

    def test_schema_is_current(self):
        self.assertEqual(generate_sql(self.spec), (ROOT / 'ontology/generated_schema.sql').read_text())

    def test_every_link_has_valid_object_types(self):
        for link in self.spec['links']:
            self.assertIn(link['from'], self.spec['objects'])
            self.assertIn(link['to'], self.spec['objects'])

    def test_key_is_required(self):
        self.assertIn('imo', self.spec['objects']['Vessel']['properties'])
        self.assertIn('UnresolvedAISIdentity', self.spec['objects'])

    def test_all_derived_events_have_rule_versions(self):
        for name in ('DarkGap', 'SpoofingEvent', 'ShipToShipEvent', 'LoiteringEvent'):
            self.assertIn('rule_version', self.spec['objects'][name]['properties'])

    def test_invalid_type_rejected(self):
        broken = copy.deepcopy(self.spec)
        broken['objects']['Vessel']['properties']['imo'] = 'something_else'
        with self.assertRaises(ValueError):
            generate_sql(broken)

if __name__ == '__main__':
    unittest.main()
