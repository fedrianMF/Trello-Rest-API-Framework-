"""Module for hooks"""
from requests_oauthlib import OAuth1
from main.trello.utils.boards_api import BoardsAPI
from main.trello.utils.member_api import MemberAPI
from main.trello.utils.lists_api import ListsAPI
from main.trello.utils.cards_api import CardsAPI
from main.core.request_manager import RequestsManager as RM


def use_fixture_by_tag(tag, context):  # pylint: disable=W0613
    """Method to use fixture and filter by a tag value

    Args:
        context (Context): Context
    """
    if 'create.' in tag:
        if 'board' in tag:
            context.board_id = BoardsAPI.create_board("test board create at before tags",
                                                      "test description board")
        elif 'list' in tag:
            context.list_id = ListsAPI.create_list(context.board_id)
        elif 'card' in tag:
            context.card_id = CardsAPI.create_card(context.list_id)
        elif 'member' in tag:
            BoardsAPI.add_member_to_board(context.board_id, context.newuser_id, "admin")

    elif 'delete.' in tag:
        if 'board' in tag:
            BoardsAPI.delete_board(context.board_id)
        elif 'list' in tag:
            ListsAPI.delete_list(context.list_id)
        elif 'card' in tag:
            CardsAPI.delete_card(context.card_id)

    elif 'get.' in tag:
        if 'member' in tag:
            context.auth_sec = OAuth1(context.config.userdata['secondary_user_key'],
                                      context.config.userdata['secondary_user_token'],
                                      context.config.userdata['secondary_user_token'],
                                      context.config.userdata['secondary_user_oauth_token'])
            context.info_user = MemberAPI.get_member_inf(context.auth_sec)
            context.newuser_id = context.info_user['id']


    def post_resource(context, endpoint, tag, **kwargs):
        """Basic hook to create board, list or card

        :param context: Global context from behave
        :type context: obj
        :param tag: tag to be retrieved
        """
        RM.get_instance().do_request()