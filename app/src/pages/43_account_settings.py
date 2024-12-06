import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks
import requests

def update_user(user_id, field, value):
    try:
        payload = {"field": field, "value": value}
        response = requests.put(f"{BASE_API_URL}/users/{user_id}", json=payload)
        response.raise_for_status() 
        return True
    except requests.exceptions.RequestException as e:
        st.error(f"Error updating user: {e}")
        return False

st.set_page_config(layout = 'wide')

# Show appropriate sidebar links for the role of the currently logged in user
SideBarLinks()

st.title("Update User Information")

st.subheader("Step 1: Select Field to Update")
valid_fields = [
    "Name", "Bio", "Occupation", "Location", 
    "Age", "ReferredBy", "Online"
]
field = st.selectbox("Select the field to update:", valid_fields)

st.subheader("Step 2: Enter New Data")
new_value = st.text_input(f"Enter new value for {field}:", "")

if st.button("Update User"):
    if not user_id or not field or new_value == "":
        st.error("Please fill in all fields.")
    else:
        update_status = update_user(user_id, field, new_value)
        if update_status:
            st.success(f"User {st.session_state['UserID']}'s {field} updated successfully!")
        else:
            st.error(f"Failed to update User {user_id}'s {field}.")

st.header('', divider='red')

if st.button('View Profile', 
            type='primary',
            use_container_width=True):
    st.switch_page('pages/42_view_profile.py')
    

