"""Module for requests"""
import requests
from requests_oauthlib import OAuth1
from main.core.utils.request_utils import RequestUtils as utils


def singleton(cls):
    """ Singleton

        :param cls: class to instance
        :type cls: class
    """
    instance = dict()

    def wrap(*args, **kwargs):
        if cls not in instance:
            instance[cls] = cls(*args, **kwargs)
        return instance[cls]
    return wrap


@singleton
class RequestsManager:  # pylint: disable=R0903
    """Request Manager basic Implementation"""

    def __init__(self, url=None, key=None, token=None, oauth_token=None):
        self.basic_url = url
        self.headers = {"Accept": "application/json"}
        self.auth = OAuth1(key, token, token, oauth_token)

    def do_request(self, http_method, endpoint, body=None,  # pylint: disable=R0913
                   key=None, token=None, oauth_token=None):
        """Sends request

        :param http_method: HTTP method
        :type http_method: string
        :param endpoint: Application's endpoint method
        :type endpoint: obj
        :param body: body of request
        :type endpoint: String
        """
        auth = self.auth
        if token:
            self.auth = OAuth1(key, token, token, oauth_token)
        if not isinstance(body, dict):
            body = utils.generate_data(body)
        url = f"{self.basic_url}{endpoint}"
        if http_method == "GET":
            response = requests.request(str(http_method), url, headers=self.headers, auth=self.auth)
        elif http_method == "DELETE":
            response = requests.request(str(http_method), url, auth=self.auth)
        else:
            response = requests.request(str(http_method), url,
                                        auth=self.auth, params=body)
        self.auth = auth
        return response.status_code, response.json()
