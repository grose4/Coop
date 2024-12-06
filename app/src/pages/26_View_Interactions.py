import streamlit as st
import pandas as pd
import requests
from modules.nav import SideBarLinks  

SideBarLinks()

BASE_API_URL = "http://api:4000/a/interactions"

def main():
    st.title("Interactions Dashboard")
    st.subheader("View All Interactions Data")

    interactions = fetch_interactions()

    if interactions is not None:
        df = pd.DataFrame(interactions)
        
        column_mapping = {
            "InteractionID": "Interaction ID",
            "Type": "Interaction Type",
            "ToUserID": "To User ID",
            "FromUserID": "From User ID",
            "Subject": "Subject",
            "Text": "Message",
            "JobPostingID": "Job Posting ID",
            "Resume": "Resume File"
        }
        df.rename(columns=column_mapping, inplace=True)

        st.dataframe(df, use_container_width=True)
    else:
        st.error("Failed to load interactions data. Please try again later.")

def fetch_interactions():
    try:
        response = requests.get(BASE_API_URL)
        response.raise_for_status()
        return response.json()
    except requests.exceptions.RequestException as e:
        st.error(f"Error fetching interactions data: {e}")
        return None

main()