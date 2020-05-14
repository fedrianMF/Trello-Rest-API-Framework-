from main.core.utils.boolean_utils import BooleanUtils


class RequestUtils:
    """Class defined to request Utils"""

    @staticmethod
    def generate_data(body):
        data = {}
        if body is not None:
            for row in body:
                if row['value'] == 'True' or row['value'] == 'False':
                    data[str(row['key'])] = eval(row['value'])
                elif row['value'].isdigit():
                    data[str(row['key'])] = int(row['value'])
                elif BooleanUtils.is_float(row['value']):
                    data[str(row['key'])] = float(row['value'])
                else:
                    data[str(row['key'])] = row['value']
        return data

    @staticmethod
    def validate_body(body, expected_data):
        # validate body here
        pass
