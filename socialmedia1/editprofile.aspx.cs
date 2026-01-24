using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;

namespace socialmedia1
{
    public partial class editprofile : System.Web.UI.Page
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

            if (!IsPostBack)
            {
                LoadUserData();
            }
        }

        private void EnsureProfilePicColumnExists()
        {
            try
            {
                string cs = ConfigurationManager.ConnectionStrings["socialmedia1611"].ConnectionString;

                using (SqlConnection con = new SqlConnection(cs))
                {
                    // Check if profile_pic column exists
                    string checkQuery = @"
                        SELECT COUNT(*) 
                        FROM INFORMATION_SCHEMA.COLUMNS 
                        WHERE TABLE_NAME = 'Users' 
                        AND COLUMN_NAME = 'profile_pic'";

                    using (SqlCommand cmd = new SqlCommand(checkQuery, con))
                    {
                        con.Open();
                        int columnExists = (int)cmd.ExecuteScalar();
                        
                        if (columnExists == 0)
                        {
                            // Column doesn't exist, create it
                            string createColumnQuery = "ALTER TABLE Users ADD profile_pic VARCHAR(MAX) NULL";
                            
                            using (SqlCommand createCmd = new SqlCommand(createColumnQuery, con))
                            {
                                createCmd.ExecuteNonQuery();
                                // Optional: Log that column was created
                                System.Diagnostics.Trace.WriteLine("profile_pic column created automatically");
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Log error but don't break the application
                System.Diagnostics.Trace.WriteLine("Error ensuring profile_pic column: " + ex.Message);
            }
        }

        private void LoadUserData()
        {
            int userId = Convert.ToInt32(Session["UserID"]);
            
            string cs = ConfigurationManager.ConnectionStrings["socialmedia1611"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"SELECT FirstName, LastName, Email, Username, Phone, profile_pic FROM Users WHERE Id = @Id";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Id", userId);

                    con.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            txtFirstName.Text = reader["FirstName"].ToString();
                            txtLastName.Text = reader["LastName"].ToString();
                            txtEmail.Text = reader["Email"].ToString();
                            txtUsername.Text = reader["Username"].ToString();
                            txtPhone.Text = reader["Phone"].ToString();

                            // Handle profile image from database
                            string profilePic = reader["profile_pic"] as string;
                            if (!string.IsNullOrEmpty(profilePic))
                            {
                                // Show base64 image
                                string base64ImageUrl = "data:image/jpeg;base64," + profilePic;
                                Session["ProfileImageUrl"] = base64ImageUrl;
                                
                                Page.ClientScript.RegisterStartupScript(this.GetType(), "ShowEditProfileImage", 
                                    $"document.getElementById('editProfileImage').src = '{base64ImageUrl}'; " +
                                    "document.getElementById('editProfileImage').style.display = 'block'; " +
                                    "document.getElementById('editDefaultProfileIcon').style.display = 'none';", true);
                            }
                            else
                            {
                                // Show Lordicon
                                Session["ProfileImageUrl"] = null;
                                Page.ClientScript.RegisterStartupScript(this.GetType(), "ShowEditDefaultIcon", 
                                    "document.getElementById('editDefaultProfileIcon').style.display = 'block'; " +
                                    "document.getElementById('editProfileImage').style.display = 'none';", true);
                            }
                        }
                    }
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            if (Session["UserID"] == null)
            {
                Response.Redirect("login.aspx");
                return;
            }

            int userId = Convert.ToInt32(Session["UserID"]);
            string base64Image = null;

            // Handle profile image upload (optional)
            if (fuProfileImage.HasFile)
            {
                try
                {
                    // Convert image to base64
                    using (System.IO.MemoryStream ms = new System.IO.MemoryStream())
                    {
                        fuProfileImage.PostedFile.InputStream.CopyTo(ms);
                        byte[] imageBytes = ms.ToArray();
                        base64Image = Convert.ToBase64String(imageBytes);
                    }
                }
                catch
                {
                    // If image conversion fails, ignore and keep existing image
                }
            }

            string firstName = txtFirstName.Text.Trim();
            string lastName = txtLastName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string username = txtUsername.Text.Trim();
            string phone = txtPhone.Text.Trim();

            string cs = ConfigurationManager.ConnectionStrings["socialmedia1611"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
UPDATE Users
SET FirstName = @FirstName,
    LastName = @LastName,
    Email = @Email,
    Username = @Username,
    Phone = @Phone";

                // Add profile_pic to query if image was uploaded
                if (base64Image != null)
                {
                    query += ", profile_pic = @ProfilePic";
                }

                query += " WHERE Id = @Id";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@FirstName", firstName);
                    cmd.Parameters.AddWithValue("@LastName", lastName);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Username", username);
                    cmd.Parameters.AddWithValue("@Phone", (object)phone ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("@Id", userId);

                    if (base64Image != null)
                    {
                        cmd.Parameters.AddWithValue("@ProfilePic", base64Image);
                    }

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            // Update session with new profile image if uploaded
            if (base64Image != null)
            {
                Session["ProfileImageUrl"] = "data:image/jpeg;base64," + base64Image;
            }

            Session["FirstName"] = firstName;
            Session["LastName"] = lastName;
            Session["Email"] = email;
            Session["Username"] = username;

            Response.Redirect("userprofile.aspx");
        }
    }
}