import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks
import requests

st.set_page_config(layout = 'wide')

SideBarLinks()

st.title('System Admin Home Page')

with st.container():
    col1, col2 = st.columns(2)

if st.button('View Full User Data', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/21_Admin_User.py')

if st.button('Update User Data', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/22_Update_User.py')

if st.button('Delete a User', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/23_Delete_User.py')

if st.button('Support Tickets Dashboard', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/24_Support_Tickets.py')

if st.button('Delete Support Ticket', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/25_Delete_Tickets.py')

if st.button('View Interaction Data', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/26_View_Interactions.py')