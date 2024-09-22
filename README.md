# IP Geolocation information CLI

>Displaying information about the current IP or full GEO IP information

## The utilities work with 2 free resources:
 * 2ip.ru
 * ip-api.com

`ip-info` - Displaying information about the IP address (only the IP is displayed)

`location` - Displaying the full GEO information of the user

## Installation
> The installation script supports only Linux, MacOS 

Python is required for the utility to work. The installation script suggests creating a virtual environment (venv) and installing dependencies.

The user can install dependencies himself using any package manager and environment he needs.

### Automatic installation
```bash
git clone https://github.com/valderanvvk/geo-cli.git
cd geo-cli
./install.sh
```
Follow the installation instructions


### Manual installation
 - check the installation pip (`sudo apt install python3.10-pip`)
 - check the installation venv (`sudo apt install python3.10-venv`)

1) Go to the installation directory and clone the repository:
```bash
git clone https://github.com/valderanvvk/geo-cli.git
cd geo-cli
```
2) Create a new virtual environment:
```bash
python3 -m venv venv
source venv/bin/acivate
```
3) Install dependencies:
`pip install -r requirements.txt`

4) Add aliases into $HOME/.bash_aliases:

`alias ip-info='bash <YOUR_INSTALLATION_DIR>/get-ip.sh'`

`alias location='bash <YOUR_INSTALLATION_DIR>/get-location.sh'`


   