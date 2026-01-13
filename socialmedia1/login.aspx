﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="socialmedia1611.login" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>SocialHub - Login</title>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet" />

    <!-- Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />

    <style>
        :root {
            --primary: #ff6b6b;
            --primary-dark: #e35757;
            --accent: #ffd166;
            --bg: #0f172a;
            --card-bg: #020617;
            --card-border: rgba(148, 163, 184, 0.25);
            --text-main: #e5e7eb;
            --text-muted: #9ca3af;
            --radius-lg: 18px;
            --radius-md: 12px;
        }

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            min-height: 100vh;
            font-family: "Poppins", system-ui, -apple-system, sans-serif;
            background: radial-gradient(circle at top left, #1d4ed8 0, transparent 50%),
                        radial-gradient(circle at bottom right, #ec4899 0, transparent 55%),
                        var(--bg);
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 24px;
            color: var(--text-main);
        }

        .page-wrapper {
            width: 100%;
            max-width: 440px;
            background: rgba(15, 23, 42, 0.95);
            border-radius: 26px;
            border: 1px solid rgba(148, 163, 184, 0.35);
            box-shadow: 0 24px 70px rgba(15, 23, 42, 0.8);
            overflow: hidden;
            backdrop-filter: blur(20px);
        }

        .form-section {
            padding: 26px 24px 22px 24px;
        }

        .brand-row {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 16px;
        }

        .brand-logo {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            background: radial-gradient(circle at 30% 30%, #ffffff, #fb7185);
            display: flex;
            align-items: center;
            justify-content: center;
            color: #111827;
            font-weight: 700;
            font-size: 1.1rem;
        }

        .brand-text {
            font-size: 0.9rem;
            color: var(--text-muted);
        }

        .page-title {
            margin: 0 0 4px 0;
            font-size: 2.1rem;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .page-title i {
            font-size: 1.3rem;
            color: var(--accent);
        }

        .page-subtitle {
            margin: 0 0 22px 0;
            font-size: 0.9rem;
            color: var(--text-muted);
        }

        .form-group {
            margin-bottom: 16px;
        }

        .label {
            font-size: 0.78rem;
            text-transform: uppercase;
            letter-spacing: 0.08em;
            color: var(--text-muted);
            font-weight: 500;
            margin-bottom: 6px;
        }

        .label span {
            color: #f97373;
        }

        .input-wrapper {
            position: relative;
        }

        .input-icon {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: #6b7280;
            font-size: 0.9rem;
        }

        .input {
            width: 100%;
            padding: 10px 12px 10px 34px;
            border-radius: var(--radius-md);
            border: 1px solid var(--card-border);
            background: rgba(15, 23, 42, 0.9);
            color: var(--text-main);
            font-size: 0.9rem;
            outline: none;
            transition: border-color 0.2s ease, box-shadow 0.2s ease, background 0.2s ease, transform 0.1s ease;
        }

        .input::placeholder {
            color: #6b7280;
        }

        .input:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 1px rgba(248, 113, 113, 0.6);
            transform: translateY(-1px);
            background: rgba(15, 23, 42, 1);
        }

        .toggle-password {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            color: #6b7280;
            cursor: pointer;
            font-size: 0.9rem;
        }

        .options-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 4px;
            margin-bottom: 6px;
        }

        .remember {
            display: flex;
            align-items: center;
            gap: 6px;
            font-size: 0.8rem;
            color: var(--text-muted);
        }

        .remember input[type="checkbox"] {
            cursor: pointer;
        }

        .forgot-link {
            font-size: 0.8rem;
        }

        .forgot-link a {
            color: var(--accent);
            text-decoration: none;
        }

        .forgot-link a:hover {
            text-decoration: underline;
        }

        .btn-primary {
            width: 100%;
            margin-top: 10px;
            border-radius: var(--radius-lg);
            border: none;
            padding: 11px 14px;
            background: linear-gradient(135deg, var(--primary), #fb7185);
            color: #111827;
            font-size: 0.92rem;
            font-weight: 600;
            letter-spacing: 0.04em;
            text-transform: uppercase;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            box-shadow: 0 15px 40px rgba(248, 113, 113, 0.5);
            transition: transform 0.12s ease, box-shadow 0.12s ease, filter 0.12s ease;
        }

        .btn-primary:hover {
            transform: translateY(-1px) scale(1.01);
            filter: brightness(1.02);
            box-shadow: 0 18px 45px rgba(248, 113, 113, 0.6);
        }

        .btn-primary:active {
            transform: translateY(0) scale(0.99);
            box-shadow: 0 8px 24px rgba(248, 113, 113, 0.4);
        }

        .divider {
            display: flex;
            align-items: center;
            gap: 10px;
            margin: 18px 0 12px;
            font-size: 0.78rem;
            color: var(--text-muted);
        }

        .divider-line {
            flex: 1;
            height: 1px;
            background: rgba(148, 163, 184, 0.35);
        }

        .social-row {
            display: flex;
            gap: 10px;
        }

        .social-btn {
            flex: 1;
            border-radius: var(--radius-md);
            border: 1px solid rgba(148, 163, 184, 0.4);
            background: rgba(15, 23, 42, 0.9);
            color: var(--text-main);
            font-size: 0.82rem;
            padding: 8px 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            cursor: pointer;
            transition: border-color 0.15s ease, background 0.15s ease, transform 0.1s ease;
        }

        .social-btn:hover {
            transform: translateY(-1px);
            background: rgba(15, 23, 42, 1);
        }

        .social-btn.google:hover {
            border-color: #f97373;
        }

        .social-btn.facebook:hover {
            border-color: #60a5fa;
        }

        .social-btn.twitter:hover {
            border-color: #38bdf8;
        }

        .register-link {
            margin-top: 14px;
            text-align: center;
            font-size: 0.82rem;
            color: var(--text-muted);
        }

        .register-link a {
            color: var(--accent);
            text-decoration: none;
            font-weight: 500;
        }

        .register-link a:hover {
            text-decoration: underline;
        }

        @media (max-width: 480px) {
            body {
                padding: 12px;
            }
            .page-wrapper {
                border-radius: 22px;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="page-wrapper">
            <div class="form-section">
                <div>
                    <div class="brand-row">
                        <div class="brand-logo">
                            <i class="fa-solid fa-bolt"></i>
                        </div>
                        <div class="brand-text">Welcome back to SocialHub</div>
                    </div>

                    <h1 class="page-title">
                        <i class="fa-solid fa-bolt"></i>
                        SocialHub
                    </h1>
                    <p class="page-subtitle">
                        Sign in to continue where you left off. Stay connected with your people.
                    </p>

                    <div class="form-group">
                        <label class="label">Email <span>*</span></label>
                        <div class="input-wrapper">
                            <i class="fa-regular fa-envelope input-icon"></i>
                            <asp:TextBox ID="txtLoginId" runat="server"
                                CssClass="input"
                                placeholder="you@example.com " required />
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="label">Password <span>*</span></label>
                        <div class="input-wrapper">
                            <i class="fa-solid fa-lock input-icon"></i>
                            <asp:TextBox ID="txtPassword" runat="server"
                                CssClass="input"
                                TextMode="Password"
                                placeholder="Your password" required />
                            <button type="button" class="toggle-password" id="btnTogglePwd">
                                <i class="fa-regular fa-eye"></i>
                            </button>
                        </div>
                    </div>

                    <div class="options-row">
                        <div class="forgot-link">
                            <a href="#">Forgot password?</a>
                        </div>
                    </div>

                    <asp:Button ID="btnLogin" runat="server"
                        CssClass="btn-primary"
                        Text="Sign In"
                        OnClick="btnLogin_Click" />

                    <div class="register-link">
                        New here?
                        <a href="Register.aspx">Create an account</a>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <script>
        (function () {
            const pwd = document.getElementById("txtPassword");
            const btnPwd = document.getElementById("btnTogglePwd");

            function toggleVisibility(input, btn) {
                const icon = btn.querySelector("i");
                if (input.type === "password") {
                    input.type = "text";
                    icon.classList.remove("fa-eye");
                    icon.classList.add("fa-eye-slash");
                } else {
                    input.type = "password";
                    icon.classList.remove("fa-eye-slash");
                    icon.classList.add("fa-eye");
                }
            }

            btnPwd.addEventListener("click", function () {
                toggleVisibility(pwd, btnPwd);
            });
        })();
    </script>
</body>
</html>