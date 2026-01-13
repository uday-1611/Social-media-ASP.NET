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
            if (!IsPostBack)
            {
                LoadUserData();
            }
        }

        private void LoadUserData()
        {
            // (Session["UserID"] == null)
            // {
            //     Response.Redirect("login.aspx");
            //     return;
            // }
y
            int userId = Convert.ToInt32(Session["UserID"]);
            // Handle profile image upload (optional)
            if (fuProfileImage.HasFile)
            {
                try
                {
                    string ext = Path.GetExtension(fuProfileImage.FileName);
                    string fileName = $"user_{userId}{ext}";
                    string folder = Server.MapPath("~/Uploads/ProfileImages");

                    if (!Directory.Exists(folder))
                    {
                        Directory.CreateDirectory(folder);
                    }

                    string fullPath = Path.Combine(folder, fileName);
                    fuProfileImage.SaveAs(fullPath);

                    string virtualPath = "~/Uploads/ProfileImages/" + fileName;
                    Session["ProfileImageUrl"] = virtualPath;
                }
                catch
                {
                    // If image save fails, ignore and keep existing image
                }
            }

            string cs = ConfigurationManager.ConnectionStrings["socialmedia1611"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"SELECT FirstName, LastName, Email, Username, Phone FROM Users WHERE Id = @Id";

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
            // Handle profile image upload (optional)
            if (fuProfileImage.HasFile)
            {
                try
                {
                    string ext = Path.GetExtension(fuProfileImage.FileName);
                    string fileName = $"user_{userId}{ext}";
                    string folder = Server.MapPath("~/Uploads/ProfileImages");

                    if (!Directory.Exists(folder))
                    {
                        Directory.CreateDirectory(folder);
                    }

                    string fullPath = Path.Combine(folder, fileName);
                    fuProfileImage.SaveAs(fullPath);

                    string virtualPath = "~/Uploads/ProfileImages/" + fileName;
                    Session["ProfileImageUrl"] = virtualPath;
                }
                catch
                {
                    // If image save fails, ignore and keep existing image
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
    Phone = @Phone
WHERE Id = @Id";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@FirstName", firstName);
                    cmd.Parameters.AddWithValue("@LastName", lastName);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Username", username);
                    cmd.Parameters.AddWithValue("@Phone", (object)phone ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("@Id", userId);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            Session["FirstName"] = firstName;
            Session["LastName"] = lastName;
            Session["Email"] = email;
            Session["Username"] = username;

            Response.Redirect("userprofile.aspx");
        }
    }
}