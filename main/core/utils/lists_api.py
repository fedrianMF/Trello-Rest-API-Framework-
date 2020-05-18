'''Module for lists'''

from main.core.request_manager import RequestsManager
from main.core.utils.api_constants import HttpMethods


class Lists:
    '''Utils for List endpoint'''
    @staticmethod
    def create(board_id):
        """ Create a list inside a board

        :param board_id: id of Board where list will create
        :type board_id: String
        """
        request_manager = RequestsManager()
        body = {
            "name": "List create at before tag",
            "idBoard": board_id
        }
        status_code, json_response = request_manager.do_request(HttpMethods.POST.value,  # pylint: disable=W0612
                                                                "/lists", body)
        return json_response['id']

    @staticmethod
    def delete(list_id):
        """ Delete a list

        :param request_manager: request manager
        :type request_manager: RequestManager
        :param list_id: id of list
        :type board_id: String
        """
        request_manager = RequestsManager()
        auxurl = "/lists/{id}/closed"
        auxurl.replace("{id}", list_id)
        body = {
            # Error here
            "value": "true"
        }
        request_manager.do_request(HttpMethods.PUT.value, auxurl, body)   # pylint: disable=W0612
