import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks

st.set_page_config(layout='wide')
SideBarLinks()

st.title('Employer Home')

if st.button('View Job Posts', 
             type='primary', 
             use_container_width=True):
    st.switch_page('pages/51_View_Job_Post.py')

if st.button('Create Job Post', 
             type='primary', 
             use_container_width=True):
    st.switch_page('pages/52_Create_Job_Post.py')

if st.button('Update Job Post', 
             type='primary', 
             use_container_width=True):
    st.switch_page('pages/53_Manage_Job_Post.py')

if st.button('Delete Job Post', 
             type='primary', 
             use_container_width=True):
    st.switch_page('pages/53_Manage_Job_Post.py')
