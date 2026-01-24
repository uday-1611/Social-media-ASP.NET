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
            // Check if user is logged in
            if (Session["UserID"] == null || Session["Username"] == null)
            {
                // User is not logged in, redirect to login page
                Response.Redirect("login.aspx");
                return;
            }

            // Ensure profile_pic column exists in database
            EnsureProfilePicColumnExists();

            // Load fresh user data from database including profile picture
            LoadUserDataFromDatabase();
        }

        private void EnsureProfilePicColumnExists()
        {
            try
            {
                string cs = System.Configuration.ConfigurationManager.ConnectionStrings["socialmedia1611"].ConnectionString;

                using (System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection(cs))
                {
                    // Check if profile_pic column exists
                    string checkQuery = @"
                        SELECT COUNT(*) 
                        FROM INFORMATION_SCHEMA.COLUMNS 
                        WHERE TABLE_NAME = 'Users' 
                        AND COLUMN_NAME = 'profile_pic'";

                    using (System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(checkQuery, con))
                    {
                        con.Open();
                        int columnExists = (int)cmd.ExecuteScalar();
                        
                        if (columnExists == 0)
                        {
                            // Column doesn't exist, create it
                            string createColumnQuery = "ALTER TABLE Users ADD profile_pic VARCHAR(MAX) NULL";
                            
                            using (System.Data.SqlClient.SqlCommand createCmd = new System.Data.SqlClient.SqlCommand(createColumnQuery, con))
                            {
                                createCmd.ExecuteNonQuery();
                                // Optional: Log that column was created
                                System.Diagnostics.Trace.WriteLine("profile_pic column created automatically in userprofile");
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Log error but don't break the application
                System.Diagnostics.Trace.WriteLine("Error ensuring profile_pic column in userprofile: " + ex.Message);
            }
        }

        private void LoadUserDataFromDatabase()
        {
            int userId = Convert.ToInt32(Session["UserID"]);
            string cs = System.Configuration.ConfigurationManager.ConnectionStrings["socialmedia1611"].ConnectionString;

            using (System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection(cs))
            {
                string query = @"SELECT FirstName, LastName, Email, Username, profile_pic FROM Users WHERE Id = @Id";

                using (System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Id", userId);

                    con.Open();
                    using (System.Data.SqlClient.SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            // Update session with fresh data
                            string username = reader["Username"].ToString();
                            string firstName = reader["FirstName"].ToString();
                            string lastName = reader["LastName"].ToString();
                            string email = reader["Email"].ToString();

                            Session["Username"] = username;
                            Session["FirstName"] = firstName;
                            Session["LastName"] = lastName;
                            Session["Email"] = email;

                            // Display user information
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

                            // Handle profile image from database
                            string profilePic = reader["profile_pic"] as string;
                            if (!string.IsNullOrEmpty(profilePic))
                            {
                                // Show base64 image
                                string base64ImageUrl = "data:image/jpeg;base64," + profilePic;
                                Session["ProfileImageUrl"] = base64ImageUrl;
                                imgProfile.ImageUrl = base64ImageUrl;
                                imgProfile.Visible = true;
                            }
                            else
                            {
                                // Show Lordicon
                                Session["ProfileImageUrl"] = null;
                                imgProfile.Visible = false;
                                Page.ClientScript.RegisterStartupScript(this.GetType(), "ShowDefaultIcon", 
                                    "document.getElementById('defaultProfileIcon').style.display = 'block';", true);
                            }
                        }
                    }
                }
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            // Clear all session variables
            Session.Clear();
            Session.Abandon();
            
            // Redirect to login page
            Response.Redirect("login.aspx");
        }
    }
}
