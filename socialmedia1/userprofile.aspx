<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UserProfile.aspx.cs" Inherits="socialmedia1.userprofile" %>



<!DOCTYPE html>
<html>
<head runat="server">
    <title>User Profile</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />

    <!-- Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" />

    <style>
        body {
            background: radial-gradient(circle at top left, #1d4ed8 0, transparent 50%),
                        radial-gradient(circle at bottom right, #ec4899 0, transparent 55%),
                        #0f172a;
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
            color: #e5e7eb;
        }

        .ig-container {
            max-width: 935px;
            margin: 40px auto 60px auto;
            padding: 24px 16px 32px 16px;
            background: rgba(15, 23, 42, 0.95);
            border-radius: 24px;
            border: 1px solid rgba(148, 163, 184, 0.35);
            box-shadow: 0 20px 60px rgba(15, 23, 42, 0.85);
            backdrop-filter: blur(20px);
        }

        .ig-header {
            display: flex;
            padding-bottom: 32px;
            border-bottom: 1px solid rgba(148, 163, 184, 0.35);
        }

        .ig-avatar-wrap {
            flex: 0 0 25%;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .ig-avatar {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid rgba(248, 250, 252, 0.9);
            background-color: #020617;
            box-shadow: 0 14px 40px rgba(15, 23, 42, 0.9);
        }

        .ig-header-main {
            flex: 1;
            padding-left: 32px;
        }

        .ig-header-row {
            display: flex;
            align-items: center;
            gap: 16px;
            margin-bottom: 12px;
        }

        .ig-username {
            font-size: 20px;
            font-weight: 300;
            color: #f9fafb;
        }

        .ig-edit-btn {
            font-size: 14px;
            padding: 4px 14px;
            border-radius: 999px;
            border: 1px solid rgba(148, 163, 184, 0.5);
            background: rgba(15, 23, 42, 0.9);
            color: #e5e7eb;
        }

        .ig-edit-btn:hover {
            background: rgba(15, 23, 42, 1);
        }

        .ig-stats {
            display: flex;
            gap: 24px;
            margin-bottom: 10px;
            font-size: 14px;
            color: #e5e7eb;
        }

        .ig-stats span {
            font-weight: 600;
        }

        .ig-name {
            font-size: 14px;
            font-weight: 600;
            color: #f9fafb;
        }

        .ig-bio {
            font-size: 14px;
            white-space: pre-line;
            color: #e5e7eb;
        }

        .ig-email {
            font-size: 13px;
            color: #9ca3af;
        }

        .ig-stories {
            display: flex;
            gap: 18px;
            padding: 24px 0;
            border-bottom: 1px solid rgba(148, 163, 184, 0.35);
        }

        .ig-story {
            display: flex;
            flex-direction: column;
            align-items: center;
            font-size: 12px;
        }

        .ig-story-ring {
            width: 77px;
            height: 77px;
            border-radius: 50%;
            padding: 3px;
            background: radial-gradient(circle at 30% 107%, #fdf497 0%, #fd5949 45%, #d6249f 60%, #285AEB 90%);
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 6px;
        }

        .ig-story-inner {
            width: 71px;
            height: 71px;
            border-radius: 50%;
            background: #fff;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }

        .ig-story-inner img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .ig-tabs {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 40px;
            text-transform: uppercase;
            font-size: 11px;
            letter-spacing: 0.16em;
            color: #9ca3af;
            padding-top: 12px;
        }

        .ig-tab-active {
            color: #e5e7eb;
            font-weight: 600;
        }

        .ig-tab-active .bi {
            color: #e5e7eb;
        }

        .ig-tabs .bi {
            font-size: 14px;
            margin-right: 4px;
        }

        .ig-grid {
            margin-top: 16px;
        }

        .ig-grid-row {
            display: flex;
            gap: 4px;
            margin-bottom: 4px;
        }

        .ig-grid-item {
            position: relative;
            flex: 1;
            overflow: hidden;
            background: #020617;
        }

        .ig-grid-item::before {
            content: "";
            display: block;
            padding-top: 100%;
        }

        .ig-grid-img {
            position: absolute;
            inset: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .ig-grid-overlay {
            position: absolute;
            inset: 0;
            background: rgba(15, 23, 42, 0.75);
            opacity: 0;
            transition: opacity 0.2s ease-in-out;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 16px;
            color: #f9fafb;
            font-size: 13px;
            font-weight: 600;
        }

        .ig-grid-item:hover .ig-grid-overlay {
            opacity: 1;
        }

        .ig-grid-overlay .bi {
            margin-right: 4px;
        }

        @media (max-width: 767.98px) {
            .ig-header {
                flex-direction: column;
            }

            .ig-header-main {
                padding-left: 0;
                margin-top: 16px;
            }

            .ig-avatar-wrap {
                justify-content: flex-start;
            }
        }
    </style>

</head>

<body>
    <form id="form1" runat="server">
        <div class="ig-container">

            <!-- Header -->
            <section class="ig-header">
                <div class="ig-avatar-wrap">
                    <asp:Image ID="imgProfile" runat="server" CssClass="ig-avatar" />
                </div>

                <div class="ig-header-main">
                    <div class="ig-header-row">
                        <div class="ig-username">
                            <asp:Label ID="lblUsername" runat="server" Text="johndoe_official"></asp:Label>
                        </div>
                        <asp:Button ID="btnEditProfile" runat="server"
                                    Text="Edit profile"
                                    CssClass="btn ig-edit-btn"
                                    PostBackUrl="editprofile.aspx" />
                    </div>

                    <div class="ig-stats">
                        <div><span>120</span> posts</div>
                        <div><span>2,340</span> followers</div>
                        <div><span>310</span> following</div>
                    </div>

                    <div class="ig-name">
                        <asp:Label ID="lblName" runat="server" Text="John Doe"></asp:Label>
                    </div>
                    <div class="ig-bio">
                        <asp:Label ID="lblBio" runat="server" Text="Digital creator | Traveler | Food Lover"></asp:Label>
                    </div>
                    <div class="ig-email">
                        <asp:Label ID="lblEmail" runat="server" Text="johndoe@gmail.com"></asp:Label>
                    </div>
                </div>
            </section>

            <!-- Stories / Highlights -->
            <section class="ig-stories">
                <div class="ig-story">
                    <div class="ig-story-ring">
                        <div class="ig-story-inner">
                            <img src="https://picsum.photos/200?random=1" alt="story1" />
                        </div>
                    </div>
                    <span>Travel</span>
                </div>

                <div class="ig-story">
                    <div class="ig-story-ring">
                        <div class="ig-story-inner">
                            <img src="https://picsum.photos/200?random=2" alt="story2" />
                        </div>
                    </div>
                    <span>Food</span>
                </div>

                <div class="ig-story">
                    <div class="ig-story-ring">
                        <div class="ig-story-inner">
                            <img src="https://picsum.photos/200?random=3" alt="story3" />
                        </div>
                    </div>
                    <span>Daily</span>
                </div>
            </section>

            <!-- Tabs -->
            <nav class="ig-tabs">
                <div class="ig-tab-active">
                    <i class="bi bi-grid-3x3"></i> Posts
                </div>
                <div>
                    <i class="bi bi-bookmark"></i> Saved
                </div>
                <div>
                    <i class="bi bi-person-square"></i> Tagged
                </div>
            </nav>

            <!-- Post Grid -->
            <section class="ig-grid">
                <div class="ig-grid-row">
                    <div class="ig-grid-item">
                        <img src="https://picsum.photos/400?random=11" class="ig-grid-img" />
                        <div class="ig-grid-overlay">
                            <span><i class="bi bi-heart-fill"></i> 120</span>
                            <span><i class="bi bi-chat"></i> 18</span>
                        </div>
                    </div>
                    <div class="ig-grid-item">
                        <img src="https://picsum.photos/400?random=12" class="ig-grid-img" />
                        <div class="ig-grid-overlay">
                            <span><i class="bi bi-heart-fill"></i> 89</span>
                            <span><i class="bi bi-chat"></i> 10</span>
                        </div>
                    </div>
                    <div class="ig-grid-item">
                        <img src="https://picsum.photos/400?random=13" class="ig-grid-img" />
                        <div class="ig-grid-overlay">
                            <span><i class="bi bi-heart-fill"></i> 142</span>
                            <span><i class="bi bi-chat"></i> 26</span>
                        </div>
                    </div>
                </div>

                <div class="ig-grid-row">
                    <div class="ig-grid-item">
                        <img src="https://picsum.photos/400?random=14" class="ig-grid-img" />
                        <div class="ig-grid-overlay">
                            <span><i class="bi bi-heart-fill"></i> 210</span>
                            <span><i class="bi bi-chat"></i> 32</span>
                        </div>
                    </div>
                    <div class="ig-grid-item">
                        <img src="https://picsum.photos/400?random=15" class="ig-grid-img" />
                        <div class="ig-grid-overlay">
                            <span><i class="bi bi-heart-fill"></i> 76</span>
                            <span><i class="bi bi-chat"></i> 9</span>
                        </div>
                    </div>
                    <div class="ig-grid-item">
                        <img src="https://picsum.photos/400?random=16" class="ig-grid-img" />
                        <div class="ig-grid-overlay">
                            <span><i class="bi bi-heart-fill"></i> 95</span>
                            <span><i class="bi bi-chat"></i> 14</span>
                        </div>
                    </div>
                </div>
            </section>

        </div>
    </form>
</body>
</html>
