import streamlit as st
from streamlit_extras.app_logo import add_logo
from modules.nav import SideBarLinks
from modules.nav import SideBarLinks


SideBarLinks()

st.write("# About this App")

st.markdown (
    """
    This is a Co-Op Search & Networking App for our CS 3200 Course Project.  

    The goal of this app is to provide an easier way for students and
    faculty alike to network and find the perfect co-op.

    Stay tuned for more information and features to come!
    """
        )
