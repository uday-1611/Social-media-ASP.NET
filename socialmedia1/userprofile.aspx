<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UserProfile.aspx.cs" Inherits="socialmedia1.userprofile" %>



<!DOCTYPE html>
<html>
<head runat="server">
    <title>User Profile</title>
    <script src="https://cdn.lordicon.com/lordicon.js"></script>
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

        /* New Logout Button Styles */
        .logout-btn-container {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 9999;
        }

        .logout-btn {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 50%;
            width: 56px;
            height: 56px;
            cursor: pointer;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            position: relative;
        }

        .hidden-logout-btn {
            display: none;
        }

        .logout-icon {
            width: 24px;
            height: 24px;
            color: white;
            transition: all 0.3s ease;
            z-index: 2;
            position: relative;
        }

        .logout-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            transition: left 0.6s ease;
        }

        .logout-btn:hover::before {
            left: 100%;
        }

        .logout-btn:hover {
            transform: translateY(-3px) scale(1.1) rotate(5deg);
            box-shadow: 0 12px 35px rgba(102, 126, 234, 0.6);
            background: linear-gradient(135deg, #7c8ff0 0%, #8b5ba8 100%);
        }

        .logout-btn:hover .logout-icon {
            transform: translateX(2px);
            stroke-width: 3;
        }

        .logout-btn:active {
            transform: translateY(-1px) scale(1.05) rotate(2deg);
        }

        /* Pulse animation */
        .logout-btn::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 100%;
            height: 100%;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.2);
            transform: translate(-50%, -50%) scale(0);
            transition: transform 0.6s ease;
        }

        .logout-btn:hover::after {
            transform: translate(-50%, -50%) scale(1.5);
            opacity: 0;
        }

        /* Logout Confirmation Modal Styles */
        .logout-modal {
            display: none;
            position: fixed;
            z-index: 10000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.6);
            backdrop-filter: blur(8px);
            animation: fadeIn 0.3s ease;
        }

        .logout-modal-content {
            background: linear-gradient(135deg, #1e293b 0%, #334155 100%);
            margin: 15% auto;
            padding: 40px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 20px;
            width: 380px;
            text-align: center;
            box-shadow: 0 25px 80px rgba(0, 0, 0, 0.4);
            color: #ffffff;
            animation: slideUp 0.4s ease;
        }

        .modal-icon {
            margin-bottom: 20px;
            animation: pulse 2s infinite;
        }

        .logout-modal h3 {
            margin-bottom: 12px;
            color: #ffffff;
            font-size: 24px;
            font-weight: 600;
        }

        .logout-modal p {
            margin-bottom: 30px;
            color: #e2e8f0;
            font-size: 16px;
            line-height: 1.5;
        }

        .logout-modal-buttons {
            display: flex;
            gap: 15px;
            justify-content: center;
        }

        .logout-modal-btn {
            padding: 12px 28px;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            font-size: 15px;
            font-weight: 500;
            transition: all 0.3s ease;
            min-width: 100px;
        }

        .logout-confirm {
            background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
            color: white;
            box-shadow: 0 4px 15px rgba(239, 68, 68, 0.3);
        }

        .logout-confirm:hover {
            background: linear-gradient(135deg, #f87171 0%, #ef4444 100%);
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(239, 68, 68, 0.4);
        }

        .logout-cancel {
            background: rgba(255, 255, 255, 0.1);
            color: white;
            border: 1px solid rgba(255, 255, 255, 0.3);
            backdrop-filter: blur(10px);
        }

        .logout-cancel:hover {
            background: rgba(255, 255, 255, 0.2);
            transform: translateY(-2px);
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @keyframes slideUp {
            from { 
                transform: translateY(50px);
                opacity: 0;
            }
            to { 
                transform: translateY(0);
                opacity: 1;
            }
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
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

            <!-- New Logout Button (Top Right) -->
            <div class="logout-btn-container">
                <button type="button" class="logout-btn" onclick="showLogoutConfirm();">
                    <svg class="logout-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5">
                        <path d="M9 21H5a2 2 0 01-2-2V5a2 2 0 012-2h4M16 17l5-5-5-5M21 12H9"/>
                    </svg>
                    <asp:Button ID="btnLogout" runat="server" 
                                CssClass="hidden-logout-btn"
                                OnClick="btnLogout_Click"
                                Text="" />
                </button>
            </div>

            <!-- Logout Confirmation Modal -->
            <div id="logoutConfirmModal" class="logout-modal">
                <div class="logout-modal-content">
                    <div class="modal-icon">
                        <svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="#ef4444" stroke-width="2">
                            <path d="M9 21H5a2 2 0 01-2-2V5a2 2 0 012-2h4M16 17l5-5-5-5M21 12H9"/>
                        </svg>
                    </div>
                    <h3>Confirm Logout</h3>
                    <p>Do you want logout?</p>
                    <div class="logout-modal-buttons">
                        <button type="button" class="logout-modal-btn logout-cancel" onclick="hideLogoutConfirm();">Cancel</button>
                        <button type="button" class="logout-modal-btn logout-confirm" onclick="confirmLogout();">Logout</button>
                    </div>
                </div>
            </div>

            <!-- Header -->
            <section class="ig-header">
                <div class="ig-avatar-wrap">
                    <div id="defaultProfileIcon" style="display: none; width: 150px; height: 150px;">
                        <lord-icon
                            src="https://cdn.lordicon.com/kdduutaw.json"
                            trigger="loop"
                            delay="2000"
                            colors="primary:#4f46e5,secondary:#818cf8,tertiary:#c7d2fe"
                            style="width:150px;height:150px">
                        </lord-icon>
                    </div>
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
                <div>
                    <i class="bi bi-grid-3x3"></i> Posts
                </div>
                <div class="ig-tab-active">
                    <i class="bi bi-bookmark"></i> Saved
                </div>
                <div>
                    <i class="bi bi-person-square"></i> Tagged
                </div>
            </nav>

            <!-- Saved Posts Grid -->
            <section class="ig-grid">
                <div class="ig-grid-row">
                    <div class="ig-grid-item">
                        <img src="https://picsum.photos/400?random=21" class="ig-grid-img" />
                        <div class="ig-grid-overlay">
                            <span><i class="bi bi-heart-fill"></i> 234</span>
                            <span><i class="bi bi-chat"></i> 45</span>
                        </div>
                    </div>
                    <div class="ig-grid-item">
                        <img src="https://picsum.photos/400?random=22" class="ig-grid-img" />
                        <div class="ig-grid-overlay">
                            <span><i class="bi bi-heart-fill"></i> 567</span>
                            <span><i class="bi bi-chat"></i> 89</span>
                        </div>
                    </div>
                    <div class="ig-grid-item">
                        <img src="https://picsum.photos/400?random=23" class="ig-grid-img" />
                        <div class="ig-grid-overlay">
                            <span><i class="bi bi-heart-fill"></i> 890</span>
                            <span><i class="bi bi-chat"></i> 156</span>
                        </div>
                    </div>
                </div>

                <div class="ig-grid-row">
                    <div class="ig-grid-item">
                        <img src="https://picsum.photos/400?random=24" class="ig-grid-img" />
                        <div class="ig-grid-overlay">
                            <span><i class="bi bi-heart-fill"></i> 123</span>
                            <span><i class="bi bi-chat"></i> 28</span>
                        </div>
                    </div>
                    <div class="ig-grid-item">
                        <img src="https://picsum.photos/400?random=25" class="ig-grid-img" />
                        <div class="ig-grid-overlay">
                            <span><i class="bi bi-heart-fill"></i> 456</span>
                            <span><i class="bi bi-chat"></i> 78</span>
                        </div>
                    </div>
                    <div class="ig-grid-item">
                        <img src="https://picsum.photos/400?random=26" class="ig-grid-img" />
                        <div class="ig-grid-overlay">
                            <span><i class="bi bi-heart-fill"></i> 342</span>
                            <span><i class="bi bi-chat"></i> 91</span>
                        </div>
                    </div>
                </div>

                <div class="ig-grid-row">
                    <div class="ig-grid-item">
                        <img src="https://picsum.photos/400?random=27" class="ig-grid-img" />
                        <div class="ig-grid-overlay">
                            <span><i class="bi bi-heart-fill"></i> 189</span>
                            <span><i class="bi bi-chat"></i> 34</span>
                        </div>
                    </div>
                    <div class="ig-grid-item">
                        <img src="https://picsum.photos/400?random=28" class="ig-grid-img" />
                        <div class="ig-grid-overlay">
                            <span><i class="bi bi-heart-fill"></i> 678</span>
                            <span><i class="bi bi-chat"></i> 123</span>
                        </div>
                    </div>
                    <div class="ig-grid-item">
                        <img src="https://picsum.photos/400?random=29" class="ig-grid-img" />
                        <div class="ig-grid-overlay">
                            <span><i class="bi bi-heart-fill"></i> 234</span>
                            <span><i class="bi bi-chat"></i> 56</span>
                        </div>
                    </div>
                </div>
            </section>

        </div>
    </form>

    <script>
        function showLogoutConfirm() {
            document.getElementById('logoutConfirmModal').style.display = 'block';
            document.body.style.overflow = 'hidden'; // Prevent background scrolling
        }

        function hideLogoutConfirm() {
            document.getElementById('logoutConfirmModal').style.display = 'none';
            document.body.style.overflow = 'auto'; // Restore scrolling
        }

        function confirmLogout() {
            document.getElementById('<%= btnLogout.ClientID %>').click();
        }

        // Close modal when clicking outside of it
        window.onclick = function(event) {
            var modal = document.getElementById('logoutConfirmModal');
            if (event.target == modal) {
                hideLogoutConfirm();
            }
        }

        // Close modal with Escape key
        document.addEventListener('keydown', function(event) {
            if (event.key === 'Escape') {
                hideLogoutConfirm();
            }
        });
    </script>
</body>
</html>
