import streamlit as st
import requests
from modules.nav import SideBarLinks

SideBarLinks()

BASE_API_URL = "http://api:4000/a/SupportTickets"  

def main():
    st.title("Delete Support Ticket")

    st.subheader("Enter the TikNum to Delete")
    TikNum = st.text_input("TikNum", "")

    if st.button("Delete Ticket"):
        if TikNum.strip() == "":
            st.error("TikNum cannot be empty.")
        else:
            delete_status = delete_tik(TikNum)
            if delete_status:
                st.success(f"Ticket with ID {TikNum} deleted successfully!")
            else:
                st.error(f"Failed to delete Ticket with ID {TikNum}.")

def delete_tik(TikNum):
    try:
        response = requests.delete(f"{BASE_API_URL}/{TikNum}")
        response.raise_for_status()
        return True
    except requests.exceptions.RequestException as e:
        st.error(f"Error deleting Ticket: {e}")
        return False

main()
