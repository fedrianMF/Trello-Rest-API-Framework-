"""Module for example steps"""
import time
from behave import step  # pylint: disable=E0611
from assertpy import assert_that
from main.core.utils.api_constants import HttpMethods
from main.core.utils.request_utils import RequestUtils as r_utils


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
    if http_method != HttpMethods.POST.value:
        endpoint += context.board_id
    context.endpoint = endpoint
    context.http_method = http_method
    context.data_table = context.table


@step(u"The request is sent")
def step_impl_send(context):
    """Sends request

    :param context: Global context from behave
    :type context: obj
    """
    time.sleep(5)
    context.status_code, context.json_response = context.rm.do_request(context.http_method,
                                                                       context.endpoint,
                                                                       context.data_table)
    if 'id' in context.json_response:
        context.board_id = context.json_response['id']


@step(u'The status code should be {status_code:d}')
def step_impl_status(context, status_code):
    """Compare status code

    :param context: Global context from behave
    :type context: obj
    :param status_code: status code retrieved
    :type status_code: int
    """
    time.sleep(5)
    assert_that(context.status_code).is_equal_to(status_code)


@step(u'The body response must be contains')
def step_impl_validate_body(context):
    """Validate body response

    :param context: Global context from behave
    :type context: obj
    """
    body_response = r_utils.generate_data(context.table)
    assert_that(body_response.items() <= context.json_response.items(),
                f"Expected that {body_response} is in {context.json_response}").is_true()
