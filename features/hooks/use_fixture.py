"""Module for hooks"""
from main.core.request_manager import RequestsManager
from features.tools.steps_utils import CreateItems as creator


def use_fixture_by_tag(tag, context):  # pylint: disable=W0613
    """Method to use fixture and filter by a tag value

    Args:
        context (Context): Context
    """
    if 'create.' in tag:
        if 'board' in tag:
            context.board_id = creator.create_board(context.rm)
        elif 'member' in tag:
            creator.add_member(context.rm, context.board_id, context.newuser_id)

    elif 'delete.' in tag:
        if 'board' in tag:
            creator.delete_board(context.rm, context.board_id)

    elif 'get.' in tag:
        if 'member' in tag:
            request_manager = RequestsManager(context.config.userdata['url'],
                                              context.config.userdata['otheruser_key'],
                                              context.config.userdata['otheruser_token'],
                                              context.config.userdata['otheruser_oauth_token'])

            context.newuser_id, context.info_user = creator.get_member_inf(request_manager)
            
