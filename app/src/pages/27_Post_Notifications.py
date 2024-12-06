import streamlit as st
import requests
from modules.nav import SideBarLinks

SideBarLinks()

BASE_API_URL = "http://api:4000/a/notifications"

def main():
    st.title("Broadcast Notifications")
    st.subheader("Send Notifications to Specific Users or All Users")

    title = st.text_input("Notification Title", placeholder="Enter notification title")
    message = st.text_area("Notification Message", placeholder="Enter the notification message")

    st.subheader("Recipient Selection")
    user_option = st.radio(
        "Send notification to:",
        ["Specific User", "All Users"]
    )

    user_id = None
    if user_option == "Specific User":
        user_id = st.text_input("User ID", placeholder="Enter the User ID to send the notification to")

    if st.button("Send Notification"):
        if not title or not message:
            st.error("Title and message are required.")
        elif user_option == "Specific User" and not user_id:
            st.error("Please provide a User ID for specific notifications.")
        else:
            recipient_id = user_id if user_option == "Specific User" else None
            success = send_notification(title, message, recipient_id)
            if success:
                st.success("Notification sent successfully!")
            else:
                st.error("Failed to send notification. Please try again.")

def send_notification(title, message, user_id):
    """
    Sends a notification to the API.

    Args:
        title (str): The notification title.
        message (str): The notification message.
        user_id (str or None): The recipient User ID, or None for all users.

    Returns:
        bool: True if successful, False otherwise.
    """
    try:
        payload = {
            "user_id": user_id,
            "title": title,
            "message": message
        }
        response = requests.post(BASE_API_URL, json=payload)
        response.raise_for_status()  
        return True
    except requests.exceptions.RequestException as e:
        st.error(f"Error sending notification: {e}")
        return False

main()
