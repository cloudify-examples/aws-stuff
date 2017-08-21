
from cloudify_rest_client.client import CloudifyClient
from cloudify_rest_client.exceptions import CloudifyClientError
from cloudify_cli.utils import generate_progress_handler
from requests.exceptions import ConnectionError
from time import sleep


def get_client(_host, _username, _password, _tenant):
    config = {
        'host': _host,
        'username': _username,
        'password': _password,
        'tenant': _tenant
    }
    return CloudifyClient(**config)


def check_api(
        client_callable,
        arguments=None,
        _progress_handler=None):

    try:
        if isinstance(arguments, dict):
            response = \
                client_callable(**arguments)
        elif arguments is None:
            response = client_callable()
        elif _progress_handler is not None:
            response = \
                client_callable(
                    arguments,
                    progress_callback=_progress_handler)
        else:
            response = \
                client_callable(arguments)
    except ConnectionError as e:
        sleep(5)
        return check_api(client_callable, arguments, _progress_handler)
    except CloudifyClientError as e:
        if e.status_code == 502:
            sleep(5)
            return check_api(client_callable, arguments, _progress_handler)
        else:
            sleep(5)
            return
    else:
        sleep(5)
        return response
    return


def cfy_manager_config_handler(event, context):
    event = event or {}

    client = get_client(
        event.get('address'),
        event.get('username', 'admin'),
        event.get('password', 'admin'),
        event.get('tenant', 'default_tenant'))

    while check_api(client.manager.get_status) is False:
        sleep(5)

    for secret in event.get('secrets', {}):
        check_api(client.secrets.create, secret)

    for plugin in event.get('plugins', []):
        upload_handler = generate_progress_handler(plugin, '')
        check_api(client.plugins.upload, plugin, _progress_handler=upload_handler)
