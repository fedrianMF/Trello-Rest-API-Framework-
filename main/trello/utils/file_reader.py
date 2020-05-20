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
        return get_json(f'/main/trello/resources/schemas/{file_name}')
        # with open(f'{os.getcwd()}/main/trello/resources/schemas/{file_name}') as archive:
        #     return json.load(archive)

    @staticmethod
    def read_basic_data():
        """ Read a basic data for request

        """
        return get_json('/main/trello/resources/basic_data.json')


def get_json(path):
    """ Read a archive and convert to json data

    :param path: Path of file to read
    :type path: String
    """
    with open(f'{os.getcwd()}{path}') as archive:
        return json.load(archive)
