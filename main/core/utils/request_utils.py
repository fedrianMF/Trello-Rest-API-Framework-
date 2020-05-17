"""Module for RequestUtils"""


import ast
import jsonschema
from jsonschema import validate
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
        except jsonschema.exceptions.ValidationError:
            return False
        return True

    @staticmethod
    def validate_body(expected_body, response_data):
        """Validatebody with expected_data

        :param value: object to verify
        :type value: obj
        """
        for value in expected_body.values():
            if not has_value(response_data, value):
                return False
        return True


def has_value(obj, val):
    """Verify if the val is in the object

    :param obj: object to verify
    :type onj: obj
    :param val: value to verify
    :type val: obj
    """
    if isinstance(obj, dict):
        values = obj.values()
    elif isinstance(obj, list):
        values = obj
    if val in values:
        return True
    for current_val in values:
        if isinstance(current_val, (dict, list)) and has_value(current_val, val):
            return True
    return False
