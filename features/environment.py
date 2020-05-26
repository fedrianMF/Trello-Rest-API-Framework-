"""Environment module for behave"""
from behave.fixture import use_fixture_by_tag, fixture_call_params
from behave.model_core import Status
from main.core.request_manager import RequestsManager
from main.core.utils.logger_utils import LoggerUtils
from features.hooks.use_fixture import delete_resource, get_resource_member,\
    post_resource_board, post_resource_card, post_resource_list,\
    put_resource_board, put_resource_card, put_resource_list


def before_all(context):
    """Before_all
    """
    context.logger = LoggerUtils.config_logger('basic_logger')
    context.logger.info('Set primary user credentials')
    context.rm = RequestsManager.get_instance()
    context.id_dictionary = {}


def after_all(context):  # pylint: disable=W0613
    """After all
    """


def before_feature(context, feature):  # pylint: disable=W0613
    """Before feature hook
    """
    context.logger.info(f"=============Started {feature.name}")


def after_feature(context, feature):  # pylint: disable=W0613
    """after feature hook
    """


def before_scenario(context, scenario):  # pylint: disable=W0613
    """Before scenario hook
    """
    context.logger.info(f"=============Started {scenario.name}")


def after_scenario(context, scenario):  # pylint: disable=W0613
    """After scenario hook if the scenario is failed take a screenshot
    """
    context.logger.info(scenario.name)
    context.logger.info(' '.join(scenario.tags))
    if scenario.status == Status.failed:
        context.logger.error(f"============ Failed scenario {scenario.name}")
    else:
        context.logger.info(f"============ Scenario passed {scenario.name}")
    context.logger.info(f"============Finished {scenario.name}\n\n\n")


def before_tag(context, tag):  # pylint: disable=W0613, R1710
    """Just a simple before_tag hook
    """
    if tag.startswith("fixture.create") or tag.startswith("fixture.get")\
            or tag.startswith("fixture.add"):
        return use_fixture_by_tag(tag, context, FIXTURE_REGISTRY)


def after_tag(context, tag):  # pylint: disable=W0613, R1710
    """Just a simple after_tag hook
    """
    if tag.startswith("fixture.delete"):
        return use_fixture_by_tag(tag, context, FIXTURE_REGISTRY)


FIXTURE_REGISTRY = {
    "fixture.get.member": fixture_call_params(get_resource_member,
                                              tag="fixture.get.member"),
    "fixture.create.board": fixture_call_params(post_resource_board,
                                                tag="fixture.create.board",
                                                name="Before Tag Board",
                                                description="Description for Before Tag Board"),
    "fixture.create.list": fixture_call_params(post_resource_list,
                                               tag="fixture.create.list",
                                               name="Before Tag List"),
    "fixture.create.card": fixture_call_params(post_resource_card,
                                               tag="fixture.create.card",
                                               name="Before Tag Card"),
    "fixture.add.member.board": fixture_call_params(put_resource_board,
                                                    type_user="admin"),
    "fixture.add.member.card": fixture_call_params(put_resource_card),
    "fixture.delete.list": fixture_call_params(put_resource_list,
                                               value=True),
    "fixture.delete.board": fixture_call_params(delete_resource,
                                                tag="fixture.delete.board"),
    "fixture.delete.card": fixture_call_params(delete_resource,
                                               tag="fixture.delete.card")
}
