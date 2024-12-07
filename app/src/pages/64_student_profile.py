import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks
import requests

st.set_page_config(layout = 'wide')

SideBarLinks()


#create info
#api call
st.title("Are you New to Coop? Create your Customizations!")
if st.button('Create New Cooper Customizations',  
            type='primary',
            use_container_width=True):
    st.switch_page('pages/60_create_cooper.py')  


#update info
#api call
def update_stu(stu_id, field, value):
    try:
        payload = {"field": field, "value": value}
        response = requests.put(f"http://api:4000/aaa/student/{stu_id}", json=payload)
        response.raise_for_status() 
        return True
    except requests.exceptions.RequestException as e: 
        st.error(f"Error updating user: {e}")
        return False
    

st.title("Update Existing Student Information") 

st.subheader("Step 1: Select Field to Update")
valid_fields = [
    "Year", "NumPreviousCoOps", "PayTransparency", "Companies", 
    "Skills"
]
field = st.selectbox("Select the field to update:", valid_fields)

st.subheader("Step 2: Enter New Student Data")
new_value = st.text_input(f"Enter new value for {field}:", "")

if st.button("Update Student Information"):
    if not field or new_value == "":
        st.error("Please fill in all fields.")
    else:
        update_status = update_stu(st.session_state['StuID'], field, new_value)
        if update_status:
            st.success(f"New Co-op searcher {st.session_state['StuID']}'s {field} updated successfully!")
        else:
            st.error(f"Failed to update Student {stu_id}'s {field}.") 
