"""Module for hooks"""
from main.core.utils.boards_api import BoardsAPI
from main.core.utils.member_api import MemberAPI


def use_fixture_by_tag(tag, context):  # pylint: disable=W0613
    """Method to use fixture and filter by a tag value

    Args:
        context (Context): Context
    """
    if 'create.' in tag:
        if 'board' in tag:
            context.board_id = BoardsAPI.create_board("test board create at before tags",
                                                      "test description board")
        elif 'member' in tag:
            BoardsAPI.add_member_to_board(context.board_id, context.newuser_id, "admin")

    elif 'delete.' in tag:
        if 'board' in tag:
            BoardsAPI.delete_board(context.board_id)

    elif 'get.' in tag:
        if 'member' in tag:
            context.info_user = MemberAPI.get_member_inf(
                context.config.userdata['secondary_user_key'],
                context.config.userdata['secondary_user_token'],
                context.config.userdata['secondary_user_oauth_token']
            )
            context.newuser_id = context.info_user['id']
