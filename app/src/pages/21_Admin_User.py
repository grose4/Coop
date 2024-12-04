import streamlit as st
import pandas as pd
import requests

API_URL = "http://web-api:4000/p"

def fetch_users():
    """
    Fetch user data from the REST API.
    Returns a Pandas DataFrame with the user data.
    """
        response = requests.get(f"{API_URL}/users")
        response.raise_for_status()
        users = response.json()
        return pd.DataFrame(users, columns=['id', 'username', 'email'])

def main():
    st.title("User Management Dashboard")
    
    st.header("User Data Table")
    st.write("Below is the list of all users fetched from the REST API.")
    
    user_data = fetch_users()
    if not user_data.empty:
        st.dataframe(user_data) 
    else:
        st.write("No user data available.")

main()
