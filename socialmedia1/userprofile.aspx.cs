using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Collections.Generic;

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

            // Check if post was just created (after redirect)
            if (Request.QueryString["postcreated"] == "true" && Session["PostCreated"] != null)
            {
                // Show success message
                Page.ClientScript.RegisterStartupScript(this.GetType(), "PostSuccess", 
                    "showPostSuccessMessage();", true);
                
                // Clear session flag
                Session["PostCreated"] = null;
                
                // Clean URL by redirecting without query parameter
                Response.Redirect("userprofile.aspx");
            }

            // Ensure profile_pic column exists in database
            EnsureProfilePicColumnExists();

            // Load fresh user data from database including profile picture
            LoadUserDataFromDatabase();
            
            // Load user activities from database
            LoadUserActivitiesFromDatabase();
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
                                System.Diagnostics.Trace.WriteLine("profile_pic column created automatically");
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Log error but don't break application
                System.Diagnostics.Trace.WriteLine("Error ensuring profile_pic column: " + ex.Message);
            }
        }

        private void LoadUserDataFromDatabase()
        {
            int userId = Convert.ToInt32(Session["UserID"]);
            string cs = ConfigurationManager.ConnectionStrings["socialmedia1611"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"SELECT FirstName, LastName, Email, Username, profile_pic FROM Users WHERE Id = @Id";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Id", userId);

                    con.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
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

        protected void btnCreatePost_Click(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("login.aspx");
                return;
            }

            string postContent = txtPostContent.Text.Trim();
            string mediaUrl = "";
            
            // Handle image upload
            if (fuPostImage.HasFile)
            {
                try
                {
                    // Convert image to base64 for storage
                    using (System.IO.MemoryStream ms = new System.IO.MemoryStream())
                    {
                        fuPostImage.PostedFile.InputStream.CopyTo(ms);
                        byte[] imageBytes = ms.ToArray();
                        string base64String = Convert.ToBase64String(imageBytes);
                        
                        // Create a data URL for the image
                        mediaUrl = "data:image/jpeg;base64," + base64String;
                    }
                }
                catch (Exception ex)
                {
                    // Log error but continue with text-only post
                    System.Diagnostics.Trace.WriteLine("Error uploading post image: " + ex.Message);
                }
            }

            // Validate post content
            if (string.IsNullOrEmpty(postContent) && string.IsNullOrEmpty(mediaUrl))
            {
                // Show error message (you could add a label for this)
                Page.ClientScript.RegisterStartupScript(this.GetType(), "PostError", 
                    "alert('Please add some content or an image to create a post.');", true);
                return;
            }

            int userId = Convert.ToInt32(Session["UserID"]);
            string cs = ConfigurationManager.ConnectionStrings["socialmedia1611"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
                    INSERT INTO Posts (user_id, content, media_url, created_at)
                    VALUES (@UserID, @Content, @MediaUrl, GETDATE())";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@UserID", userId);
                    cmd.Parameters.AddWithValue("@Content", (object)postContent ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("@MediaUrl", (object)mediaUrl ?? DBNull.Value);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            // Clear form
            txtPostContent.Text = "";
            
            // Show success message and redirect to feed to show new post
            Session["PostCreated"] = true;
            Response.Redirect("Feed.aspx");
        }

private void LoadUserActivitiesFromDatabase()
        {
            try
            {
                int userId = Convert.ToInt32(Session["UserID"]);
                string cs = ConfigurationManager.ConnectionStrings["socialmedia1611"].ConnectionString;
                List<string> userPostsJson = new List<string>();

                using (SqlConnection con = new SqlConnection(cs))
                {
                    // Load user's posts from Posts table
                    string postsQuery = "SELECT post_id, content, media_url, created_at FROM Posts WHERE user_id = @UserID ORDER BY created_at DESC";

                    using (SqlCommand cmd = new SqlCommand(postsQuery, con))
                    {
                        cmd.Parameters.AddWithValue("@UserID", userId);

                        con.Open();
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                string content = reader["content"]?.ToString() ?? "Untitled Post";
                                string mediaUrl = reader["media_url"]?.ToString() ?? "";
                                string createdAt = reader["created_at"]?.ToString() ?? DateTime.Now.ToString();
                                
                                // Create post JSON object
                                string postJson = $"{{" +
                                    $"\"id\": {reader["post_id"]}," +
                                    $"\"title\": \"{content.Replace("\"", "\\\"")}\"," +
                                    $"\"description\": \"Posted on {Convert.ToDateTime(createdAt).ToString("MMM dd, yyyy")}\"," +
                                    $"\"image\": \"{mediaUrl}\"," +
                                    $"\"likes\": {new Random().Next(10, 500)}," +
                                    $"\"comments\": {new Random().Next(5, 100)}," +
                                    $"\"shares\": {new Random().Next(1, 50)}" +
                                    $"}}";
                                
                                userPostsJson.Add(postJson);
                            }
                        }
                    }

                    // Register user posts as JavaScript array
                    string postsArray = "[" + string.Join(",", userPostsJson) + "]";

                    Page.ClientScript.RegisterStartupScript(this.GetType(), "UserPosts", 
                        $"window.userPosts = {postsArray};", true);
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "UserReels", 
                        "window.userReels = [];", true);
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "UserSaved", 
                        "window.userSaved = [];", true);
                }
            }
            catch (Exception ex)
            {
                // Log error but don't break the application
                System.Diagnostics.Trace.WriteLine("Error loading user posts: " + ex.Message);
                
                // Register empty arrays as fallback
                Page.ClientScript.RegisterStartupScript(this.GetType(), "UserPosts", 
                    "window.userPosts = [];", true);
                Page.ClientScript.RegisterStartupScript(this.GetType(), "UserReels", 
                    "window.userReels = [];", true);
                Page.ClientScript.RegisterStartupScript(this.GetType(), "UserSaved", 
                    "window.userSaved = [];", true);
            }
        }
    }
}
