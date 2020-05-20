'''Module for cards'''

from main.core.request_manager import RequestsManager as RM
from main.core.utils.api_constants import HttpMethods


class CardsAPI:
    '''Utils for Cards endpoint'''
    @staticmethod
    def create_card(name, list_id):
        """ Create a card inside a list

        :param request_manager: request manager to create a board
        :type request_manager: RequestManager
        """
        body = {
            "name": name,
            "idList": list_id
        }
        status_code, json_response = RM.get_instance().do_request(HttpMethods.POST.value,  # pylint: disable=W0612
                                                                  "/cards", body)
        return json_response['id']

    @staticmethod
    def delete_card(card_id):
        """ Delete a list

        :param request_manager: request manager
        :type request_manager: RequestManager
        :param list_id: id of list
        :type board_id: String
        """
        endpoint = f"/cards/{card_id}"
        RM.get_instance().do_request(HttpMethods.DELETE.value, endpoint)   # pylint: disable=W0612
