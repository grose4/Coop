import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks
import requests

st.set_page_config(layout = 'wide')

# Show appropriate sidebar links for the role of the currently logged in user
SideBarLinks()

def fetch_user_data(UserID):
    """
    Fetch user data from the Flask API.
    Returns a Pandas DataFrame if successful, otherwise None.
    """
    try:
        response = requests.get("http://api:4000/aa/users/view/" + str(UserID))
        response.raise_for_status() 
        user_data = response.json()
        return user_data
    except requests.exceptions.RequestException as e:
        st.error(f"Failed to fetch user data from the API: {e}")
        return None

def main():
    """
    Main function to render the Streamlit app.
    """
    if st.session_state['UserID'] == st.session_state['profile_view_UserID']:
        user_data = fetch_user_data(st.session_state['UserID'])[0]
        st.header(st.session_state['first_name'], divider='red')
    else:
        user_data = fetch_user_data(st.session_state['profile_view_UserID'])[0]
        st.header(user_data['Name'], divider='red')

    for key, value in user_data.items():
        if value is None:
            user_data[key] = 'none'
    
    if user_data['Online']:
        status = 'Online'
    else:
        status = 'Offline'
    
    col1, col2, col3 = st.columns([1, .1, 1])
    
    with col1:
        st.write('###### Bio:', user_data['Bio'])
        st.write('###### Location:', user_data['Location'])
        st.write('###### Age:', str(user_data['age']))
        if st.session_state['UserID'] == st.session_state['profile_view_UserID']:
            st.write('###### Reffered By:', user_data['ReferredBy'])
    
    with col3:
        st.write('###### NU College:', user_data['NUCollege'])
        st.write('###### Industry:', user_data['Industry'])
        st.write('###### Occupation:', user_data['Occupation'])
        st.write('###### Online Status:', status)

    
    st.header('', divider='red')
    if st.session_state['UserID'] == st.session_state['profile_view_UserID']:
        if st.button('Edit Account', 
                    type='primary',
                    use_container_width=True):
            st.switch_page('pages/43_account_settings.py')
    else:
        if st.button('Back to User Search', type='primary', use_container_width=True):
            st.session_state['profile_view_UserID'] = st.session_state['UserID']
            st.switch_page('pages/41_user_search.py')
        

main()