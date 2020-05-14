"""Module for RequestUtils"""


import ast
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
    def validate_body_schema(body, expected_data):
        """Validatebody with expected_data

        :param body: object to verify
        :type value: string
        :param expected_data: object to compare
        :type value: obj
        """
        # validate body here
        validate(body, schema=expected_data)

    @staticmethod
    def validate_body(body, expected_data):
        """Validatebody with expected_data

        :param value: object to verify
        :type value: obj
        """
        # validate body here
        assert_that(expected_data.items() <= body.items(),
                    f"Expected that {expected_data} is in {body}").is_true()
    # BodyValidator.validate(context.json_response, context.table)
