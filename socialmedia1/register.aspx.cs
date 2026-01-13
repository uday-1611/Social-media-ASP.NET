using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;

namespace socialmedia1611
{
    public partial class register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                RegisterClientScripts();
            }
        }

        protected void btnCreate_Click(object sender, EventArgs e)
        {
            lblMessage.ForeColor = System.Drawing.Color.Red;
            lblMessage.Text = "";

            // Read inputs
            string firstName = txtFirstName.Text.Trim();
            string lastName = txtLastName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string username = txtUsername.Text.Trim();
            string phone = txtPhone.Text.Trim();
            string password = txtPassword.Text;
            string confirmPassword = txtConfirmPassword.Text;

            // 1️⃣ Required fields
            if (string.IsNullOrEmpty(firstName) ||
                string.IsNullOrEmpty(lastName) ||
                string.IsNullOrEmpty(email) ||
                string.IsNullOrEmpty(username) ||
                string.IsNullOrEmpty(password) ||
                string.IsNullOrEmpty(confirmPassword))
            {
                lblMessage.Text = "All required fields must be filled.";
                return;
            }

            // 2️⃣ Email validation
            if (!Regex.IsMatch(email, @"^[^@\s]+@[^@\s]+\.[^@\s]+$"))
            {
                lblMessage.Text = "Please enter a valid email address.";
                return;
            }

            // 3️⃣ Password length
            if (password.Length < 8)
            {
                lblMessage.Text = "Password must be at least 8 characters long.";
                return;
            }

            // 4️⃣ Password match
            if (password != confirmPassword)
            {
                lblMessage.Text = "Passwords do not match.";
                return;
            }

            // 5️⃣ Terms checkbox
            if (!chkTerms.Checked)
            {
                lblMessage.Text = "You must agree to the Terms and Privacy Policy.";
                return;
            }

            string cs = ConfigurationManager.ConnectionStrings["socialmedia1611"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                // 6️⃣ Check email
                SqlCommand checkEmail = new SqlCommand(
                    "SELECT COUNT(*) FROM Users WHERE Email = @Email", con);
                checkEmail.Parameters.AddWithValue("@Email", email);

                if ((int)checkEmail.ExecuteScalar() > 0)
                {
                    lblMessage.Text = "Email already registered.";
                    return;
                }

                // 7️⃣ Check username
                SqlCommand checkUser = new SqlCommand(
                    "SELECT COUNT(*) FROM Users WHERE Username = @Username", con);
                checkUser.Parameters.AddWithValue("@Username", username);

                if ((int)checkUser.ExecuteScalar() > 0)
                {
                    lblMessage.Text = "Username already taken.";
                    return;
                }

                // 8️⃣ Hash password
                string hashedPassword = HashPassword(password);

                // 9️⃣ Insert user
                SqlCommand cmd = new SqlCommand(
                    @"INSERT INTO Users
                      (FirstName, LastName, Email, Username, Phone, Password)
                      VALUES
                      (@FirstName, @LastName, @Email, @Username, @Phone, @Password)", con);

                cmd.Parameters.AddWithValue("@FirstName", firstName);
                cmd.Parameters.AddWithValue("@LastName", lastName);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@Username", username);
                cmd.Parameters.AddWithValue("@Phone", phone);
                cmd.Parameters.AddWithValue("@Password", hashedPassword);

                cmd.ExecuteNonQuery();
            }

            lblMessage.ForeColor = System.Drawing.Color.LimeGreen;
            lblMessage.Text = "Registration successful! Redirecting to login page...";
            
            // Redirect to login page immediately
            Response.Redirect("Login.aspx");
        }

        // 🔐 Password Hashing
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

        // 👁 Password toggle + 📊 strength indicator
        private void RegisterClientScripts()
        {
            string script = @"
<script>
document.addEventListener('DOMContentLoaded', function () {

    function togglePassword(inputId, btnId) {
        const input = document.getElementById(inputId);
        const btn = document.getElementById(btnId);
        const icon = btn.querySelector('i');

        btn.addEventListener('click', function () {
            if (input.type === 'password') {
                input.type = 'text';
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
            } else {
                input.type = 'password';
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
            }
        });
    }

    togglePassword('" + txtPassword.ClientID + @"', 'btnTogglePwd');
    togglePassword('" + txtConfirmPassword.ClientID + @"', 'btnToggleConfirm');

    const pwdInput = document.getElementById('" + txtPassword.ClientID + @"');
    const bar = document.getElementById('pwdStrengthBar');

    pwdInput.addEventListener('input', function () {
        const val = pwdInput.value;
        let strength = 0;

        if (val.length >= 8) strength++;
        if (/[A-Z]/.test(val)) strength++;
        if (/[0-9]/.test(val)) strength++;
        if (/[^A-Za-z0-9]/.test(val)) strength++;

        if (strength <= 1) {
            bar.style.width = '25%';
            bar.style.backgroundColor = '#ef4444';
        } else if (strength <= 3) {
            bar.style.width = '60%';
            bar.style.backgroundColor = '#f59e0b';
        } else {
            bar.style.width = '100%';
            bar.style.backgroundColor = '#22c55e';
        }

        if (val.length === 0) {
            bar.style.width = '0';
        }
    });
});
</script>";

            ClientScript.RegisterStartupScript(
                this.GetType(),
                "PasswordFeatures",
                script,
                false
            );
        }
    }
}
