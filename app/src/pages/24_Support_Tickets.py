import streamlit as st
import pandas as pd
import requests
from modules.nav import SideBarLinks

SideBarLinks()

API_URL = "http://api:4000/a/SupportTickets"

def fetch_support_tickets():
    """
    Fetch support tickets from the Flask API.
    Returns a Pandas DataFrame if successful, otherwise None.
    """
    try:
        response = requests.get(API_URL)
        response.raise_for_status() 
        tickets = response.json() 
        ticket_data = pd.DataFrame(tickets, columns=["TikNum", "UserID", "StartedAt", "Category", "RespondedAt", "Active", "Text", "Urgency"])
        return ticket_data
    except requests.exceptions.RequestException as e:
        st.error(f"Failed to fetch data from the API: {e}")
        return None

def main():
    """
    Main function to render the Streamlit app.
    """
    st.title("Support Tickets Dashboard")
    st.header("Support Tickets Table")
    st.write("Below is the list of all support tickets.")

    ticket_data = fetch_support_tickets()

    if ticket_data is not None and not ticket_data.empty:
        st.success("Successfully fetched data from the API.")
        st.dataframe(ticket_data)
    else:
        st.warning("No support ticket data available.")

main()
