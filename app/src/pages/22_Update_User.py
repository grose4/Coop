import streamlit as st
import requests

# Define API endpoint
BASE_API_URL = "http://127.0.0.1:4000"  # Update with your actual Flask API base URL

# Streamlit App
def main():
    st.title("Update User Information")

    # Step 1: Enter UserID to search for the user
    st.subheader("Search for User")
    user_id = st.text_input("Enter UserID to update:", "")

    if user_id:
        if st.button("Fetch User Info"):
            user_details = fetch_user_details(user_id)
            if user_details:
                edit_user_form(user_details)
            else:
                st.error("User not found! Please check the UserID.")

# Function to fetch user details from the API
def fetch_user_details(user_id):
    try:
        response = requests.get(f"{BASE_API_URL}/a/users")  # Adjust endpoint if needed
        response.raise_for_status()
        users = response.json()

        # Find the user by UserID
        user_details = next((user for user in users if str(user['UserID']) == user_id), None)
        return user_details
    except requests.exceptions.RequestException as e:
        st.error(f"Error fetching user data: {e}")
        return None

# Function to render the edit form and call the update API
def edit_user_form(user_details):
    st.subheader("Edit User Information")

    # Pre-fill the form fields with the existing user details
    name = st.text_input("Name", user_details.get("Name", ""))
    bio = st.text_area("Bio", user_details.get("Bio", ""))
    occupation = st.text_input("Occupation", user_details.get("Occupation", ""))
    location = st.text_input("Location", user_details.get("Location", ""))
    age = st.number_input("Age", min_value=0, max_value=120, value=user_details.get("Age", 0))
    referred_by = st.text_input("Referred By", str(user_details.get("ReferredBy", "")))
    online = st.checkbox("Online", value=user_details.get("Online", False))
    admin = st.checkbox("Admin", value=user_details.get("Admin", False))

    # Submit updated information
    if st.button("Update User"):
        update_status = update_user_api(
            user_id=user_details["UserID"],
            name=name,
            bio=bio,
            occupation=occupation,
            location=location,
            age=age,
            referred_by=referred_by,
            online=online,
            admin=admin
        )
        if update_status:
            st.success("User updated successfully!")
        else:
            st.error("Failed to update user.")

# Function to call the REST API to update user information
def update_user_api(user_id, name, bio, occupation, location, age, referred_by, online, admin):
    try:
        # Create the JSON payload for the API call
        payload = {
            "UserID": user_id,
            "Name": name,
            "Bio": bio,
            "Occupation": occupation,
            "Location": location,
            "Age": age,
            "ReferredBy": referred_by if referred_by else None,
            "Online": online,
            "Admin": admin
        }

        # Send the PUT request to the API
        response = requests.put(f"{BASE_API_URL}/users", json=payload)
        response.raise_for_status()  # Raise an error if the status is not 200
        return True
    except requests.exceptions.RequestException as e:
        st.error(f"Error updating user: {e}")
        return False

if __name__ == "__main__":
    main()
