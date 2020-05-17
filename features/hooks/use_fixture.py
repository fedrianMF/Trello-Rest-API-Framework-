"""Module for hooks"""
from main.core.utils.boards_api import Boards
from main.core.utils.member_api import Member


def use_fixture_by_tag(tag, context):  # pylint: disable=W0613
    """Method to use fixture and filter by a tag value

    Args:
        context (Context): Context
    """
    if 'create.' in tag:
        if 'board' in tag:
            context.board_id = Boards.create_board("test board create at before tags",
                                                   "test description board")
            context.board_id = creator.create_board(context.rm)
        elif 'list' in tag:
            context.list_id = creator.create_list(context.rm, context.board_id)
        elif 'member' in tag:
            Member.add_member(context.board_id, context.newuser_id, "admin")

    elif 'delete.' in tag:
        if 'board' in tag:
            Boards.delete_board(context.board_id)
            creator.delete_board(context.rm, context.board_id)
        elif 'list' in tag:
            creator.delete_list(context.rm, context.list_id)

    elif 'get.' in tag:
        if 'member' in tag:
            context.info_user = Member.get_member_inf(
                context.config.userdata['secondary_user_key'],
                context.config.userdata['secondary_user_token'],
                context.config.userdata['secondary_user_oauth_token']
            )
            context.newuser_id = context.info_user['id']
