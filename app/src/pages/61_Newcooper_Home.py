import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks

st.set_page_config(layout = 'wide') 

# Show appropriate sidebar links for the role of the currently logged in user
SideBarLinks()

st.title(f"Welcome New Co-op Searcher!, {st.session_state['first_name']}.")
st.write('')
st.write('')
st.write('### What would you like to do today?') 

if st.button('Search for new professional connections', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/41_user_search.py')

if st.button('Edit your student profile', 
             type='primary',
             use_container_width=True):
  st.session_state['profile_view_StuID'] = st.session_state['StuID']
  st.switch_page('pages/64_student_profile.py') 

if st.button('View your Student Account', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/63_student_account.py') 

if st.button('Explore Resources', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/62_resources.py')  
