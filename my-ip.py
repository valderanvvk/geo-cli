"""
This script is designed to get the user's current IP address using the site '2ip.ru '.
The data is output to the console.
"""
import requests
from bs4 import BeautifulSoup

headers = {
    'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) '
                  'Chrome/126.0.0.0 YaBrowser/24.7.0.0 Safari/537.36'
}
location_ip = 'https://2ip.ru'


def get_ip_2ip():
    result = {'is_error': False, 'ip': '', 'error_message': ''}
    try:
        response = requests.get(url=location_ip, headers=headers)
        response.raise_for_status()
        soup = BeautifulSoup(response.text, 'lxml')
        ip = soup.find('div', class_='ip').text.strip()
        result['status_code'] = response.status_code
        result['ip'] = ip
    except requests.exceptions.RequestException as e:
        result['error_message'] = str(e)
        result['is_error'] = True
    return result


def main():
    ip = get_ip_2ip()
    if ip['is_error'] is True:
        print('Request error: {}'.format(ip['error_message']))
        return 0

    print(ip['ip'])


if __name__ == '__main__':
    main()
