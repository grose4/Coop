import streamlit as st
import pandas as pd
import requests
from modules.nav import SideBarLinks  # Assuming this is your navigation module

# Set up Sidebar Links
SideBarLinks()

# Base API URL
BASE_API_URL = "http://api:4000/a"

def main():
    st.title("Support Tickets")
    st.subheader("View All Support Tickets")

    # Fetch Support Tickets from API
    tickets = fetch_support_tickets()

    if tickets is not None:
        # Convert tickets to DataFrame
        df = pd.DataFrame(tickets)
        
        # Map column names for better readability
        column_mapping = {
            "TikNum": "Ticket Number",
            "UserID": "User ID",
            "StartedAt": "Started At",
            "Category": "Category",
            "RespondedAt": "Responded At",
            "Active": "Active",
            "Text": "Description",
            "Urgency": "Urgency Level"
        }
        df.rename(columns=column_mapping, inplace=True)
        
        # Display DataFrame as a Streamlit Table
        st.dataframe(df, use_container_width=True)
    else:
        st.error("Failed to load support tickets. Please try again later.")

def fetch_support_tickets():
    try:
        response = requests.get(f"{BASE_API_URL}/SupportTickets")
        response.raise_for_status()
        return response.json()
    except requests.exceptions.RequestException as e:
        st.error(f"Error fetching support tickets: {e}")
        return None

if __name__ == "__main__":
    main()
