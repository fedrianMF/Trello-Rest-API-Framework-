"""Module for requests"""
import requests
from requests_oauthlib import OAuth1
from main.core.utils.request_utils import RequestUtils as utils


class RequestsManager:  # pylint: disable=R0903
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
        data = utils.generate_data(body)
        print(data)
        url = f"{self.basic_url}{endpoint}"
        if http_method == "GET":
            response = requests.request(str(http_method), url, headers=self.headers, auth=self.auth)
        elif http_method == "DELETE":
            response = requests.request(str(http_method), url, auth=self.auth)
        else:
            response = requests.request(str(http_method), url,
                                        auth=self.auth, params=body)
        return response.status_code, response.json()
