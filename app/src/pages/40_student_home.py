import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks

st.set_page_config(layout = 'wide')

# Show appropriate sidebar links for the role of the currently logged in user
SideBarLinks()

st.title(f"Welcome Student, {st.session_state['first_name']}.")
st.write('')
st.write('')
st.write('### What would you like to do today?')

if st.button('Search for users', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/41_user_search.py')

if st.button('View my profile', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/42_view_profile.py')

if st.button('Account Settings', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/43_account_settings.py')