"""Module for example steps"""
from behave import step  # pylint: disable=E0611
from assertpy import assert_that
from main.core.utils.api_constants import HttpMethods
from main.core.utils.request_utils import RequestUtils as r_utils
from main.trello.utils.file_reader import FileReader


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
    context.http_method = http_method
    context.data_table = context.table
    if http_method != HttpMethods.POST.value:
        if 'board' in endpoint:
            endpoint = endpoint.replace('<board_id>', context.id_dictionary['board'])
        elif 'list' in endpoint:
            endpoint = endpoint.replace('{id}', context.id_dictionary['list'])
        else:
            endpoint = endpoint.replace('{id}', context.id_dictionary['card'])
    elif 'idMembers' in endpoint:
        endpoint = endpoint.replace('{id}', context.id_dictionary['card'])
        context.data_table.add_row(['value', context.id_dictionary['member']])
    else:
        if 'lists' in endpoint:
            context.data_table.add_row(['idBoard', context.id_dictionary['board']])
        elif 'cards' in endpoint:
            context.data_table.add_row(['idList', context.id_dictionary['list']])

    if 'member_id' in endpoint:
        endpoint = endpoint.replace('<member_id>', context.id_dictionary['member'])
    context.endpoint = endpoint


@step(u"The request is sent")
def step_impl_send(context):
    """Sends request

    :param context: Global context from behave
    :type context: obj
    """
    context.status_code, context.json_response = context.rm.do_request(context.http_method,
                                                                       context.endpoint,
                                                                       context.data_table)
    if context.http_method == HttpMethods.POST.value:
        if 'idBoard' in context.json_response and 'idList' in context.json_response:
            context.id_dictionary['card'] = context.json_response['id']
        elif 'idBoard' in context.json_response:
            context.id_dictionary['list'] = context.json_response['id']
        elif 'idOrganization' in context.json_response:
            context.id_dictionary['board'] = context.json_response['id']


@step(u'The status code should be {status_code:d}')
def step_impl_status(context, status_code):
    """Compare status code

    :param context: Global context from behave
    :type context: obj
    :param status_code: status code retrieved
    :type status_code: int
    """
    assert_that(context.status_code).is_equal_to(status_code)


@step(u'The body response must be contains')
def step_impl_validate_body(context):
    """Validate body response

    :param context: Global context from behave
    :type context: obj
    """
    body_response = r_utils.generate_data(context.table)
    if hasattr(context, "info_user"):
        body_response.update(context.info_user)
    assert_that(r_utils.validate_body(body_response, context.json_response),
                f"Expected that {context.json_response} no contains {body_response} items"
                ).is_true()


@step(u'The schema is validated with "{schema}"')
def step_impl_validate_schema(context, schema):
    """Validate body response schema

    :param context: Global context from behave
    :type context: obj
    :param schema: name schema file
    :type schema: String
    """
    json_schema = FileReader.read_schema(schema)
    assert_that(r_utils.validate_body_schema(context.json_response, json_schema),
                f"The response should contains {json_schema}").is_true()
