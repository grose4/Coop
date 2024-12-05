import streamlit as st
import requests
from modules.nav import SideBarLinks


SideBarLinks()



BASE_API_URL = "http://api:4000/a"  

def main():
    st.title("Update User Information")

    st.subheader("Step 1: Select User")
    user_id = st.text_input("Enter UserID to update:", "")

    st.subheader("Step 2: Select Field to Update")
    valid_fields = [
        "Name", "Bio", "Occupation", "Location", 
        "Age", "ReferredBy", "Online", "Admin"
    ]
    field = st.selectbox("Select the field to update:", valid_fields)

    st.subheader("Step 3: Enter New Value")
    new_value = st.text_input(f"Enter new value for {field}:", "")

    if st.button("Update User"):
        if not user_id or not field or new_value == "":
            st.error("Please fill in all fields.")
        else:
            update_status = update_user(user_id, field, new_value)
            if update_status:
                st.success(f"User {user_id}'s {field} updated successfully!")
            else:
                st.error(f"Failed to update User {user_id}'s {field}.")

def update_user(user_id, field, value):
    try:
        payload = {"field": field, "value": value}
        response = requests.put(f"{BASE_API_URL}/users/{user_id}", json=payload)
        response.raise_for_status() 
        return True
    except requests.exceptions.RequestException as e:
        st.error(f"Error updating user: {e}")
        return False

main()
