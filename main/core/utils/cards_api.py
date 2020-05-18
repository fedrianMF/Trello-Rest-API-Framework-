'''Module for cards'''

from main.core.request_manager import RequestsManager
from main.core.utils.api_constants import HttpMethods


class Cards:
    '''Utils for Cards endpoint'''
    @staticmethod
    def create(list_id):
        """ Create a card inside a list

        :param request_manager: request manager to create a board
        :type request_manager: RequestManager
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
    def delete(card_id):
        """ Delete a list

        :param request_manager: request manager
        :type request_manager: RequestManager
        :param list_id: id of list
        :type board_id: String
        """
        request_manager = RequestsManager()
        auxurl = "/cards/{id}"
        auxurl = auxurl.replace("{id}", card_id)
        request_manager.do_request(HttpMethods.DELETE.value, auxurl)   # pylint: disable=W0612
