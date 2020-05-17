"""Module for RequestUtils"""


import ast
import jsonschema
from jsonschema import validate
from assertpy import assert_that
from main.core.utils.boolean_utils import BooleanUtils


class RequestUtils:
    """Class defined to request Utils"""

    @staticmethod
    def generate_data(body):
        """Generate structure of value for body

        :param body: string to structure
        :type value: string
        """
        data = {}
        if body is not None:
            for row in body:
                if row['value'] == 'True' or row['value'] == 'False':
                    data[str(row['key'])] = ast.literal_eval(row['value'])
                elif row['value'].isdigit():
                    data[str(row['key'])] = int(row['value'])
                elif BooleanUtils.is_float(row['value']):
                    data[str(row['key'])] = float(row['value'])
                else:
                    data[str(row['key'])] = row['value']
        return data

    @staticmethod
    def validate_body_schema(json_response, json_schema):
        """Validatebody with expected_data

        :param body: object to verify
        :type value: string
        :param expected_data: object to compare
        :type value: obj
        """
        try:
            validate(instance=json_response, schema=json_schema)
        except jsonschema.exceptions.ValidationError as err:
            return False
        return True

    @staticmethod
    def validate_body(expected_body, response_data):
        """Validatebody with expected_data

        :param value: object to verify
        :type value: obj
        """
        for key, value in expected_body.items():
            if not has_value(response_data, value):
                return False
        return True


def has_value(obj, val):
    if isinstance(obj, dict):
        values = obj.values()
    elif isinstance(obj, list):
        values = obj
    if val in values:
        return True
    for v in values:
        if isinstance(v, (dict, list)) and has_value(v, val):
            return True
    return False
