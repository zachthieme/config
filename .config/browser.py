"""
If you use Chrome, get Chromedriver and put in your PATH: 
http://chromedriver.chromium.org/downloads

If you use Firefox, get Geckodriver and put in your PATH: 
https://github.com/mozilla/geckodriver/releases

Also install:

pip install requests
pip install selenium
pip install PyVirtualDisplay
"""

import requests

from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities
from selenium.webdriver.support.ui import WebDriverWait, Select
from selenium.webdriver.support import expected_conditions as EC
from selenium.common.exceptions import NoSuchElementException, TimeoutException, UnexpectedAlertPresentException
from selenium.webdriver.chrome.service import Service

from pyvirtualdisplay import Display


class Browser(object):
    # initialize with 'chrome' or 'firefox' as the driver 
    def __init__(self, flavor):
        self.display = Display(visible=0, size=(2880, 1800)).start()
        
        if flavor.lower() == "chrome":     
            self.driver = webdriver.Chrome()
            #self.driver = webdriver.Chrome(service=browser_driver)
        elif flavor.lower() == "firefox":
            self.driver = webdriver.Firefox()
        else:
            raise Exception("need to specify 'chrome' or firefox' when creating a Browser")
    
    
    def transfer_to_requests(self):
        headers = {
                "User-Agent":"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.157 Safari/537.36"
                }
        self.session = requests.session()
        self.session.headers.update(headers)
        for cookie in self.driver.get_cookies():
            c = {cookie['name']: cookie['value']}
            self.session.cookies.update(c)
            
        return self.session
    
#page_to_scrape = webdriver.Chrome(service=browser_driver)

# example usage
b = Browser("chrome")
b.driver.get("https://www.google.com")
