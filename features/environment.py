"""Environment module for behave"""
from behave.model_core import Status
from main.core.request_manager import RequestsManager
# from features.tools.steps_utils import CreateItems as creator
import features.hooks.use_fixture as use_fixture


def before_all(context):
    """Before_all
    """
    context.rm = RequestsManager(context.config.userdata['url'],
                                 context.config.userdata['key'],
                                 context.config.userdata['token'],
                                 context.config.userdata['oauth_token'])


def before_scenario(context, scenario):  # pylint: disable=W0613
    """Before scenario hook
    """
    print(f"=============Started {scenario.name}")


def after_scenario(context, scenario):  # pylint: disable=W0613
    """After scenario hook if the scenario is failed take a screenshot
    """
    if scenario.status == Status.failed:
        print("============ Ooops Failed scenario {scenario.name}")
    print(f"=============Finished {scenario.name}")


def before_tag(context, tag):
    """Just a simple before_tag hook
    """
    if tag.startswith('fixture.create') or tag.startswith('fixture.get'):
        use_fixture.use_fixture_by_tag(tag, context)
    # if tag not in ('post.boards', 'boards'):
    #     context.board_id = creator.create_board(context.rm)


def after_tag(context, tag):
    """Just a simple after_tag hook
    """
    if tag.startswith("fixture.delete"):
        use_fixture.use_fixture_by_tag(tag, context)
    # if tag not in ('delete.boards', 'boards'):
    #     creator.delete_board(context.rm, context.board_id)


def before_feature(context, feature):  # pylint: disable=W0613
    """Before feature hook
    """


def after_feature(context, feature):  # pylint: disable=W0613
    """after feature hook
    """
