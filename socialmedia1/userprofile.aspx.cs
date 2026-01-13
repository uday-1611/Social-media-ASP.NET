using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace socialmedia1
{
    public partial class userprofile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Always get user data from Session so refresh shows current details
            string username = Session["Username"] as string;
            string firstName = Session["FirstName"] as string;
            string lastName = Session["LastName"] as string;
            string email = Session["Email"] as string;

            if (!string.IsNullOrEmpty(username))
            {
                lblUsername.Text = username;
            }

            // Display full name if available, otherwise fall back to username
            if (!string.IsNullOrEmpty(firstName) || !string.IsNullOrEmpty(lastName))
            {
                string fullName = (firstName + " " + lastName).Trim();
                lblName.Text = fullName;
            }
            else if (!string.IsNullOrEmpty(username))
            {
                lblName.Text = username;
            }

            if (!string.IsNullOrEmpty(email))
            {
                lblEmail.Text = email;
            }

            // Profile image: use uploaded path from Session if available, otherwise default avatar
            string profileImageUrl = Session["ProfileImageUrl"] as string;
            if (string.IsNullOrEmpty(profileImageUrl))
            {
                profileImageUrl = "https://i.pravatar.cc/400";
            }
            imgProfile.ImageUrl = profileImageUrl;
        }
    }
}
