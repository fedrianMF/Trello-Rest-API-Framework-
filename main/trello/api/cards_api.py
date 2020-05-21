'''Module for cards'''

from main.core.request_manager import RequestsManager as RM
from main.core.utils.api_constants import HttpMethods


class CardsAPI:
    '''Utils for Cards endpoint'''
    @staticmethod
    def create_card(name, list_id):
        """ Create a card inside a list

        :param list_id: list id to create new cards
        :type list_id: String
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

        :param list_id: id of list
        :type board_id: String
        """
        endpoint = f"/cards/{card_id}"
        RM.get_instance().do_request(HttpMethods.DELETE.value, endpoint)   # pylint: disable=W0612

    @staticmethod
    def add_member_to_card(card_id, member_id):
        """ Delete a list

        :param card_id: card id to add a member
        :type card_id: String
        :param member_id: Member id for add to card
        :type board_id: String
        """
        endpoint = f"/cards/{card_id}/idMembers"
        body = {
            "value": member_id
        }
        RM.get_instance().do_request(HttpMethods.POST.value, endpoint, body)   # pylint: disable=W0612
