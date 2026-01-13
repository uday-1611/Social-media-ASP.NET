using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;

namespace socialmedia1611
{
    public partial class login : System.Web.UI.Page
    {
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            // Read login inputs
            string email = txtLoginId.Text.Trim();    // registered email
            string password = txtPassword.Text.Trim();

            // If empty, do nothing
            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
            {
                return;
            }

            // Hash password same as in register.aspx.cs
            string hashedPassword = HashPassword(password);
            string cs = ConfigurationManager.ConnectionStrings["socialmedia1611"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
SELECT Id, FirstName, LastName, Email, Username
FROM Users
WHERE Email = @Email AND Password = @Password";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Password", hashedPassword);

                    con.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            // Get registered user details and store in Session
                            Session["UserID"] = reader["Id"];
                            Session["FirstName"] = reader["FirstName"];
                            Session["LastName"] = reader["LastName"];
                            Session["Email"] = reader["Email"];
                            Session["Username"] = reader["Username"];

                            // Redirect to feed page on successful login
                            Response.Redirect("feed.aspx");
                        }
                        // If no match, stay on page silently
                    }
                }
            }
        }

        // 🔐 SHA256 Password Hashing (same as Register)
        private string HashPassword(string password)
        {
            using (SHA256 sha = SHA256.Create())
            {
                byte[] bytes = sha.ComputeHash(Encoding.UTF8.GetBytes(password));
                StringBuilder sb = new StringBuilder();
                foreach (byte b in bytes)
                    sb.Append(b.ToString("x2"));
                return sb.ToString();
            }
        }
    }
}
