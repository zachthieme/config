"""
If you use Chrome, get Chromedriver and put in your PATH: 
http://chromedriver.chromium.org/downloads

If you use Firefox, get Geckodriver and put in your PATH: 
https://github.com/mozilla/geckodriver/releases

Also install:

pip install requests
pip install selenium
"""

# Generated by Selenium IDE
import pytest
import time
import json
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.support import expected_conditions
from selenium.webdriver.support.wait import WebDriverWait
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities
from selenium.webdriver.chrome.options import Options

chrome_options = Options()
chrome_options.add_argument("--headless")

class TestRebootRouter():
  def setup_method(self, method):
    self.chrome_options = Options()
    self.chrome_options.add_argument("--headless")
    self.driver = webdriver.Chrome(options=self.chrome_options)
    self.driver.implicitly_wait(9)
    self.vars = {}
  
  def teardown_method(self, method):
    self.driver.quit()
  
  def test_rebootRouter(self):
    self.driver.get("http://192.168.12.1/web_whw/")
    self.driver.set_window_size(1097, 1379)
    self.driver.find_element(By.CSS_SELECTOR, ".mat-button-wrapper").click()
    self.driver.find_element(By.ID, "login-dialog-name-placeholder").click()
    self.driver.find_element(By.ID, "login-dialog-name-placeholder").send_keys("admin")
    self.driver.find_element(By.ID, "login-dialog-pass-placeholder").click()
    self.driver.find_element(By.ID, "login-dialog-pass-placeholder").click()
    self.driver.find_element(By.ID, "login-dialog-pass-placeholder").send_keys("{{ tmobile_router }}")
    self.driver.find_element(By.ID, "login-dialog-button-login").click()
    self.driver.find_element(By.LINK_TEXT, "System").click()
    self.driver.find_element(By.ID, "restart").click()
    #self.driver.find_element(By.CSS_SELECTOR, ".nokia-confirm__button").click()
    time.sleep(10)
  
