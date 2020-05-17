"""Module for file manage"""
import os
import json


class FileReader:   # pylint: disable=R0903
    """Utils for read and manage files"""
    @staticmethod
    def read_schema(file_name):
        """ Read a schema form json file

        :param file_name: name of file to read
        :type file_name: String
        """
        with open(f'{os.getcwd()}/schemas/{file_name}') as archive:
            return json.load(archive)
