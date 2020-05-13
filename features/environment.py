"""Environment module for behave"""
from behave.model_core import Status
from main.core.request_manager import RequestsManager
#from features.core.example import Example


def before_all(context):
    """Before_all
    """
    #context.example = Example()
    context.rm = RequestsManager(context.config.userdata['url'])
    print(context.rm)


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


def before_feature(context, feature):  # pylint: disable=W0613
    """Before feature hook
    """


def after_feature(context, feature):  # pylint: disable=W0613
    """after feature hook
    """
