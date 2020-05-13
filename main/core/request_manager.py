"""Module for requests"""
import json
import requests
from requests_oauthlib import OAuth1


class RequestsManager:
    """Request Manager basic Implementation"""

    def __init__(self, url, key, token, oauth_token):
        self.basic_url = url
        self.headers = {"Accept": "application/json"}
        self.auth = OAuth1(key, token, token, oauth_token)

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
                                        auth=self.auth, params=json.dumps(body))
        return response.status_code, response.json()

    def delete_request(self, http_method, endpoint, body=None):
        """
            Basic Method to delete resources
        """
        # url = f"{self.basic_url}{endpoint}"
        # code to delete resource
