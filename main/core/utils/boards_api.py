from main.core.request_manager import RequestsManager
from main.core.utils.api_constants import HttpMethods

rm = RequestsManager(
        'https://api.trello.com/1/',
        'b874df46c1932f121f176125ecc3c52a',
        '01707264bda9655469300c5e744d5b7b1f0bb4aec548191bb8d524190ee380ad',
        'a1104796d5352c73d54794a0eb3bd3daa1a95fb769b253b19b0c1833cfb33679'
    )

class Boards:

    @staticmethod
    def create_board(name, desc):
        """ Create a board

        :param request_manager: request manager to create a board
        :type request_manager: RequestManager
        """
        body = {
            "name": name,
            "desc": desc
        }
        status_code, json_response = rm.do_request(HttpMethods.POST.value,   # pylint: disable=W0612
                                                                "/boards/", body)
        return json_response['id']

    @staticmethod
    def delete_board(board_id):
        """ Create a board

        :param request_manager: request manager to create a board
        :type request_manager: RequestManager
        :param board_id: request manager to create a board
        :type board_id: String
        """
        endpoint = "/boards/" + board_id
        rm.do_request(HttpMethods.DELETE.value, endpoint)
