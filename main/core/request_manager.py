"""Module for requests"""
import requests
from requests import Session
from main.trello.utils.request_utils import RequestUtils as utils


class RequestsManager:  # pylint: disable=R0903
    """Request Manager basic Implementation"""

    __instance = None

    def __init__(self, url, OAuth1):
        self.basic_url = url
        self.headers = {"Accept": "application/json"}
        self.auth = OAuth1
        self.session = Session()

    @staticmethod
    def get_instance(url=None, auth=None):
        """This method get a instance of the RequestsManager class.

        Returns:
            RequestManager -- return a instance of RequestsManager class.
        """
        if RequestsManager.__instance is None:
            RequestsManager.__instance = RequestsManager(url, auth)
        return RequestsManager.__instance

    def do_request(self, http_method, endpoint, body=None, **kwargs):  # pylint: disable=R0913
        """Sends request

        :param http_method: HTTP method
        :type http_method: string
        :param endpoint: Application's endpoint method
        :type endpoint: obj
        """
        auth = self.auth
        self.auth = kwargs.get("auth", self.auth)
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

    def close_session(self):
        """This method close session for RequestsManager class.
        """
        self.session.close()
