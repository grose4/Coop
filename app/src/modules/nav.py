# Idea borrowed from https://github.com/fsmosca/sample-streamlit-authenticator

# This file has function to add certain functionality to the left side bar of the app

import streamlit as st


#### ------------------------ General ------------------------
def HomeNav():
    st.sidebar.page_link("Home.py", label="Home", icon="🏠")


def AboutPageNav():
    st.sidebar.page_link("pages/30_About.py", label="About", icon="🧠")

### Student on Co-op nav bar links:
def student_on_coop_nav():
    st.sidebar.page_link("pages/40_student_home.py", label='Student on Co-op Home', icon = '🖥️')
    st.sidebar.page_link("pages/41_user_search.py", label='User Search', icon = '🔍')
    st.sidebar.page_link("pages/42_view_profile.py", label='View Profile', icon = '👤')
    st.sidebar.page_link("pages/43_account_settings.py", label='Account Settings', icon = '⚙️')


#### ------------------------ System Admin Role ------------------------
def AdminPageNav():
    selected_page = st.sidebar.radio
    st.sidebar.page_link("pages/20_Admin_Home.py", label="System Admin", icon="🖥️")
    st.sidebar.page_link(
        "pages/21_Admin_User.py", label="Admin User View", icon="🏢"
    )
    st.sidebar.page_link(
        "pages/22_Update_User.py", label = "Update User View", icon="🌺"
    )
    st.sidebar.page_link(
        "pages/23_Delete_User.py", label = "Delete User View", icon="🛜"
    )
    st.sidebar.page_link(
        "pages/24_Support_Tickets.py", label = "Support Tickets Dashboard", icon="🧠"
    )
    st.sidebar.page_link(
        "pages/25_Delete_Tickets.py", label = "Delete Support Tickets", icon="🛜"
    )
    st.sidebar.page_link(
        "pages/26_View_Interactions.py", label = "View Interaction Data", icon="🗺️"
    )
    st.sidebar.page_link(
        "pages/27_Post_Notifications.py", label = "Post Notification", icon="🗺️"
    )

### Employer-specific nav bar links:
def employer_nav():
    st.sidebar.page_link("pages/50_Employer_Home.py", label="Employer Home", icon="🏢")
    st.sidebar.page_link("pages/51_View_Job_Post.py", label="View Job Posts", icon="🔍")
    st.sidebar.page_link("pages/52_Create_Job_Post.py", label="Create Job Post", icon="📝")
    st.sidebar.page_link("pages/53_Manage_Job_Post.py", label="Manage Job Posts", icon="⚙️")

def cooper_nav():
    st.sidebar.page_link("pages/newcooper_home.py", label='Student on Co-op Home', icon = '🖥️')
    st.sidebar.page_link("pages/student_profile.py", label='User Search', icon = '🔍') 
    st.sidebar.page_link("pages/student_account.py", label='View Profile', icon = '👤')
    st.sidebar.page_link("pages/create_cooper.py", label='Create New Account', icon = '📝') 

# --------------------------------Links Function -----------------------------------------------
def SideBarLinks(show_home=False):
    """
    This function handles adding links to the sidebar of the app based upon the logged-in user's role, which was put in the streamlit session_state object when logging in.
    """

    # add a logo to the sidebar always
    st.sidebar.image("assets/logo.png", width=150)

    # If there is no logged in user, redirect to the Home (Landing) page
    if "authenticated" not in st.session_state:
        st.session_state.authenticated = False
        st.switch_page("Home.py")

    if show_home:
        # Show the Home page link (the landing page)
        HomeNav()

    # Show the other page navigators depending on the users' role.
    if st.session_state["authenticated"]:

        # If the user is an administrator, give them access to the administrator pages
        if st.session_state["role"] == "administrator":
            AdminPageNav()

        # if the user is on co-op, give them access to relevant pages
        if st.session_state['role'] == 'student':
            student_on_coop_nav()

        if st.session_state["role"] == "employer":
            employer_nav()

        if st.session_state["role"] == "cooper":
            cooper_nav()

    # Always show the About page at the bottom of the list of links
    AboutPageNav()

    if st.session_state["authenticated"]:
        # Always show a logout button if there is a logged in user
        if st.sidebar.button("Logout"):
            del st.session_state["role"]
            del st.session_state["authenticated"]
            st.switch_page("Home.py")
