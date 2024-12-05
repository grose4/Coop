import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks
import requests

st.set_page_config(layout = 'wide')

# Show appropriate sidebar links for the role of the currently logged in user
SideBarLinks()

st.title('Search for Users')

st.write('\n\n') 

# Create a Streamlit form widget
with st.form("add_product_form"):
    
    # create the various input widgets needed for each search field
    industry = st.text_input("Industry")
    skills = st.text_area("Soft Skills")
    tech_skills = st.text_area("Technical Skills")
    
    # add submit button
    submit_button = st.form_submit_button("Search")
    
    # check all fields are filled when form is submitted
    if submit_button:
        if not industry:
            # search by skills instead
            if (not soft_skills) or (not tech_skills):
                st.error("Please complete all fields")
            else:
                logger.info(f"search form submitted with data: {skills}")
            try:
                skills_data = {'soft_skills' : soft_skills, 'tech_skills' : tech_skills}
                # using the requests library to POST to /p/product.  Passing
                # product_data to the endpoint through the json parameter.
                # This particular end point is located in the products_routes.py
                # file found in api/backend/products folder. 
                response = requests.get(f'http://api:4000/a/users/by-skills', json=skills_data)
                if response.status_code == 200:
                    st.success("User serach success!")
                else:
                    st.error(f"Error finding users: {response.text}")
            except requests.exceptions.RequestException as e:
                st.error(f"Error connecting to server: {str(e)}")
            
        #if not product_category:
            #st.error("Please select a product category")
        else:
            logger.info(f"search form submitted with data: {industry}")
            try:
                # using the requests library to POST to /p/product.  Passing
                # product_data to the endpoint through the json parameter.
                # This particular end point is located in the products_routes.py
                # file found in api/backend/products folder. 
                response = requests.get(f'http://api:4000/a/users/{industry}')#, json={'industry':industry})
                if response.status_code == 200:
                    st.success("User serach success!")
                    response.raise_for_status() 
                    users = response.json() 
                    user_data = pd.DataFrame(users, columns=["Name", "Bio", "Occupation", "CompanyName,", "SoftSkills", "TechnicalSkills"])
                    st.dataframe(user_data)
                else:
                    st.error(f"Error finding users: {response.text}")
            except requests.exceptions.RequestException as e:
                st.error(f"Error connecting to server: {str(e)}")

    if user_data is not None and not user_data.empty:
            st.success("Successfully fetched data from the API.")
            st.dataframe(user_data)
    else:
        st.warning("No user data available.")


