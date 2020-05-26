"""Module for hooks"""
from behave import fixture
from requests_oauthlib import OAuth1
from main.trello.api.boards_api import BoardsAPI
from main.trello.api.member_api import MemberAPI
from main.trello.api.lists_api import ListsAPI
from main.trello.api.cards_api import CardsAPI
from main.core.utils.api_constants import HttpMethods
from main.core.request_manager import RequestsManager as RM


@fixture
def get_resource_member(context, tag):
    """Basic hook to get information from a Member

    :param context: Global context from behave
    :type context: obj
    :param tag: tag to be retrieved
    """
    type_data = tag.split('.')[-1]
    context.auth_sec = OAuth1(context.config.userdata['secondary_user_key'],
                              context.config.userdata['secondary_user_token'],
                              context.config.userdata['secondary_user_token'],
                              context.config.userdata['secondary_user_oauth_token'])
    context.info_user = MemberAPI.get_member_inf(context.auth_sec)
    context.id_dictionary[type_data] = context.info_user['id']


@fixture
def post_resource_board(context, tag, name, description):
    """Basic hook to create a Board

    :param context: Global context from behave
    :type context: obj
    :param tag: tag to be retrieved
    :param name: name of Board
    :type name: String
    :param description: description of Board
    :type description: String
    """
    type_data = tag.split('.')[-1]
    context.id_dictionary[type_data] = BoardsAPI.create_board(name, description)


@fixture
def post_resource_list(context, tag, name):
    """Basic hook to create a List

    :param context: Global context from behave
    :type context: obj
    :param tag: tag to be retrieved
    :param name: name of List
    :type name: String
    """
    type_data = tag.split('.')[-1]
    context.id_dictionary[type_data] = ListsAPI.create_list(name, context.id_dictionary['board'])


@fixture
def post_resource_card(context, tag, name):
    """Basic hook to create Card

    :param context: Global context from behave
    :type context: obj
    :param tag: tag to be retrieved
    :param name: name of Card
    :type name: String
    """
    type_data = tag.split('.')[-1]
    context.id_dictionary[type_data] = CardsAPI.create_card(name, context.id_dictionary['list'])


@fixture
def put_resource_board(context, type_user):
    """Basic hook to add a Member to a Board

    :param context: Global context from behave
    :type context: obj
    :param type_user: type of user
    :type type_user: String
    """
    BoardsAPI.add_member_to_board(context.id_dictionary['board'], context.id_dictionary['member'],
                                  type_user)


@fixture
def put_resource_card(context):
    """Basic hook to add a Member to a Card

    :param context: Global context from behave
    :type context: obj
    """
    CardsAPI.add_member_to_card(context.id_dictionary['card'], context.id_dictionary['member'])


@fixture
def put_resource_list(context, value):
    """Basic hook to archive a List

    :param context: Global context from behave
    :type context: obj
    :param value: value for archive a List
    :type value: boolean
    """
    ListsAPI.archive_list(context.id_dictionary['list'], value)


@fixture
def delete_resource(context, tag):
    """Basic hook to delete board or card

    :param context: Global context from behave
    :type context: obj
    :param tag: tag to be retrieved
    """
    type_data = tag.split('.')[-1]
    endpoint = "/" + type_data + "s/" + context.id_dictionary[type_data]
    RM.get_instance().do_request(HttpMethods.DELETE.value, endpoint)
