"""Module for file manage"""
import os
import json
from configparser import ConfigParser


class FileReader:   # pylint: disable=R0903
    """Utils for read and manage files"""
    @staticmethod
    def read_schema(file_name):
        """ Read a schema form json file

        :param file_name: name of file to read
        :type file_name: String
        """
        with open(f'{os.getcwd()}/main/trello/resources/schemas/{file_name}') as archive:
            return json.load(archive)

    @staticmethod
    def read_basic_data():
        """ Read a basic data for request

        """
        data = {}
        config = ConfigParser()
        config.read(f"{os.getcwd()}/behave.ini")
        data['url'] = config.get("behave.userdata", "url")
        data['primary_user_key'] = config.get("behave.userdata", "primary_user_key")
        data['primary_user_token'] = config.get("behave.userdata", "primary_user_token")
        data['primary_user_oauth_token'] = config.get("behave.userdata", "primary_user_oauth_token")
        return data
