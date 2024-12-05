import logging
import streamlit as st
import pandas as pd
import requests

logger = logging.getLogger(__name__)

# Correctly define the API URL as a string
API_URL = "http://api:4000/users"

def main():
    st.title("User Management Dashboard")

    st.header("User Data Table")
    st.write("Below is the list of all users fetched from the REST API.")

    try:
        # Make the API call with the correct URL
        response = requests.get(API_URL)
        response.raise_for_status()  # Raise an HTTPError for bad status codes
        users = response.json()  # Parse the JSON response

        # Convert the response to a DataFrame
        user_data = pd.DataFrame(users, columns=["id", "username", "email"])
        st.write("Successfully fetched data from the API.")
        
        # Display the user data in a table
        if not user_data.empty:
            st.dataframe(user_data)
        else:
            st.write("No user data available.")
    except requests.exceptions.RequestException as e:
        # Handle any errors during the API request
        st.error(f"Failed to fetch user data from the API: {e}")
        logger.error(f"API request failed: {e}")

main()
