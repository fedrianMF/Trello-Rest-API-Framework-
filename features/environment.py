"""Environment module for behave"""
from behave.fixture import use_fixture_by_tag, fixture_call_params
from behave.model_core import Status
from main.core.request_manager import RequestsManager
from features.hooks.use_fixture import delete_resource, post_resource_board, post_resource_list,\
                                       get_resource_member, post_resource_card, put_resource_board,\
                                       put_resource_list


def before_all(context):
    """Before_all
    """
    context.rm = RequestsManager.get_instance()


def after_all(context):  # pylint: disable=W0613
    """After all
    """


def before_feature(context, feature):  # pylint: disable=W0613
    """Before feature hook
    """
    print(f"=============Started {feature.name}")


def after_feature(context, feature):  # pylint: disable=W0613
    """after feature hook
    """


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


def before_tag(context, tag):  # pylint: disable=W0613, R1710
    """Just a simple before_tag hook
    """
    if tag.startswith("fixture.create") or tag.startswith("fixture.get"):
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
                                                name="NEW Board",
                                                description="This is a description"),
    "fixture.create.list": fixture_call_params(post_resource_list,
                                               tag="fixture.create.list",
                                               name="List create at before tag"),
    "fixture.create.card": fixture_call_params(post_resource_card,
                                               tag="fixture.create.card",
                                               name="NEW Board"),
    "fixture.create.member": fixture_call_params(put_resource_board,
                                                 type_user="admin"),
    "fixture.put.list": fixture_call_params(put_resource_list,
                                            value=True),
    "fixture.delete.board": fixture_call_params(delete_resource,
                                                tag="fixture.delete.board"),
    "fixture.delete.card": fixture_call_params(delete_resource,
                                               tag="fixture.delete.card")
}
