import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks
import requests

st.set_page_config(layout = 'wide')

SideBarLinks() 

#api call
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
        st.error(f"Error updating user: {e}")
        return False 
    
st.title("Start your Journey by giving us important information!") 

st.subheader("Answer the following prompts") 

#year 
valid_fields = [
    "First", "Second", "Third", "Fourth", 
    "Fifth"
]
year = st.selectbox("Select Year:", valid_fields) 

#previous coops 
valid_fields2 = [
    "zero", "one", "two", "three" 
]
prevcoops = st.selectbox("Select Number of Completed Co-ops:", valid_fields2) 

#Paytransparency
valid_fields3 = [
    "yes", "no"
]
pay = st.selectbox("Select Pay Transparency Preference:", valid_fields3) 

#Companies 
comps = st.text_input(f"Enter Company/s for:", "") 

#Skills
skills = st.text_input(f"Enter Skill/s for:", "") 

if st.button("Create New Cooper Customizations"):
    # Validate inputs
    if not year or not prevcoops or not pay or not comps or not skills:
        st.error("Please fill in all fields.")
    else:
        # Call the function to add a new student
        add_status = add_new_student(year, prevcoops, pay, comps, skills)
        if add_status:
            st.success("New Co-op searcher created successfully!")
        else:
            st.error("Failed to create new Co-op searcher.") 