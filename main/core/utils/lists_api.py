'''Module for lists'''
from main.core.request_manager import RequestsManager
from main.core.utils.api_constants import HttpMethods

RM = RequestsManager(
        'https://api.trello.com/1/',
        'b874df46c1932f121f176125ecc3c52a',
        '01707264bda9655469300c5e744d5b7b1f0bb4aec548191bb8d524190ee380ad',
        'a1104796d5352c73d54794a0eb3bd3daa1a95fb769b253b19b0c1833cfb33679'
    )


class Lists:
    '''Utils for List endpoint'''
    @staticmethod
    def create(board_id):
        """ Create a list inside a board

        :param board_id: id of Board where list will create
        :type board_id: String
        """
        auxurl = "/lists"
        body = {
            "name": "List create at before tag",
            "idBoard": board_id
        }
        status_code, json_response = RM.do_request(HttpMethods.POST.value,  # pylint: disable=W0612
                                                   auxurl, body)
        return json_response['id']

    @staticmethod
    def delete(list_id):
        """ Delete a list

        :param request_manager: request manager
        :type request_manager: RequestManager
        :param list_id: id of list
        :type board_id: String
        """
        auxurl = "/lists/{id}/closed"
        auxurl.replace("{id}", list_id)
        body = {
            # Error here
            "value": "true"
        }
        RM.do_request(HttpMethods.PUT.value, auxurl, body)   # pylint: disable=W0612
