using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Collections.Generic;

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
            
            // Load all posts for feed
            LoadPosts();
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

        private void LoadPosts()
        {
            try
            {
                string cs = ConfigurationManager.ConnectionStrings["socialmedia1611"].ConnectionString;
                List<string> feedPostsJson = new List<string>();

                using (SqlConnection con = new SqlConnection(cs))
                {
                    // Load all posts with user information
                    string postsQuery = @"
                        SELECT p.post_id, p.user_id, p.content, p.media_url, p.created_at, 
                               u.Username, u.FirstName, u.LastName, u.profile_pic
                        FROM Posts p
                        INNER JOIN Users u ON p.user_id = u.Id
                        ORDER BY p.created_at DESC";

                    using (SqlCommand cmd = new SqlCommand(postsQuery, con))
                    {
                        con.Open();
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                string content = reader["content"]?.ToString() ?? "";
                                string mediaUrl = reader["media_url"]?.ToString() ?? "";
                                string createdAt = reader["created_at"]?.ToString() ?? DateTime.Now.ToString();
                                string username = reader["Username"]?.ToString() ?? "Unknown";
                                string firstName = reader["FirstName"]?.ToString() ?? "";
                                string lastName = reader["LastName"]?.ToString() ?? "";
                                string profilePic = reader["profile_pic"]?.ToString() ?? "";
                                
                                // Get user display name
                                string displayName = (!string.IsNullOrEmpty(firstName) || !string.IsNullOrEmpty(lastName)) 
                                    ? $"{firstName} {lastName}".Trim() 
                                    : username;
                                
                                // Create post JSON object
                                string postJson = $"{{" +
                                    $"\"id\": {reader["post_id"]}," +
                                    $"\"userId\": {reader["user_id"]}," +
                                    $"\"username\": \"{username.Replace("\"", "\\\"")}\"," +
                                    $"\"displayName\": \"{displayName.Replace("\"", "\\\"")}\"," +
                                    $"\"content\": \"{content.Replace("\"", "\\\"")}\"," +
                                    $"\"image\": \"{mediaUrl}\"," +
                                    $"\"profilePic\": \"{(!string.IsNullOrEmpty(profilePic) ? "data:image/jpeg;base64," + profilePic : "")}\"," +
                                    $"\"createdAt\": \"{Convert.ToDateTime(createdAt).ToString("MMM dd, yyyy HH:mm")}\"," +
                                    $"\"likes\": {new Random().Next(10, 500)}," +
                                    $"\"comments\": {new Random().Next(5, 100)}," +
                                    $"\"shares\": {new Random().Next(1, 50)}" +
                                    $"}}";
                                
                                feedPostsJson.Add(postJson);
                            }
                        }
                    }

                    // Register feed posts as JavaScript array
                    string postsArray = "[" + string.Join(",", feedPostsJson) + "]";

                    Page.ClientScript.RegisterStartupScript(this.GetType(), "FeedPosts", 
                        $"window.feedPosts = {postsArray};", true);
                }
            }
            catch (Exception ex)
            {
                // Log error but don't break the application
                System.Diagnostics.Trace.WriteLine("Error loading feed posts: " + ex.Message);
                
                // Register empty array as fallback
                Page.ClientScript.RegisterStartupScript(this.GetType(), "FeedPosts", 
                    "window.feedPosts = [];", true);
            }
        }
    }
}