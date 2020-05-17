# from enum import Enum
# from main.core.request_manager import RequestsManager
# from main.core.utils.api_constants import HttpMethods

# class Lists:
#     rm = RequestsManager(
#                         'https://api.trello.com/1/',
#                         'b7dc2a47ed291aefddf602a6638a5e0f',
#                         '2849ddb50c19c14b4af499efe20f350ce4e17e36070fb7f35b49a68069edfcfd',
#                         '7cce4e7d5be9d424e7c8efc64572308c5ae15ee840b0a5e75eeb617eb55c2272')

#     @staticmethod
#     def create_list(request_manager, board_id):
#         """ Create a list inside a board

#         :param request_manager: request manager to create a board
#         :type request_manager: RequestManager
#         """
#         auxurl = "/lists"
#         body = {
#             "name": "List create at before tag",
#             "idBoard": board_id
#         }
#         status_code, json_response = request_manager.do_request(HttpMethods.POST.value,   # pylint: disable=W0612
#                                                                 auxurl, body)
#         return json_response['id']

#     @staticmethod
#     def delete_list(request_manager, list_id):
#         """ Delete a list

#         :param request_manager: request manager
#         :type request_manager: RequestManager
#         :param list_id: id of list
#         :type board_id: String
#         """
#         auxurl = "/lists/{id}/closed"
#         auxurl.replace("{id}", list_id)
#         body = {
#             # Error here
#             "value": "true"
#         }
#         request_manager.do_request(HttpMethods.PUT.value, auxurl, body)   # pylint: disable=W0612
