"""Module for requests"""
import json
import requests
from requests_oauthlib import OAuth1


class RequestsManager:
    """Request Manager basic Implementation"""

    def __init__(self):
        self.basic_url = "https://api.trello.com/1"
        self.headers = {"Accept": "application/json"}
        self.auth = OAuth1('668fe425619b44578f6b5dd9a02e09a4',
                           'c96a92fc1940b3648744f19ab5bca9a3c49213dea7c08f8a5c8bb068b9674183',
                           'c96a92fc1940b3648744f19ab5bca9a3c49213dea7c08f8a5c8bb068b9674183',
                           '68665b1c48cc20381d1c7f3f75f80db7298cba95a02dbc86a564bf9890aa83e8')

    def do_request(self, http_method, endpoint, body=None):
        """Sends request

        :param http_method: HTTP method
        :type http_method: string
        :param endpoint: Application's endpoint method
        :type endpoint: obj
        """
        url = f"{self.basic_url}{endpoint}"
        if http_method == "GET":
            response = requests.request(str(http_method), url, headers=self.headers, auth=self.auth)
        else:
            response = requests.request(str(http_method), url, headers=self.headers,
                                        auth=self.auth, data=json.dumps(body))
        return response.status_code, response.json()

    def delete_request(self, http_method, endpoint, body=None):
        """
            Basic Method to delete resources
        """
        # url = f"{self.basic_url}{endpoint}"
        # code to delete resource
