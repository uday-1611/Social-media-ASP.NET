﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="register.aspx.cs" Inherits="socialmedia1611.register" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Create Account</title>

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
            padding: 12px;
            color: var(--text-main);
        }

        .page-wrapper {
            width: 100%;
            max-width: 920px;
            display: grid;
            grid-template-columns: 1.2fr 1fr;
            gap: 20px;
            background: rgba(15, 23, 42, 0.95);
            border-radius: 24px;
            border: 1px solid rgba(148, 163, 184, 0.35);
            box-shadow: 0 20px 60px rgba(15, 23, 42, 0.8);
            overflow: hidden;
            backdrop-filter: blur(20px);
        }

        /* LEFT SIDE – FORM */
        .form-section {
            padding: 24px 26px 22px 26px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .brand-row {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 18px;
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
            margin: 0 0 2px 0;
            font-size: 1.8rem;
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
            margin: 0 0 18px 0;
            font-size: 0.88rem;
            color: var(--text-muted);
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 14px 16px;
        }

        .form-group {
            position: relative;
            display: flex;
            flex-direction: column;
            gap: 6px;
        }

        .form-group.full {
            grid-column: 1 / -1;
        }

        .label {
            font-size: 0.78rem;
            text-transform: uppercase;
            letter-spacing: 0.08em;
            color: var(--text-muted);
            font-weight: 500;
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
            font-size: 0.88rem;
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

        .helper-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 6px;
        }

        .password-hint {
            font-size: 0.75rem;
            color: var(--text-muted);
        }

        .password-strength {
            width: 80px;
            height: 4px;
            background: #1f2937;
            border-radius: 999px;
            overflow: hidden;
        }

        .password-strength-bar {
            height: 100%;
            width: 0;
            background: #22c55e;
            transition: width 0.25s ease, background-color 0.25s ease;
        }

        .terms {
            grid-column: 1 / -1;
            display: flex;
            align-items: flex-start;
            gap: 8px;
            margin-top: 4px;
        }

        .terms input[type="checkbox"] {
            margin-top: 2px;
            cursor: pointer;
        }

        .terms-text {
            font-size: 0.8rem;
            color: var(--text-muted);
        }

        .terms-text a {
            color: var(--accent);
            text-decoration: none;
        }

        .terms-text a:hover {
            text-decoration: underline;
        }

        .btn-primary {
            width: 100%;
            margin-top: 14px;
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

        .login-link {
            margin-top: 12px;
            text-align: center;
            font-size: 0.82rem;
            color: var(--text-muted);
        }

        .login-link a {
            color: var(--accent);
            text-decoration: none;
            font-weight: 500;
        }

        .login-link a:hover {
            text-decoration: underline;
        }

        /* RIGHT SIDE – INFO / ART */
        .info-section {
            padding: 22px 22px 20px 0;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            position: relative;
        }

        .info-card {
            height: 100%;
            border-radius: 20px 0 0 20px;
            background: radial-gradient(circle at top, rgba(248, 113, 113, 0.8), transparent 60%),
                        radial-gradient(circle at bottom, rgba(56, 189, 248, 0.8), transparent 55%),
                        var(--card-bg);
            border: 1px solid rgba(148, 163, 184, 0.3);
            padding: 24px 24px 20px 24px;
            position: relative;
            overflow: hidden;
        }

        .info-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 4px 10px;
            border-radius: 999px;
            background: rgba(15, 23, 42, 0.7);
            color: #e5e7eb;
            font-size: 0.7rem;
        }

        .info-main-title {
            margin: 18px 0 6px 0;
            font-size: 1.4rem;
            font-weight: 600;
        }

        .info-text {
            font-size: 0.85rem;
            color: #e5e7eb;
            max-width: 230px;
        }

        .info-stats {
            display: flex;
            gap: 16px;
            margin-top: 22px;
        }

        .stat-card {
            flex: 1;
            background: rgba(15, 23, 42, 0.75);
            border-radius: 14px;
            padding: 10px 12px;
            border: 1px solid rgba(148, 163, 184, 0.4);
            font-size: 0.78rem;
            color: #e5e7eb;
        }

        .stat-number {
            display: block;
            font-size: 1.05rem;
            font-weight: 600;
        }

        .floating-orbit {
            position: absolute;
            width: 210px;
            height: 210px;
            border-radius: 50%;
            border: 1px dashed rgba(248, 250, 252, 0.5);
            top: 45%;
            right: -40px;
            transform: translateY(-50%);
            opacity: 0.4;
        }

        .floating-dot {
            position: absolute;
            width: 9px;
            height: 9px;
            border-radius: 50%;
            background: #f97316;
            top: 12px;
            left: 50%;
        }

        .glow-pill {
            position: absolute;
            right: 24px;
            bottom: 24px;
            padding: 6px 10px;
            border-radius: 999px;
            background: rgba(15, 23, 42, 0.9);
            border: 1px solid rgba(148, 163, 184, 0.7);
            font-size: 0.75rem;
            display: flex;
            align-items: center;
            gap: 6px;
            color: #e5e7eb;
        }

        .glow-dot {
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background: #4ade80;
            box-shadow: 0 0 12px #4ade80;
        }

        /* RESPONSIVE */
        @media (max-width: 900px) {
            .page-wrapper {
                grid-template-columns: 1fr;
                max-width: 480px;
            }

            .info-section {
                display: none;
            }

            .form-section {
                padding: 24px 20px 22px 20px;
            }
        }

        @media (max-width: 480px) {
            body {
                padding: 12px;
            }

            .page-wrapper {
                border-radius: 22px;
            }

            .form-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div class="page-wrapper">

        <!-- LEFT: FORM -->
        <div class="form-section">
            <div>

                <!-- Brand -->
                <div class="brand-row">
                    <div class="brand-logo">
                        <i class="fa-solid fa-bolt"></i>
                    </div>
                    <div class="brand-text">Welcome to SocialHub</div>
                </div>

                <!-- Title -->
                <h1 class="page-title">
                    <i class="fa-solid fa-bolt"></i>
                    SocialHub
                </h1>

                <p class="page-subtitle">
                    Create your SocialHub account and start sharing moments.
                </p>

                <!-- Form Grid -->
                <div class="form-grid">

                    <!-- First Name -->
                    <div class="form-group">
                        <label class="label">First name <span>*</span></label>
                        <div class="input-wrapper">
                            <i class="fa-regular fa-user input-icon"></i>
                            <asp:TextBox ID="txtFirstName" runat="server"
                                CssClass="input"
                                placeholder="John" />
                        </div>
                    </div>

                    <!-- Last Name -->
                    <div class="form-group">
                        <label class="label">Last name <span>*</span></label>
                        <div class="input-wrapper">
                            <i class="fa-regular fa-user input-icon"></i>
                            <asp:TextBox ID="txtLastName" runat="server"
                                CssClass="input"
                                placeholder="Doe" />
                        </div>
                    </div>

                    <!-- Email -->
                    <div class="form-group full">
                        <label class="label">Email address <span>*</span></label>
                        <div class="input-wrapper">
                            <i class="fa-regular fa-envelope input-icon"></i>
                            <asp:TextBox ID="txtEmail" runat="server"
                                CssClass="input"
                                TextMode="Email"
                                placeholder="you@example.com" />
                        </div>
                    </div>

                    <!-- Username -->
                    <div class="form-group">
                        <label class="label">Username <span>*</span></label>
                        <div class="input-wrapper">
                            <i class="fa-solid fa-at input-icon"></i>
                            <asp:TextBox ID="txtUsername" runat="server"
                                CssClass="input"
                                placeholder="username" />
                        </div>
                    </div>

                    <!-- Phone -->
                    <div class="form-group">
                        <label class="label">Phone</label>
                        <div class="input-wrapper">
                            <i class="fa-solid fa-phone input-icon"></i>
                            <asp:TextBox ID="txtPhone" runat="server"
                                CssClass="input"
                                placeholder="+91 98765 43210" />
                        </div>
                    </div>

                    <!-- Password -->
                    <div class="form-group full">
                        <label class="label">Password <span>*</span></label>
                        <div class="input-wrapper">
                            <i class="fa-solid fa-lock input-icon"></i>
                            <asp:TextBox ID="txtPassword" runat="server"
                                CssClass="input"
                                TextMode="Password"
                                placeholder="At least 8 characters" />
                            <button type="button" class="toggle-password" id="btnTogglePwd">
                                <i class="fa-regular fa-eye"></i>
                            </button>
                        </div>

                        <div class="helper-row">
                            <div class="password-hint">Use letters, numbers & symbols</div>
                            <div class="password-strength">
                                <div class="password-strength-bar" id="pwdStrengthBar"></div>
                            </div>
                        </div>
                    </div>

                    <!-- Confirm Password -->
                    <div class="form-group full">
                        <label class="label">Confirm password <span>*</span></label>
                        <div class="input-wrapper">
                            <i class="fa-solid fa-lock input-icon"></i>
                            <asp:TextBox ID="txtConfirmPassword" runat="server"
                                CssClass="input"
                                TextMode="Password"
                                placeholder="Re-enter your password" />
                            <button type="button" class="toggle-password" id="btnToggleConfirm">
                                <i class="fa-regular fa-eye"></i>
                            </button>
                        </div>
                    </div>

                    <!-- Terms -->
                    <div class="terms">
                        <asp:CheckBox ID="chkTerms" runat="server" />
                        <div class="terms-text">
                            I agree to the
                            <a href="#">Terms of Service</a> and
                            <a href="#">Privacy Policy</a>.
                        </div>
                    </div>

                </div>

                <!-- Message -->
                <asp:Label ID="lblMessage" runat="server"
                    Style="color:red; display:block; margin-bottom:10px;" />

                <!-- Button -->
                <asp:Button ID="btnCreate" runat="server"
                    CssClass="btn-primary"
                    Text="Create account"
                    OnClick="btnCreate_Click" />

                <!-- Login -->
                <div class="login-link">
                    Already a member?
                    <a href="Login.aspx">Sign in</a>
                </div>

            </div>
        </div>

        <!-- RIGHT: INFO -->
        <div class="info-section">
            <div class="info-card">

                <div class="info-badge">
                    <i class="fa-solid fa-sparkles"></i>
                    Hand-picked for creators
                </div>

                <h2 class="info-main-title">
                    Build your social circle in minutes.
                </h2>

                <p class="info-text">
                    Follow people you care about, join conversations you love,
                    and grow an authentic audience with beautiful content.
                </p>

                <div class="info-stats">
                    <div class="stat-card">
                        <span class="stat-number">2M+</span>
                        Creators sharing stories
                    </div>
                    <div class="stat-card">
                        <span class="stat-number">98%</span>
                        Positive feedback on community vibes
                    </div>
                </div>

                <div class="floating-orbit">
                    <div class="floating-dot"></div>
                </div>

                <div class="glow-pill">
                    <div class="glow-dot"></div>
                    Live now: <strong>Friends sharing moments</strong>
                </div>

            </div>
        </div>

    </div>
</form>


  
</body>
</html>