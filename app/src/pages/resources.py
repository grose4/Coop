import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks

st.set_page_config(layout = 'wide') 

# Show appropriate sidebar links for the role of the currently logged in user
SideBarLinks()

st.title(f"Welcome to the resources page! Here we will give you some neat pointers on how to be successful in the industry. Stay tuned for more to come!")
