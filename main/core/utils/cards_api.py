'''Module for cards'''
from main.core.request_manager import RequestsManager
from main.core.utils.api_constants import HttpMethods

RM = RequestsManager(
        'https://api.trello.com/1/',
        'b874df46c1932f121f176125ecc3c52a',
        '01707264bda9655469300c5e744d5b7b1f0bb4aec548191bb8d524190ee380ad',
        'a1104796d5352c73d54794a0eb3bd3daa1a95fb769b253b19b0c1833cfb33679'
    )


class Cards:
    '''Utils for Cards endpoint'''
    @staticmethod
    def create(list_id):
        """ Create a card inside a list

        :param request_manager: request manager to create a board
        :type request_manager: RequestManager
        """
        auxurl = "/cards"
        body = {
            "name": "Card create at before tag",
            "idList": list_id
        }
        status_code, json_response = RM.do_request(HttpMethods.POST.value,  # pylint: disable=W0612
                                                   auxurl, body)
        return json_response['id']

    @staticmethod
    def delete(card_id):
        """ Delete a list

        :param request_manager: request manager
        :type request_manager: RequestManager
        :param list_id: id of list
        :type board_id: String
        """
        auxurl = "/cards/{id}"
        auxurl = auxurl.replace("{id}", card_id)
        RM.do_request(HttpMethods.DELETE.value, auxurl)   # pylint: disable=W0612
