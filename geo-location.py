"""
This script is designed to get information about the user's current IP address and geodata using the site 'ip-api.com '.
The data is output to the console. The most complete information is displayed.
The output of information can be adjusted in print_fields
"""
import requests
import locale

headers = {
    'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) '
                  'Chrome/126.0.0.0 YaBrowser/24.7.0.0 Safari/537.36'
}

# fields received from the resource
# the most complete information on fields can be found at: https://ip-api.com/docs/api:json
get_fields = 'status,message,country,countryCode,region,regionName,city,district,zip,lat,lon,timezone,isp,org,as,query'

# fields to print
# the fields will be printed in the listed order
print_fields = (
    'query', 'message', 'country', 'countryCode', 'region', 'regionName',
    'city', 'zip', 'lat', 'lon','timezone', 'isp', 'org', 'as')

# default language
language = 'en'
current_locale = locale.getlocale()[0]
if len(current_locale) > 1:
    language = current_locale.split('_')[0]


def get_ip_ipapi():
    url = f'http://ip-api.com/json/?fields={get_fields}&lang={language}'
    try:
        response = requests.get(url=url, headers=headers)
        response.raise_for_status()

        result = response.json()
        return result

    except requests.exceptions.RequestException as e:
        print(f"Error request: {e}")
        return None


def main():
    result = get_ip_ipapi()
    if result is None:
        return 0
    for field in print_fields:
        if field in result:
            if field == 'query':
                print(f'IP: {result[field]}')
            else:
                print(f'{field}: {result[field]}')


if __name__ == "__main__":
    main()

