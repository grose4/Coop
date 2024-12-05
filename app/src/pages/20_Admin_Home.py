import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks
import requests

st.set_page_config(layout = 'wide')

SideBarLinks()

st.title('System Admin Home Page')

if st.button('View Full User Data', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/21_Admin_User.py')

if st.button('Update User Data', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/22_Update_User.py')