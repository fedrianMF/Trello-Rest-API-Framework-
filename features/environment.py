"""Environment module for behave"""
from behave.model_core import Status
from requests_oauthlib import OAuth1
from main.core.request_manager import RequestsManager
import features.hooks.use_fixture as use_fixture


def before_all(context):
    """Before_all
    """
    context.auth_main = OAuth1(context.config.userdata['primary_user_key'],
                               context.config.userdata['primary_user_token'],
                               context.config.userdata['primary_user_token'],
                               context.config.userdata['primary_user_oauth_token'])
    context.rm = RequestsManager.get_instance(context.config.userdata['url'], context.auth_main)


def before_scenario(context, scenario):  # pylint: disable=W0613
    """Before scenario hook
    """
    print(f"=============Started {scenario.name}")


def after_scenario(context, scenario):  # pylint: disable=W0613
    """After scenario hook if the scenario is failed take a screenshot
    """
    if scenario.status == Status.failed:
        print("============ Ooops Failed scenario {scenario.name}")
    print(f"\n=============Finished {scenario.name}\n\n\n")


def before_tag(context, tag):
    """Just a simple before_tag hook
    """
    if tag.startswith('fixture.create') or tag.startswith('fixture.get'):
        use_fixture.use_fixture_by_tag(tag, context)


def after_tag(context, tag):
    """Just a simple after_tag hook
    """
    if tag.startswith("fixture.delete"):
        use_fixture.use_fixture_by_tag(tag, context)


def before_feature(context, feature):  # pylint: disable=W0613
    """Before feature hook
    """


def after_feature(context, feature):  # pylint: disable=W0613
    """after feature hook
    """
