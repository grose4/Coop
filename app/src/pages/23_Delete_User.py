import streamlit as st
import requests
from modules.nav import SideBarLinks
SideBarLinks()

BASE_API_URL = "http://api:4000/a/users"  

def main():
    st.title("Delete User")

    st.subheader("Enter the UserID to Delete")
    user_id = st.text_input("UserID", "")

    if st.button("Delete User"):
        if not user_id:
            st.error("Please enter a valid UserID.")
        else:
            delete_status = delete_user(user_id)
            if delete_status:
                st.success(f"User with ID {user_id} deleted successfully!")
            else:
                st.error(f"Failed to delete user with ID {user_id}.")

def delete_user(user_id):
    try:
        response = requests.delete(f"{BASE_API_URL}?id={user_id}")
        response.raise_for_status()
        return True
    except requests.exceptions.RequestException as e:
        st.error(f"Error deleting user: {e}")
        return False


main()
