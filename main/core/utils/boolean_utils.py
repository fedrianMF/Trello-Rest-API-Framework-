"""Module for booleans"""


class BooleanUtils:     # pylint: disable=R0903
    """Class defined to Boolean Utils"""

    @staticmethod
    def is_float(value):
        """Verify if value is boolean

        :param value: object to verify
        :type value: obj
        """
        try:
            float(value)
            return True
        except ValueError:
            return False
