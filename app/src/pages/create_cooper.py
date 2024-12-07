import logging
import streamlit as st
from modules.nav import SideBarLinks
import requests

logger = logging.getLogger(__name__)
st.set_page_config(layout='wide')

SideBarLinks()

# API call
def add_new_student(year, prevcoops, pay, comps, skills):
    try:
        payload = {
            "Year": year,
            "NumPreviousCoOps": prevcoops,
            "PayTransparency": pay,
            "Companies": comps,
            "bio": skills
        }
        response = requests.post("http://api:4000/aaa/student/create", json=payload)
        response.raise_for_status()
        return True
    except requests.exceptions.RequestException as e:
        st.error(f"Error creating user: {e}")
        return False

st.title("Start your Journey by giving us important information!")
st.subheader("Answer the following prompts")

# Year (as a number)
year = st.number_input("Enter your current year (e.g., 1 for First Year, 2 for Second Year):", min_value=1, max_value=5, step=1)

# Previous Co-ops (as a number)
prevcoops = st.number_input("Enter the number of completed Co-ops (e.g., 0, 1, 2):", min_value=0, max_value=3, step=1)

# Pay Transparency
pay = st.radio("Do you prefer pay transparency?", options=["Yes", "No"])
pay = True if pay == "Yes" else False

# Companies
comps = st.text_input("Enter the companies you are interested in (comma-separated):", "")

# Skills
skills = st.text_input("Enter your skills (comma-separated):", "")

if st.button("Create New Co-op Customizations"):
    # Validate inputs
    if not comps or not skills:
        st.error("Please fill in all fields.")
    else:
        # Call the function to add a new student
        add_status = add_new_student(year, prevcoops, pay, comps, skills)
        if add_status:
            st.success("New Co-op searcher created successfully!")
        else:
            st.error("Failed to create new Co-op searcher.")
