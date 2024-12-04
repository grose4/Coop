import streamlit as st
import pandas as pd
import requests

# Set up the base URL for your API
API_URL = "http://web-api:4000/p"

def fetch_users():
    """
    Fetch user data from the REST API.
    Returns a Pandas DataFrame with the user data.
    """
    try:
        response = requests.get(f"{API_URL}/users")
        response.raise_for_status()
        # Assuming the API returns a JSON array of users
        users = response.json()
        return pd.DataFrame(users, columns=['id', 'username', 'email'])
    except requests.RequestException as e:
        st.error(f"Error fetching user data: {e}")
        return pd.DataFrame()  # Return an empty DataFrame on error

def main():
    st.title("User Management Dashboard")
    
    st.header("User Data Table")
    st.write("Below is the list of all users fetched from the REST API.")
    
    # Fetch and display the user data
    user_data = fetch_users()
    if not user_data.empty:
        st.dataframe(user_data)  # Streamlit's dataframe display
    else:
        st.write("No user data available.")

if __name__ == "__main__":
    main()

