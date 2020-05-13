"""Module for example steps"""
from behave import step  # pylint: disable=E0611
from assertpy import assert_that


@step(u'Defines "{http_method}" request to "{endpoint}"')
def step_retrieve_numbers_dt(context, http_method, endpoint):
    """Sample step to retrieve numbers

    :param context: Global context from behave
    :type context: obj
    :param http_method: HTTP method
    :type http_method: string
    :param endpoint: Application's endpoint method
    :type endpoint: obj
    """
    context.endpoint = endpoint
    context.http_method = http_method


@step(u"The request is sent")
def step_impl_send(context):
    """Sends request

    :param context: Global context from behave
    :type context: obj
    """
    context.status_code, context.json_response = context.rm.do_request(context.http_method,
                                                                       context.endpoint)


@step(u'The status code should be {status_code:d}')
def step_impl_status(context, status_code):
    """Sends request

    :param context: Global context from behave
    :type context: obj
    :param status_code: status code retrieved
    :type status_code: int
    """
    assert_that(context.status_code).is_equal_to(status_code)
