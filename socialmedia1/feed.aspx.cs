using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;

namespace socialmedia1
{
    public partial class Feed : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if user is logged in
            if (Session["UserID"] == null || Session["Username"] == null)
            {
                // User is not logged in, redirect to login page
                Response.Redirect("login.aspx");
                return;
            }

            // Load user profile image
            LoadUserProfileImage();
        }

        private void LoadUserProfileImage()
        {
            try
            {
                int userId = Convert.ToInt32(Session["UserID"]);
                string cs = ConfigurationManager.ConnectionStrings["socialmedia1611"].ConnectionString;

                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = "SELECT profile_pic FROM Users WHERE Id = @Id";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@Id", userId);

                        con.Open();
                        object profilePicResult = cmd.ExecuteScalar();

                        if (profilePicResult != null && !string.IsNullOrEmpty(profilePicResult.ToString()))
                        {
                            // Show base64 image from profile_pic field
                            string base64ImageUrl = "data:image/jpeg;base64," + profilePicResult.ToString();
                            imgFeedProfile.ImageUrl = base64ImageUrl;
                            imgFeedProfile.Visible = true;
                            
                            // Hide default icon
                            Page.ClientScript.RegisterStartupScript(this.GetType(), "HideFeedDefaultIcon", 
                                "document.getElementById('feedDefaultProfileIcon').style.display = 'none';", true);
                        }
                        else
                        {
                            // No profile picture, show Lordicon
                            imgFeedProfile.Visible = false;
                            Page.ClientScript.RegisterStartupScript(this.GetType(), "ShowFeedDefaultIcon", 
                                "document.getElementById('feedDefaultProfileIcon').style.display = 'block';", true);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Log error but don't break the application
                System.Diagnostics.Trace.WriteLine("Error loading profile image: " + ex.Message);
                // Show Lordicon as fallback
                imgFeedProfile.Visible = false;
                Page.ClientScript.RegisterStartupScript(this.GetType(), "ShowFeedDefaultIcon", 
                    "document.getElementById('feedDefaultProfileIcon').style.display = 'block';", true);
            }
        }
    }
}