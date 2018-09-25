from lib.data.record import Record
import unittest


class RecordTest(unittest.TestCase):
    def test_serialize_and_deserialize__has_same_and_correct_values(self):
        record = Record.from_json(Record(
            name="random name",
            description="random description",
            url="random URL",
            user="random user",
            key="random key"
        ).to_json())

        self.assertEqual(record.name, 'random name')
        self.assertEqual(record.description, 'random description')
        self.assertEqual(record.url, 'random URL')
        self.assertEqual(record.user, 'random user')
        self.assertEqual(record.key, 'random key')
