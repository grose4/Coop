import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks 
import requests

st.set_page_config(layout = 'wide')

SideBarLinks()  

st.title("This is your official account!") 
st.subheader("On this page you are able to give feedback, access professional resources, and delete your account") 

st.subheader("Please fill out the following feedback questions")
valid_fields2 = [
    "zero", "one", "two", "three", "four", "five"
]
enjoyment = st.selectbox("On a scale from 0-5, how are you enjoying this website?:", valid_fields2) 

valid_fields = [
    "Yes", "No"
]
needs = st.selectbox("Do you feel like this website meets all of your needs?:", valid_fields)   

experience = st.text_input(f"Give us details about your user experience:", "")  

if st.button('Explore our Resources',  
            type='primary',
            use_container_width=True):
    st.switch_page('pages/resources.py')   

if st.button('Delete Your Account', 
             type='primary',
             use_container_width=True):
    user_id = st.session_state['StuID']

    try:
        response = requests.delete(f"http://api:4000/aaa/student/delete/{user_id}")
        response.raise_for_status()
        delete_status = True
    except requests.exceptions.RequestException as e:
        st.error(f"Error deleting User: {e}")
        delete_status = False
    
    if delete_status:
        st.success(f"User with ID {user_id} deleted successfully!")
    else:
        st.error(f"Failed to delete user with ID {user_id}.")

    st.switch_page('Home.py') 