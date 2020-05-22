'''Module for cards manage'''

from main.core.request_manager import RequestsManager
from main.core.utils.api_constants import HttpMethods


class CardsAPI:
    '''Utils for Cards endpoint'''
    @staticmethod
    def create_card(list_id):
        """ Create a card inside a list

        :param list_id: list id to create new cards
        :type list_id: String
        """
        request_manager = RequestsManager()
        body = {
            "name": "Card create at before tag",
            "idList": list_id
        }
        status_code, json_response = request_manager.do_request(HttpMethods.POST.value,  # pylint: disable=W0612
                                                                "/cards", body)
        return json_response['id']

    @staticmethod
    def delete_card(card_id):
        """ Delete a list

        :param list_id: id of list
        :type board_id: String
        """
        request_manager = RequestsManager()
        endpoint = "/cards/{id}"
        endpoint = endpoint.replace("{id}", card_id)
        request_manager.do_request(HttpMethods.DELETE.value, endpoint)   # pylint: disable=W0612
