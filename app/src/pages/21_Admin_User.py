import streamlit as st
import pandas as pd
import requests


# Define the base URL for your Flask API
API_URL = "http://api:4000/a/users"

def fetch_user_data():
    """
    Fetch user data from the Flask API.
    Returns a Pandas DataFrame if successful, otherwise None.
    """
    try:
        response = requests.get(API_URL)
        print(response)  # Debugging: Log the response object
        response.raise_for_status()  # Raise an HTTPError for bad responses
        users = response.json()  # Convert response to JSON
        # Correctly map the API response to DataFrame columns
        user_data = pd.DataFrame(users, columns=["UserID", "Name", "Bio"])
        return user_data
    except requests.exceptions.RequestException as e:
        st.error(f"Failed to fetch user data from the API: {e}")
        return None


def main():
    """
    Main function to render the Streamlit app.
    """
    st.title("User Management Dashboard")
    st.header("User Data Table")
    st.write("Below is the list of all users fetched from the REST API.")

    # Fetch user data from the API
    user_data = fetch_user_data()

    if user_data is not None and not user_data.empty:
        st.success("Successfully fetched data from the API.")
        st.dataframe(user_data)
    else:
        st.warning("No user data available.")

main()