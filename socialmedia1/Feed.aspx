<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Feed.aspx.cs" Inherits="socialmedia1.Feed" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>SocialHub - Feed</title>

    <!-- Google Font -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root {
            --bg: #0f172a;
            --card-bg: rgba(15, 23, 42, 0.95);
            --card-border: rgba(148, 163, 184, 0.35);
            --text-main: #e5e7eb;
            --text-muted: #9ca3af;
            --primary: #3b82f6;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: "Poppins", system-ui, -apple-system, sans-serif;
            background: #0f172a;
            margin: 0;
            padding: 0;
            color: var(--text-main);
            overflow: hidden;
        }

        /* Hide scrollbars but keep scrolling functionality */
        ::-webkit-scrollbar {
            display: none;
        }

        * {
            -ms-overflow-style: none;  /* IE and Edge */
            scrollbar-width: none;  /* Firefox */
        }

        .feed-wrapper {
            width: 100vw;
            height: 100vh;
            max-width: none;
            background: radial-gradient(circle at top left, #1d4ed8 0%, transparent 50%),
                        radial-gradient(circle at bottom right, #ec4899 0%, transparent 50%),
                        rgba(15, 23, 42, 0.85);
            border-radius: 0;
            border: none;
            box-shadow: none;
            overflow: hidden;
            backdrop-filter: blur(20px);
            display: flex;
            flex-direction: column;
        }

        .home-header {
            background: rgba(15, 23, 42, 0.95);
            border-bottom: 1px solid rgba(148, 163, 184, 0.3);
            padding: 12px 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .home-logo {
            font-size: 1.8rem;
            font-weight: 700;
            background: linear-gradient(135deg, #3b82f6, #ec4899);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .home-nav {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .nav-item {
            color: var(--text-main);
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s ease;
            position: relative;
        }

        .nav-item:hover {
            color: var(--primary);
        }

        .nav-item.active {
            color: var(--primary);
        }

        .nav-item.active::after {
            content: '';
            position: absolute;
            bottom: -12px;
            left: 0;
            right: 0;
            height: 2px;
            background: var(--primary);
        }

        .home-search {
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 20px;
            padding: 8px 16px;
            color: var(--text-main);
            width: 250px;
            font-size: 0.9rem;
            transition: all 0.3s ease;
        }

        .home-search:focus {
            outline: none;
            background: rgba(255, 255, 255, 0.15);
            border-color: var(--primary);
        }

        .home-actions {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .action-btn {
            background: none;
            border: none;
            color: var(--text-main);
            font-size: 1.2rem;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
        }

        .action-btn:hover {
            color: var(--primary);
            transform: scale(1.1);
        }

        .home-main {
            flex: 1;
            display: flex;
            overflow: hidden;
        }

        .home-sidebar {
            width: 240px;
            background: rgba(15, 23, 42, 0.95);
            border-right: 1px solid rgba(148, 163, 184, 0.3);
            padding: 20px;
            overflow-y: auto;
        }

        .home-content {
            flex: 1;
            padding: 20px;
            overflow-y: auto;
            max-width: 800px;
        }

        .home-right-sidebar {
            width: 320px;
            background: rgba(15, 23, 42, 0.95);
            border-left: 1px solid rgba(148, 163, 184, 0.3);
            padding: 20px;
            overflow-y: auto;
        }

        /* Search Bar Improvements */
        .search-container {
            position: relative;
            flex: 1;
            max-width: 400px;
        }

        .home-search {
            width: 100%;
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 25px;
            padding: 10px 45px 10px 20px;
            color: var(--text-main);
            font-size: 0.9rem;
            transition: all 0.3s ease;
        }

        .home-search:focus {
            outline: none;
            background: rgba(255, 255, 255, 0.15);
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
        }

        .search-icon {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-muted);
            pointer-events: none;
        }

        .search-results {
            position: absolute;
            top: 100%;
            left: 0;
            right: 0;
            background: rgba(15, 23, 42, 0.98);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 12px;
            margin-top: 8px;
            max-height: 400px;
            overflow-y: auto;
            z-index: 1000;
            display: none;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.4);
        }

        .search-result-item {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px 16px;
            cursor: pointer;
            transition: background 0.2s ease;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .search-result-item:hover {
            background: rgba(255, 255, 255, 0.05);
        }

        .search-result-item:last-child {
            border-bottom: none;
        }

        .search-result-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
        }

        .search-result-info {
            flex: 1;
        }

        .search-result-name {
            font-weight: 600;
            color: var(--text-main);
            margin-bottom: 2px;
        }

        .search-result-username {
            font-size: 0.85rem;
            color: var(--text-muted);
        }

        /* Follow Suggestions */
        .follow-suggestion {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px 0;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .follow-suggestion:last-child {
            border-bottom: none;
        }

        .follow-avatar {
            width: 48px;
            height: 48px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid rgba(255, 255, 255, 0.1);
        }

        .follow-info {
            flex: 1;
        }

        .follow-name {
            font-weight: 600;
            color: var(--text-main);
            margin-bottom: 2px;
            font-size: 0.95rem;
        }

        .follow-username {
            font-size: 0.85rem;
            color: var(--text-muted);
            margin-bottom: 4px;
        }

        .follow-bio {
            font-size: 0.8rem;
            color: var(--text-muted);
            line-height: 1.3;
        }

        .follow-btn {
            background: linear-gradient(135deg, #3b82f6, #ec4899);
            border: none;
            border-radius: 8px;
            padding: 6px 16px;
            color: white;
            font-size: 0.85rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .follow-btn:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3);
        }

        .follow-btn.following {
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        .follow-btn.following:hover {
            background: rgba(239, 68, 68, 0.2);
            border-color: #ef4444;
            color: #ef4444;
        }

        .suggestions-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 16px;
        }

        .see-all-link {
            color: var(--primary);
            text-decoration: none;
            font-size: 0.85rem;
            font-weight: 500;
            transition: color 0.3s ease;
        }

        .see-all-link:hover {
            color: #60a5fa;
        }

        /* Post Modal Styles */
        .post-modal {
            display: none;
            position: fixed;
            z-index: 10000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.8);
            backdrop-filter: blur(10px);
        }

        .post-modal-content {
            background: linear-gradient(135deg, #1e293b 0%, #334155 100%);
            margin: 5% auto;
            padding: 0;
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 16px;
            width: 90%;
            max-width: 800px;
            max-height: 90vh;
            overflow-y: auto;
            box-shadow: 0 25px 80px rgba(0, 0, 0, 0.4);
            color: #ffffff;
        }

        .post-modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 25px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .post-modal-header h3 {
            margin: 0;
            font-size: 1.2rem;
            font-weight: 600;
        }

        .post-modal-body {
            padding: 0;
        }

        .post-modal-media {
            width: 100%;
            max-height: 500px;
            object-fit: contain;
            background: #000;
        }

        .post-modal-info {
            padding: 25px;
        }

        .post-modal-title {
            font-size: 1.1rem;
            font-weight: 600;
            margin-bottom: 12px;
            color: var(--text-main);
        }

        .post-modal-description {
            font-size: 1rem;
            color: var(--text-muted);
            line-height: 1.5;
            margin-bottom: 20px;
        }

        .post-modal-stats {
            display: flex;
            gap: 20px;
            padding: 15px 25px;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .post-modal-stat {
            display: flex;
            align-items: center;
            gap: 8px;
            color: var(--text-muted);
            font-size: 0.9rem;
        }

        .post-modal-actions {
            display: flex;
            gap: 20px;
            padding: 20px 25px;
        }

        .post-modal-action {
            background: none;
            border: none;
            color: var(--text-muted);
            cursor: pointer;
            transition: color 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 1rem;
        }

        .post-modal-action:hover {
            color: var(--primary);
        }

        .post-modal-action.liked {
            color: #ef4444;
        }

        .sidebar-section {
            margin-bottom: 30px;
        }

        .sidebar-title {
            font-size: 0.8rem;
            font-weight: 600;
            color: var(--text-muted);
            text-transform: uppercase;
            margin-bottom: 12px;
        }

        .sidebar-item {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 10px;
            border-radius: 8px;
            cursor: pointer;
            transition: background 0.3s ease;
            margin-bottom: 4px;
        }

        .sidebar-item:hover {
            background: rgba(255, 255, 255, 0.05);
        }

        .sidebar-item.active {
            background: rgba(59, 130, 246, 0.1);
            color: var(--primary);
        }

        .sidebar-icon {
            width: 24px;
            height: 24px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .home-content {
            flex: 1;
            padding: 20px;
            overflow-y: auto;
        }

        .content-grid {
            display: flex;
            flex-direction: column;
            gap: 20px;
            max-width: 800px;
            margin: 0 auto;
        }

        .content-card {
            background: rgba(15, 23, 42, 0.95);
            border-radius: 16px;
            border: 1px solid rgba(148, 163, 184, 0.3);
            overflow: hidden;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            width: 100%;
            cursor: pointer;
        }

        .content-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.3);
        }

        .card-media {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }

        .card-body {
            padding: 16px;
        }

        .card-title {
            font-size: 1rem;
            font-weight: 600;
            margin-bottom: 8px;
            color: var(--text-main);
        }

        .card-description {
            font-size: 0.9rem;
            color: var(--text-muted);
            line-height: 1.4;
        }

        .card-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 12px 16px;
            border-top: 1px solid rgba(148, 163, 184, 0.2);
        }

        .card-actions {
            display: flex;
            gap: 15px;
        }

        .card-action {
            background: none;
            border: none;
            color: var(--text-muted);
            cursor: pointer;
            transition: color 0.3s ease;
            display: flex;
            align-items: center;
            gap: 4px;
            font-size: 0.9rem;
        }

        .card-action:hover {
            color: var(--primary);
        }

        .card-action.liked {
            color: #ef4444;
        }

        .create-post-btn {
            background: linear-gradient(135deg, #3b82f6, #ec4899);
            border: none;
            border-radius: 12px;
            padding: 12px 24px;
            color: white;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .create-post-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 16px rgba(59, 130, 246, 0.3);
        }

        /* Create Post Modal Styles */
        .create-post-modal {
            display: none;
            position: fixed;
            z-index: 10000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.7);
            backdrop-filter: blur(5px);
        }

        .create-post-modal-content {
            background: linear-gradient(135deg, #1e293b 0%, #334155 100%);
            margin: 5% auto;
            padding: 0;
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 16px;
            width: 500px;
            max-height: 90vh;
            overflow-y: auto;
            box-shadow: 0 25px 80px rgba(0, 0, 0, 0.4);
            color: #ffffff;
        }

        .image-preview {
            margin-top: 10px;
            border-radius: 8px;
            overflow: hidden;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .image-preview img {
            width: 100%;
            height: 200px;
            object-fit: cover;
            display: block;
        }

        .brand-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 18px;
        }

        .brand-left {
            display: flex;
            align-items: center;
            gap: 10px;
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
            font-size: 0.88rem;
            color: var(--text-muted);
        }

        .brand-right {
            font-size: 0.78rem;
            color: var(--text-muted);
        }

        /* Feed Profile Avatar Styles */
        .feed-profile-avatar {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            overflow: hidden;
            border: 2px solid rgba(148, 163, 184, 0.3);
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .feed-profile-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: block;
        }

        .feed-profile-avatar:hover {
            border-color: var(--primary);
            transform: scale(1.05);
        }

        .feed-title {
            font-size: 1.35rem;
            font-weight: 600;
            margin-bottom: 6px;
        }

        .feed-subtitle {
            font-size: 0.82rem;
            color: var(--text-muted);
            margin-bottom: 16px;
        }

        .post-card {
            background: rgba(15, 23, 42, 0.95);
            border-radius: 18px;
            border: 1px solid var(--card-border);
            padding: 12px;
            margin-bottom: 14px;
        }

        .post-header {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 8px;
        }

        .post-avatar {
            width: 34px;
            height: 34px;
            border-radius: 50%;
            object-fit: cover;
            border: 1px solid rgba(148, 163, 184, 0.6);
        }

        .post-user-name {
            font-size: 0.88rem;
            font-weight: 500;
        }

        .post-user-handle {
            font-size: 0.76rem;
            color: var(--text-muted);
        }

        .post-time {
            margin-left: auto;
            font-size: 0.74rem;
            color: var(--text-muted);
        }

        .post-text {
            font-size: 0.9rem;
            margin-bottom: 8px;
        }

        .post-media {
            border-radius: 14px;
            overflow: hidden;
            margin-bottom: 8px;
        }

        .post-media img {
            display: block;
            width: 100%;
            height: 260px;
            object-fit: cover;
        }

        .reels-title {
            font-size: 1rem;
            font-weight: 600;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .reels-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        .add-reel-btn {
            background: linear-gradient(135deg, #3b82f6 0%, #1d4ed8 100%);
            border: none;
            border-radius: 50%;
            width: 36px;
            height: 36px;
            color: white;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.9rem;
            box-shadow: 0 2px 8px rgba(59, 130, 246, 0.3);
        }

        .add-reel-btn:hover {
            background: linear-gradient(135deg, #60a5fa 0%, #3b82f6 100%);
            transform: scale(1.1);
            box-shadow: 0 4px 12px rgba(59, 130, 246, 0.4);
        }

        /* Add Reel Modal Styles */
        .add-reel-modal {
            display: none;
            position: fixed;
            z-index: 10000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.7);
            backdrop-filter: blur(5px);
        }

        .add-reel-modal-content {
            background: linear-gradient(135deg, #1e293b 0%, #334155 100%);
            margin: 10% auto;
            padding: 0;
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 16px;
            width: 450px;
            box-shadow: 0 25px 80px rgba(0, 0, 0, 0.4);
            color: #ffffff;
            overflow: hidden;
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 25px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .modal-header h3 {
            margin: 0;
            font-size: 1.2rem;
            font-weight: 600;
        }

        .close-modal {
            background: none;
            border: none;
            color: #9ca3af;
            font-size: 1.2rem;
            cursor: pointer;
            transition: color 0.3s ease;
        }

        .close-modal:hover {
            color: #ffffff;
        }

        .modal-body {
            padding: 25px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #e5e7eb;
        }

        .form-control {
            width: 100%;
            padding: 12px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 8px;
            background: rgba(255, 255, 255, 0.1);
            color: #ffffff;
            font-size: 0.9rem;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            outline: none;
            border-color: #3b82f6;
            background: rgba(255, 255, 255, 0.15);
        }

        .form-control::placeholder {
            color: #9ca3af;
        }

        .modal-footer {
            display: flex;
            gap: 12px;
            justify-content: flex-end;
            padding: 20px 25px;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
        }

        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 0.9rem;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn-cancel {
            background: rgba(255, 255, 255, 0.1);
            color: #ffffff;
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        .btn-cancel:hover {
            background: rgba(255, 255, 255, 0.2);
        }

        .btn-primary {
            background: linear-gradient(135deg, #3b82f6 0%, #1d4ed8 100%);
            color: white;
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, #60a5fa 0%, #3b82f6 100%);
            transform: translateY(-1px);
        }

        .reel-card {
            background: rgba(15, 23, 42, 0.9);
            border-radius: 0;
            border: none;
            padding: 0;
            margin: 0;
            height: 90vh;
            display: flex;
            flex-direction: column;
        }

        .reel-media {
            position: relative;
            border-radius: 0;
            overflow: hidden;
            flex: 1;
            margin-bottom: 0;
            background: #000;
        }

        .reel-media video {
            display: block;
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .reel-overlay {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            background: linear-gradient(to top, rgba(0, 0, 0, 0.7), transparent);
            padding: 20px;
            color: white;
        }

        .reel-info {
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
        }

        .reel-title {
            font-size: 1rem;
            font-weight: 600;
        }

        .reel-views {
            font-size: 0.8rem;
            opacity: 0.8;
        }

        .reel-caption {
            font-size: 0.86rem;
            padding: 15px;
            background: rgba(15, 23, 42, 0.9);
            margin: 0;
        }

        /* Reel Navigation Styles */
        .reel-container {
            position: relative;
        }

        .reel-corner-nav {
            position: absolute;
            top: 10px;
            left: 10px;
            display: flex;
            flex-direction: column;
            gap: 4px;
            z-index: 10;
        }

        .reel-nav-btn {
            background: rgba(15, 23, 42, 0.9);
            border: 1px solid rgba(148, 163, 184, 0.3);
            border-radius: 4px;
            padding: 4px 6px;
            color: var(--text-main);
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.7rem;
            width: 24px;
            height: 24px;
        }

        .corner-btn {
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.3);
        }

        .reel-nav-btn:hover {
            background: rgba(59, 130, 246, 0.3);
            border-color: var(--primary);
            transform: scale(1.1);
        }

        .reel-nav-btn:active {
            transform: scale(0.95);
        }

        @media (max-width: 900px) {
            body {
                padding: 12px;
            }

            .feed-wrapper {
                grid-template-columns: 1fr;
                max-width: 520px;
            }

            .feed-main {
                border-right: none;
                border-bottom: 1px solid rgba(148, 163, 184, 0.3);
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="feed-wrapper">
            <!-- Header -->
            <header class="home-header">
                <div class="home-logo">SocialHub</div>
                
                <div class="home-nav">
                    <a href="#" class="nav-item active">Home</a>
                    <a href="#" class="nav-item">Explore</a>
                    <a href="#" class="nav-item">Notifications</a>
                    <a href="userprofile.aspx" class="nav-item">Profile</a>
                </div>
                
                <div class="search-container">
                    <input type="text" placeholder="Search profiles..." class="home-search" id="searchInput" />
                    <i class="fa-solid fa-search search-icon"></i>
                    <div class="search-results" id="searchResults"></div>
                </div>
                
                <div class="home-actions">
                    <div class="feed-profile-avatar">
                        <asp:Image ID="imgFeedProfile" runat="server" CssClass="feed-profile-img" />
                        <div id="feedDefaultProfileIcon" style="display: none; width: 32px; height: 32px;">
                            <script src="https://cdn.lordicon.com/lordicon.js"></script>
                            <lord-icon
                                src="https://cdn.lordicon.com/kdduutaw.json"
                                trigger="loop"
                                delay="2000"
                                colors="primary:#4f46e5,secondary:#818cf8,tertiary:#c7d2fe"
                                style="width:32px;height:32px">
                            </lord-icon>
                        </div>
                    </div>
                    <button class="action-btn" title="Messages">
                        <i class="fa-solid fa-envelope"></i>
                    </button>
                    <button class="action-btn" title="Settings">
                        <i class="fa-solid fa-cog"></i>
                    </button>
                </div>
            </header>

            <!-- Main Content Area -->
            <div class="home-main">
                <!-- Sidebar -->
                <aside class="home-sidebar">
                    <div class="sidebar-section">
                        <div class="sidebar-title">Menu</div>
                        <div class="sidebar-item active">
                            <div class="sidebar-icon">
                                <i class="fa-solid fa-home"></i>
                            </div>
                            <span>Home</span>
                        </div>
                        <div class="sidebar-item">
                            <div class="sidebar-icon">
                                <i class="fa-solid fa-compass"></i>
                            </div>
                            <span>Explore</span>
                        </div>
                        <div class="sidebar-item">
                            <div class="sidebar-icon">
                                <i class="fa-solid fa-bell"></i>
                            </div>
                            <span>Notifications</span>
                        </div>
                        <div class="sidebar-item">
                            <div class="sidebar-icon">
                                <i class="fa-solid fa-envelope"></i>
                            </div>
                            <span>Messages</span>
                        </div>
                        <div class="sidebar-item">
                            <div class="sidebar-icon">
                                <i class="fa-solid fa-bookmark"></i>
                            </div>
                            <span>Saved</span>
                        </div>
                    </div>
                    
                    <div class="sidebar-section">
                        <div class="sidebar-title">Create</div>
                        <button type="button" class="create-post-btn">
                            <i class="fa-solid fa-plus"></i>
                            Create Post
                        </button>
                    </div>
                    
                    <div class="sidebar-section">
                        <div class="sidebar-title">Quick Links</div>
                        <div class="sidebar-item">
                            <div class="sidebar-icon">
                                <i class="fa-solid fa-film"></i>
                            </div>
                            <span>Reels</span>
                        </div>
                        <div class="sidebar-item">
                            <div class="sidebar-icon">
                                <i class="fa-solid fa-video"></i>
                            </div>
                            <span>Live</span>
                        </div>
                        <div class="sidebar-item">
                            <div class="sidebar-icon">
                                <i class="fa-solid fa-store"></i>
                            </div>
                            <span>Shop</span>
                        </div>
                    </div>
                </aside>

                <!-- Main Content -->
                <main class="home-content">
                    <div class="content-grid">
                        <!-- Sample Content Card 1 -->
                        <article class="content-card">
                            <img src="https://picsum.photos/400/300?random=1" alt="Content" class="card-media" />
                            <div class="card-body">
                                <h3 class="card-title">Amazing Sunset Photography</h3>
                                <p class="card-description">Captured this beautiful sunset at the beach today. Nature never fails to amaze!</p>
                            </div>
                            <div class="card-footer">
                                <div class="card-actions">
                                    <button class="card-action">
                                        <i class="fa-regular fa-heart"></i>
                                        <span>234</span>
                                    </button>
                                    <button class="card-action">
                                        <i class="fa-regular fa-comment"></i>
                                        <span>45</span>
                                    </button>
                                    <button class="card-action">
                                        <i class="fa-regular fa-share"></i>
                                        <span>12</span>
                                    </button>
                                </div>
                                <button class="card-action">
                                    <i class="fa-regular fa-bookmark"></i>
                                </button>
                            </div>
                        </article>

                        <!-- Sample Content Card 2 -->
                        <article class="content-card">
                            <img src="https://picsum.photos/400/300?random=2" alt="Content" class="card-media" />
                            <div class="card-body">
                                <h3 class="card-title">Urban Architecture</h3>
                                <p class="card-description">Modern city architecture never gets old. Love the geometric patterns and clean lines.</p>
                            </div>
                            <div class="card-footer">
                                <div class="card-actions">
                                    <button class="card-action liked">
                                        <i class="fa-solid fa-heart"></i>
                                        <span>567</span>
                                    </button>
                                    <button class="card-action">
                                        <i class="fa-regular fa-comment"></i>
                                        <span>89</span>
                                    </button>
                                    <button class="card-action">
                                        <i class="fa-regular fa-share"></i>
                                        <span>34</span>
                                    </button>
                                </div>
                                <button class="card-action">
                                    <i class="fa-regular fa-bookmark"></i>
                                </button>
                            </div>
                        </article>

                        <!-- Sample Content Card 3 -->
                        <article class="content-card">
                            <img src="https://picsum.photos/400/300?random=3" alt="Content" class="card-media" />
                            <div class="card-body">
                                <h3 class="card-title">Nature's Beauty</h3>
                                <p class="card-description">Found this hidden gem during my morning hike. Sometimes the best views require a little effort.</p>
                            </div>
                            <div class="card-footer">
                                <div class="card-actions">
                                    <button class="card-action">
                                        <i class="fa-regular fa-heart"></i>
                                        <span>123</span>
                                    </button>
                                    <button class="card-action">
                                        <i class="fa-regular fa-comment"></i>
                                        <span>28</span>
                                    </button>
                                    <button class="card-action">
                                        <i class="fa-regular fa-share"></i>
                                        <span>8</span>
                                    </button>
                                </div>
                                <button class="card-action">
                                    <i class="fa-regular fa-bookmark"></i>
                                </button>
                            </div>
                        </article>

                        <!-- Sample Content Card 4 -->
                        <article class="content-card">
                            <img src="https://picsum.photos/400/300?random=4" alt="Content" class="card-media" />
                            <div class="card-body">
                                <h3 class="card-title">Street Art Culture</h3>
                                <p class="card-description">Street art adds so much character to our cities. Love discovering new murals around town.</p>
                            </div>
                            <div class="card-footer">
                                <div class="card-actions">
                                    <button class="card-action">
                                        <i class="fa-regular fa-heart"></i>
                                        <span>890</span>
                                    </button>
                                    <button class="card-action">
                                        <i class="fa-regular fa-comment"></i>
                                        <span>156</span>
                                    </button>
                                    <button class="card-action">
                                        <i class="fa-regular fa-share"></i>
                                        <span>67</span>
                                    </button>
                                </div>
                                <button class="card-action">
                                    <i class="fa-regular fa-bookmark"></i>
                                </button>
                            </div>
                        </article>

                        <!-- Sample Content Card 5 -->
                        <article class="content-card">
                            <img src="https://picsum.photos/400/300?random=5" alt="Content" class="card-media" />
                            <div class="card-body">
                                <h3 class="card-title">Coffee Moments</h3>
                                <p class="card-description">Perfect coffee, perfect morning. Sometimes it's the simple things that bring the most joy.</p>
                            </div>
                            <div class="card-footer">
                                <div class="card-actions">
                                    <button class="card-action">
                                        <i class="fa-regular fa-heart"></i>
                                        <span>456</span>
                                    </button>
                                    <button class="card-action">
                                        <i class="fa-regular fa-comment"></i>
                                        <span>78</span>
                                    </button>
                                    <button class="card-action">
                                        <i class="fa-regular fa-share"></i>
                                        <span>23</span>
                                    </button>
                                </div>
                                <button class="card-action">
                                    <i class="fa-regular fa-bookmark"></i>
                                </button>
                            </div>
                        </article>

                        <!-- Sample Content Card 6 -->
                        <article class="content-card">
                            <img src="https://picsum.photos/400/300?random=6" alt="Content" class="card-media" />
                            <div class="card-body">
                                <h3 class="card-title">Tech Innovation</h3>
                                <p class="card-description">The future is here! Excited about all the new technology innovations happening around us.</p>
                            </div>
                            <div class="card-footer">
                                <div class="card-actions">
                                    <button class="card-action">
                                        <i class="fa-regular fa-heart"></i>
                                        <span>342</span>
                                    </button>
                                    <button class="card-action">
                                        <i class="fa-regular fa-comment"></i>
                                        <span>91</span>
                                    </button>
                                    <button class="card-action">
                                        <i class="fa-regular fa-share"></i>
                                        <span>45</span>
                                    </button>
                                </div>
                                <button class="card-action">
                                    <i class="fa-regular fa-bookmark"></i>
                                </button>
                            </div>
                        </article>
                    </div>
                </main>

                <!-- Right Sidebar with Follow Suggestions -->
                <aside class="home-right-sidebar">
                    <!-- Follow Suggestions Section -->
                    <div class="sidebar-section">
                        <div class="suggestions-header">
                            <div class="sidebar-title">Suggestions For You</div>
                            <a href="#" class="see-all-link">See All</a>
                        </div>
                        
                        <div class="follow-suggestion">
                            <img src="https://i.pravatar.cc/150?img=1" alt="User" class="follow-avatar" />
                            <div class="follow-info">
                                <div class="follow-name">Emma Wilson</div>
                                <div class="follow-username">@emmawilson</div>
                                <div class="follow-bio">Photographer | Travel enthusiast</div>
                            </div>
                            <button class="follow-btn" onclick="toggleFollow(this)">Follow</button>
                        </div>
                        
                        <div class="follow-suggestion">
                            <img src="https://i.pravatar.cc/150?img=2" alt="User" class="follow-avatar" />
                            <div class="follow-info">
                                <div class="follow-name">Alex Chen</div>
                                <div class="follow-username">@alexchen</div>
                                <div class="follow-bio">Tech entrepreneur | Startup mentor</div>
                            </div>
                            <button class="follow-btn" onclick="toggleFollow(this)">Follow</button>
                        </div>
                        
                        <div class="follow-suggestion">
                            <img src="https://i.pravatar.cc/150?img=3" alt="User" class="follow-avatar" />
                            <div class="follow-info">
                                <div class="follow-name">Sarah Martinez</div>
                                <div class="follow-username">@sarahmartinez</div>
                                <div class="follow-bio">Fitness coach | Healthy lifestyle</div>
                            </div>
                            <button class="follow-btn" onclick="toggleFollow(this)">Follow</button>
                        </div>
                        
                        <div class="follow-suggestion">
                            <img src="https://i.pravatar.cc/150?img=4" alt="User" class="follow-avatar" />
                            <div class="follow-info">
                                <div class="follow-name">David Kim</div>
                                <div class="follow-username">@davidkim</div>
                                <div class="follow-bio">Designer | Creative director</div>
                            </div>
                            <button class="follow-btn" onclick="toggleFollow(this)">Follow</button>
                        </div>
                        
                        <div class="follow-suggestion">
                            <img src="https://i.pravatar.cc/150?img=5" alt="User" class="follow-avatar" />
                            <div class="follow-info">
                                <div class="follow-name">Lisa Johnson</div>
                                <div class="follow-username">@lisajohnson</div>
                                <div class="follow-bio">Food blogger | Recipe developer</div>
                            </div>
                            <button class="follow-btn" onclick="toggleFollow(this)">Follow</button>
                        </div>
                    </div>

                    <!-- Trending Topics -->
                    <div class="sidebar-section">
                        <div class="sidebar-title">Trending Topics</div>
                        <div style="display: flex; flex-wrap: wrap; gap: 8px;">
                            <span style="background: rgba(59, 130, 246, 0.2); color: #3b82f6; padding: 4px 12px; border-radius: 16px; font-size: 0.8rem;">#Technology</span>
                            <span style="background: rgba(236, 72, 153, 0.2); color: #ec4899; padding: 4px 12px; border-radius: 16px; font-size: 0.8rem;">#Photography</span>
                            <span style="background: rgba(34, 197, 94, 0.2); color: #22c55e; padding: 4px 12px; border-radius: 16px; font-size: 0.8rem;">#Fitness</span>
                            <span style="background: rgba(251, 146, 60, 0.2); color: #fb923c; padding: 4px 12px; border-radius: 16px; font-size: 0.8rem;">#Travel</span>
                            <span style="background: rgba(168, 85, 247, 0.2); color: #a855f7; padding: 4px 12px; border-radius: 16px; font-size: 0.8rem;">#Design</span>
                        </div>
                    </div>

                    <!-- Quick Stats -->
                    <div class="sidebar-section">
                        <div class="sidebar-title">Your Activity</div>
                        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 12px;">
                            <div style="text-align: center; padding: 12px; background: rgba(255, 255, 255, 0.05); border-radius: 8px;">
                                <div style="font-size: 1.2rem; font-weight: 600; color: var(--primary);">24</div>
                                <div style="font-size: 0.75rem; color: var(--text-muted);">Posts</div>
                            </div>
                            <div style="text-align: center; padding: 12px; background: rgba(255, 255, 255, 0.05); border-radius: 8px;">
                                <div style="font-size: 1.2rem; font-weight: 600; color: var(--primary);">156</div>
                                <div style="font-size: 0.75rem; color: var(--text-muted);">Following</div>
                            </div>
                            <div style="text-align: center; padding: 12px; background: rgba(255, 255, 255, 0.05); border-radius: 8px;">
                                <div style="font-size: 1.2rem; font-weight: 600; color: var(--primary);">892</div>
                                <div style="font-size: 0.75rem; color: var(--text-muted);">Followers</div>
                            </div>
                            <div style="text-align: center; padding: 12px; background: rgba(255, 255, 255, 0.05); border-radius: 8px;">
                                <div style="font-size: 1.2rem; font-weight: 600; color: var(--primary);">45</div>
                                <div style="font-size: 0.75rem; color: var(--text-muted);">Likes</div>
                            </div>
                        </div>
                    </div>
                </aside>
            </div>
        </div>
    </form>

    <!-- Create Post Modal -->
    <div id="createPostModal" class="create-post-modal">
        <div class="create-post-modal-content">
            <div class="modal-header">
                <h3>Create New Post</h3>
                <button type="button" class="close-modal">
                    <i class="fa-solid fa-times"></i>
                </button>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label for="postImage">Upload Image</label>
                    <input type="file" id="postImage" accept="image/*" class="form-control" />
                    <div class="image-preview" id="imagePreview" style="display: none;">
                        <img id="previewImg" src="" alt="Preview" />
                    </div>
                </div>
                <div class="form-group">
                    <label for="postCaption">Caption</label>
                    <textarea id="postCaption" class="form-control" rows="4" placeholder="What's on your mind?"></textarea>
                </div>
                <div class="form-group">
                    <label for="postTags">Tags</label>
                    <input type="text" id="postTags" class="form-control" placeholder="Add tags separated by commas..." />
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-cancel">Cancel</button>
                <button type="button" class="btn btn-primary">Post</button>
            </div>
        </div>
    </div>

    <!-- Post Modal -->
    <div id="postModal" class="post-modal">
        <div class="post-modal-content">
            <div class="post-modal-header">
                <h3>Post Details</h3>
                <button type="button" class="close-modal" onclick="hidePostModal();">
                    <i class="fa-solid fa-times"></i>
                </button>
            </div>
            <div class="post-modal-body">
                <img id="modalPostImage" src="" alt="Post" class="post-modal-media" />
                <div class="post-modal-info">
                    <h3 id="modalPostTitle" class="post-modal-title">Post Title</h3>
                    <p id="modalPostDescription" class="post-modal-description">Post description goes here...</p>
                    <div class="post-modal-stats">
                        <div class="post-modal-stat">
                            <i class="fa-solid fa-heart"></i>
                            <span id="modalPostLikes">0</span> likes
                        </div>
                        <div class="post-modal-stat">
                            <i class="fa-solid fa-comment"></i>
                            <span id="modalPostComments">0</span> comments
                        </div>
                        <div class="post-modal-stat">
                            <i class="fa-solid fa-share"></i>
                            <span id="modalPostShares">0</span> shares
                        </div>
                    </div>
                    <div class="post-modal-actions">
                        <button type="button" class="post-modal-action" id="modalLikeBtn" onclick="toggleModalLike();">
                            <i class="fa-regular fa-heart"></i>
                            <span>Like</span>
                        </button>
                        <button type="button" class="post-modal-action">
                            <i class="fa-regular fa-comment"></i>
                            <span>Comment</span>
                        </button>
                        <button type="button" class="post-modal-action">
                            <i class="fa-regular fa-share"></i>
                            <span>Share</span>
                        </button>
                        <button type="button" class="post-modal-action">
                            <i class="fa-regular fa-bookmark"></i>
                            <span>Save</span>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Create Post Modal Functions
        function showCreatePostModal() {
            event.preventDefault();
            document.getElementById('createPostModal').style.display = 'block';
            document.body.style.overflow = 'hidden';
        }

        function hideCreatePostModal() {
            event.preventDefault();
            document.getElementById('createPostModal').style.display = 'none';
            document.body.style.overflow = 'auto';
            // Reset form
            document.getElementById('postImage').value = '';
            document.getElementById('postCaption').value = '';
            document.getElementById('postTags').value = '';
            document.getElementById('imagePreview').style.display = 'none';
        }

        // Initialize event listeners when DOM is loaded
        document.addEventListener('DOMContentLoaded', function() {
            // Create post button
            const createPostBtn = document.querySelector('.create-post-btn');
            if (createPostBtn) {
                createPostBtn.addEventListener('click', function(e) {
                    e.preventDefault();
                    e.stopPropagation();
                    showCreatePostModal();
                });
            }

            // Modal close button
            const closeModalBtn = document.querySelector('.close-modal');
            if (closeModalBtn) {
                closeModalBtn.addEventListener('click', function(e) {
                    e.preventDefault();
                    e.stopPropagation();
                    hideCreatePostModal();
                });
            }

            // Cancel button
            const cancelBtn = document.querySelector('.btn-cancel');
            if (cancelBtn) {
                cancelBtn.addEventListener('click', function(e) {
                    e.preventDefault();
                    e.stopPropagation();
                    hideCreatePostModal();
                });
            }

            // Post button
            const postBtn = document.querySelector('.btn-primary');
            if (postBtn) {
                postBtn.addEventListener('click', function(e) {
                    e.preventDefault();
                    e.stopPropagation();
                    savePost();
                });
            }

            // Image preview functionality
            const postImageInput = document.getElementById('postImage');
            if (postImageInput) {
                postImageInput.addEventListener('change', function(e) {
                    const file = e.target.files[0];
                    if (file) {
                        const reader = new FileReader();
                        reader.onload = function(e) {
                            document.getElementById('previewImg').src = e.target.result;
                            document.getElementById('imagePreview').style.display = 'block';
                        };
                        reader.readAsDataURL(file);
                    }
                });
            }

            // Search functionality
            const searchInput = document.getElementById('searchInput');
            const searchResults = document.getElementById('searchResults');
            
            if (searchInput && searchResults) {
                // Sample user data for search
                const users = [
                    { name: 'Emma Wilson', username: '@emmawilson', avatar: 'https://i.pravatar.cc/150?img=1', bio: 'Photographer | Travel enthusiast' },
                    { name: 'Alex Chen', username: '@alexchen', avatar: 'https://i.pravatar.cc/150?img=2', bio: 'Tech entrepreneur | Startup mentor' },
                    { name: 'Sarah Martinez', username: '@sarahmartinez', avatar: 'https://i.pravatar.cc/150?img=3', bio: 'Fitness coach | Healthy lifestyle' },
                    { name: 'David Kim', username: '@davidkim', avatar: 'https://i.pravatar.cc/150?img=4', bio: 'Designer | Creative director' },
                    { name: 'Lisa Johnson', username: '@lisajohnson', avatar: 'https://i.pravatar.cc/150?img=5', bio: 'Food blogger | Recipe developer' },
                    { name: 'Michael Brown', username: '@michaelbrown', avatar: 'https://i.pravatar.cc/150?img=6', bio: 'Software engineer | Tech enthusiast' },
                    { name: 'Jessica Davis', username: '@jessicadavis', avatar: 'https://i.pravatar.cc/150?img=7', bio: 'Artist | Creative mind' },
                    { name: 'Ryan Garcia', username: '@ryangarcia', avatar: 'https://i.pravatar.cc/150?img=8', bio: 'Music producer | DJ' }
                ];

                searchInput.addEventListener('input', function(e) {
                    const query = e.target.value.toLowerCase().trim();
                    
                    if (query.length === 0) {
                        searchResults.style.display = 'none';
                        return;
                    }

                    const filteredUsers = users.filter(user => 
                        user.name.toLowerCase().includes(query) || 
                        user.username.toLowerCase().includes(query) ||
                        user.bio.toLowerCase().includes(query)
                    );

                    if (filteredUsers.length > 0) {
                        searchResults.innerHTML = filteredUsers.map(user => `
                            <div class="search-result-item" onclick="viewProfile('${user.username}')">
                                <img src="${user.avatar}" alt="${user.name}" class="search-result-avatar" />
                                <div class="search-result-info">
                                    <div class="search-result-name">${user.name}</div>
                                    <div class="search-result-username">${user.username}</div>
                                </div>
                            </div>
                        `).join('');
                        searchResults.style.display = 'block';
                    } else {
                        searchResults.innerHTML = `
                            <div class="search-result-item">
                                <div class="search-result-info">
                                    <div class="search-result-name">No results found</div>
                                    <div class="search-result-username">Try a different search term</div>
                                </div>
                            </div>
                        `;
                        searchResults.style.display = 'block';
                    }
                });

                // Hide search results when clicking outside
                document.addEventListener('click', function(e) {
                    if (!searchInput.contains(e.target) && !searchResults.contains(e.target)) {
                        searchResults.style.display = 'none';
                    }
                });
            }
        });

        function savePost() {
            const imageFile = document.getElementById('postImage').files[0];
            const caption = document.getElementById('postCaption').value;
            const tags = document.getElementById('postTags').value;
            
            if (!caption.trim()) {
                alert('Please add a caption for your post.');
                return;
            }
            
            // Convert image to base64 if exists
            let imageBase64 = null;
            if (imageFile) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    imageBase64 = e.target.result;
                    createPostInDatabase(imageBase64, caption, tags);
                };
                reader.readAsDataURL(imageFile);
            } else {
                createPostInDatabase(null, caption, tags);
            }
        }

        function createPostInDatabase(imageBase64, caption, tags) {
            // Create new post card
            const newPost = {
                id: Date.now(),
                image: imageBase64 || `https://picsum.photos/400/300?random=${Math.random()}`,
                title: caption.substring(0, 50) + (caption.length > 50 ? '...' : ''),
                description: caption,
                likes: 0,
                comments: 0,
                shares: 0,
                timestamp: 'Just now',
                tags: tags.split(',').map(tag => tag.trim()).filter(tag => tag)
            };
            
            // Add to beginning of content grid
            const contentGrid = document.querySelector('.content-grid');
            const newCard = createPostCard(newPost);
            contentGrid.insertBefore(newCard, contentGrid.firstChild);
            
            // Log activity to UserActivity table
            logUserActivityToDatabase('post', 'create', caption, imageBase64, tags);
            
            hideCreatePostModal();
            
            // Show success message
            showSuccessMessage('Post created successfully!');
        }

        function createPostCard(post) {
            const card = document.createElement('article');
            card.className = 'content-card';
            card.innerHTML = `
                <img src="${post.image}" alt="Post" class="card-media" />
                <div class="card-body">
                    <h3 class="card-title">${post.title}</h3>
                    <p class="card-description">${post.description}</p>
                </div>
                <div class="card-footer">
                    <div class="card-actions">
                        <button class="card-action" onclick="toggleLike(this, ${post.id}); event.stopPropagation();">
                            <i class="fa-regular fa-heart"></i>
                            <span>${post.likes}</span>
                        </button>
                        <button class="card-action" onclick="event.stopPropagation();">
                            <i class="fa-regular fa-comment"></i>
                            <span>${post.comments}</span>
                        </button>
                        <button class="card-action" onclick="event.stopPropagation();">
                            <i class="fa-regular fa-share"></i>
                            <span>${post.shares}</span>
                        </button>
                    </div>
                    <button class="card-action" onclick="event.stopPropagation();">
                        <i class="fa-regular fa-bookmark"></i>
                    </button>
                </div>
            `;
            
            // Add click event to show post modal
            card.addEventListener('click', function(e) {
                if (!e.target.closest('.card-action')) {
                    showPostModal(post);
                }
            });
            
            return card;
        }

        function toggleLike(button, postId) {
            const icon = button.querySelector('i');
            const count = button.querySelector('span');
            const isLiked = icon.classList.contains('fa-solid');
            
            if (isLiked) {
                icon.classList.remove('fa-solid');
                icon.classList.add('fa-regular');
                button.classList.remove('liked');
                count.textContent = parseInt(count.textContent) - 1;
            } else {
                icon.classList.remove('fa-regular');
                icon.classList.add('fa-solid');
                button.classList.add('liked');
                count.textContent = parseInt(count.textContent) + 1;
            }
            
            // Log like activity
            logUserActivityToDatabase('post', 'like', `Post ID: ${postId}`, null, null);
        }

        function logUserActivityToDatabase(activityType, action, content, mediaUrl, tags) {
            // In a real application, this would make an AJAX call to the server
            // For demo purposes, we'll simulate the database call
            
            const activityData = {
                UserID: '<%= Session["UserID"] %>',
                ActivityType: activityType,
                ActionType: action,
                Content: content,
                MediaUrl: mediaUrl ? mediaUrl.substring(0, 500) : null, // Limit URL length
                Tags: tags,
                CreatedAt: new Date().toISOString()
            };
            
            // Log to console for demo (in real app, send to server)
            console.log('Activity to be saved to UserActivity table:', activityData);
            
            // Simulate successful database save
            console.log('✅ Activity logged to UserActivity table successfully');
            
            // In a real implementation, you would use fetch() or XMLHttpRequest
            // to send this data to your ASP.NET server-side code
        }

        function showSuccessMessage(message) {
            // Create success notification
            const notification = document.createElement('div');
            notification.style.cssText = `
                position: fixed;
                top: 20px;
                right: 20px;
                background: linear-gradient(135deg, #10b981, #059669);
                color: white;
                padding: 15px 20px;
                border-radius: 8px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
                z-index: 10001;
                font-weight: 500;
                animation: slideIn 0.3s ease;
            `;
            notification.textContent = message;
            document.body.appendChild(notification);
            
            // Remove after 3 seconds
            setTimeout(() => {
                notification.style.animation = 'slideOut 0.3s ease';
                setTimeout(() => {
                    document.body.removeChild(notification);
                }, 300);
            }, 3000);
        }

        // Add slide animations
        const style = document.createElement('style');
        style.textContent = `
            @keyframes slideIn {
                from {
                    transform: translateX(100%);
                    opacity: 0;
                }
                to {
                    transform: translateX(0);
                    opacity: 1;
                }
            }
            
            @keyframes slideOut {
                from {
                    transform: translateX(0);
                    opacity: 1;
                }
                to {
                    transform: translateX(100%);
                    opacity: 0;
                }
            }
        `;
        document.head.appendChild(style);

        function toggleFollow(button) {
            const isFollowing = button.classList.contains('following');
            
            if (isFollowing) {
                button.classList.remove('following');
                button.textContent = 'Follow';
                // Log unfollow activity
                logUserActivityToDatabase('follow', 'unfollow', button.parentElement.querySelector('.follow-name').textContent, null, null);
            } else {
                button.classList.add('following');
                button.textContent = 'Following';
                // Log follow activity
                logUserActivityToDatabase('follow', 'follow', button.parentElement.querySelector('.follow-name').textContent, null, null);
            }
        }

        function viewProfile(username) {
            // Hide search results
            document.getElementById('searchResults').style.display = 'none';
            document.getElementById('searchInput').value = '';
            
            // Log profile view activity
            logUserActivityToDatabase('profile', 'view', username, null, null);
            
            // In a real application, this would navigate to the user's profile
            console.log('Viewing profile:', username);
            // For demo, we'll show an alert
            showSuccessMessage(`Viewing profile: ${username}`);
        }

        // Post Modal Functions
        let currentPostData = null;

        function showPostModal(post) {
            currentPostData = post;
            document.getElementById('modalPostImage').src = post.image;
            document.getElementById('modalPostTitle').textContent = post.title;
            document.getElementById('modalPostDescription').textContent = post.description;
            document.getElementById('modalPostLikes').textContent = post.likes;
            document.getElementById('modalPostComments').textContent = post.comments;
            document.getElementById('modalPostShares').textContent = post.shares;
            
            // Reset like button state
            const modalLikeBtn = document.getElementById('modalLikeBtn');
            const modalLikeIcon = modalLikeBtn.querySelector('i');
            modalLikeIcon.classList.remove('fa-solid', 'fa-regular');
            modalLikeIcon.classList.add('fa-regular');
            modalLikeBtn.classList.remove('liked');
            
            document.getElementById('postModal').style.display = 'block';
            document.body.style.overflow = 'hidden';
            
            // Log post view activity
            logUserActivityToDatabase('post', 'view', post.title, post.image, null);
        }

        function hidePostModal() {
            document.getElementById('postModal').style.display = 'none';
            document.body.style.overflow = 'auto';
            currentPostData = null;
        }

        function toggleModalLike() {
            if (!currentPostData) return;
            
            const modalLikeBtn = document.getElementById('modalLikeBtn');
            const modalLikeIcon = modalLikeBtn.querySelector('i');
            const modalLikeCount = document.getElementById('modalPostLikes');
            const isLiked = modalLikeIcon.classList.contains('fa-solid');
            
            if (isLiked) {
                modalLikeIcon.classList.remove('fa-solid');
                modalLikeIcon.classList.add('fa-regular');
                modalLikeBtn.classList.remove('liked');
                currentPostData.likes--;
                modalLikeCount.textContent = currentPostData.likes;
            } else {
                modalLikeIcon.classList.remove('fa-regular');
                modalLikeIcon.classList.add('fa-solid');
                modalLikeBtn.classList.add('liked');
                currentPostData.likes++;
                modalLikeCount.textContent = currentPostData.likes;
            }
            
            // Update the original card's like count
            const originalCard = document.querySelector(`.content-card:has(img[src="${currentPostData.image}"])`);
            if (originalCard) {
                const originalLikeBtn = originalCard.querySelector('.card-action');
                const originalLikeIcon = originalLikeBtn.querySelector('i');
                const originalLikeCount = originalLikeBtn.querySelector('span');
                
                originalLikeIcon.classList.remove('fa-solid', 'fa-regular');
                originalLikeIcon.classList.add(isLiked ? 'fa-regular' : 'fa-solid');
                originalLikeBtn.classList.toggle('liked', !isLiked);
                originalLikeCount.textContent = currentPostData.likes;
            }
            
            // Log like activity
            logUserActivityToDatabase('post', 'like', currentPostData.title, currentPostData.image, null);
        }

        // Close modal when clicking outside
        window.onclick = function(event) {
            const createModal = document.getElementById('createPostModal');
            const addReelModal = document.getElementById('addReelModal');
            const postModal = document.getElementById('postModal');
            
            if (event.target == createModal) {
                hideCreatePostModal();
            }
            
            if (event.target == addReelModal) {
                hideAddReelModal();
            }
            
            if (event.target == postModal) {
                hidePostModal();
            }
        }
        const reels = [
            {
                video: 'https://www.w3schools.com/html/mov_bbb.mp4',
                title: 'Sunset Timelapse',
                caption: 'Beautiful sunset timelapse over the city skyline.',
                views: '1.2M'
            },
            {
                video: 'https://www.w3schools.com/html/movie.mp4',
                title: 'Ocean Waves',
                caption: 'Relaxing ocean waves on a sunny day.',
                views: '856K'
            },
            {
                video: 'https://www.w3schools.com/html/mov_bbb.mp4',
                title: 'City Lights',
                caption: 'Night time city lights from above.',
                views: '3.4M'
            },
            {
                video: 'https://www.w3schools.com/html/movie.mp4',
                title: 'Nature Documentary',
                caption: 'Exploring the wonders of nature.',
                views: '567K'
            }
        ];

        let currentReelIndex = 0;

        function showReel(index) {
            const reel = reels[index];
            const reelVideo = document.getElementById('reelVideo');
            const reelTitle = document.getElementById('reelTitle');
            const reelViews = document.getElementById('reelViews');
            const reelCaption = document.getElementById('reelCaption');
            
            // Change video source
            reelVideo.src = reel.video;
            reelVideo.load(); // Load new video
            
            // Update text content
            reelTitle.textContent = reel.title;
            reelViews.textContent = reel.views;
            reelCaption.textContent = reel.caption;
            
            // Auto-play video
            reelVideo.play();
        }

        let autoPlayInterval;
        let isAutoPlaying = false;

        function startAutoPlay() {
            if (!isAutoPlaying) return;
            
            autoPlayInterval = setInterval(() => {
                nextReel();
            }, 8000); // Change reel every 8 seconds
        }

        function stopAutoPlay() {
            isAutoPlaying = false;
            if (autoPlayInterval) {
                clearInterval(autoPlayInterval);
            }
        }

        function toggleAutoPlay() {
            if (isAutoPlaying) {
                stopAutoPlay();
            } else {
                isAutoPlaying = true;
                startAutoPlay();
            }
        }

        function nextReel() {
            currentReelIndex = (currentReelIndex + 1) % reels.length;
            showReel(currentReelIndex);
        }

        function previousReel() {
            currentReelIndex = (currentReelIndex - 1 + reels.length) % reels.length;
            showReel(currentReelIndex);
        }

        // Initialize with auto-play on page load
        document.addEventListener('DOMContentLoaded', function() {
            isAutoPlaying = true;
            startAutoPlay();
        });

        // Navigation buttons only - no auto-play resume
        document.addEventListener('DOMContentLoaded', function() {
            const navButtons = document.querySelectorAll('.reel-nav-btn');
            navButtons.forEach(btn => {
                btn.addEventListener('click', function() {
                    // Just change reel, no auto-play management
                });
            });
        });

        // Keyboard navigation
        document.addEventListener('keydown', function(event) {
            if (event.key === 'ArrowUp') {
                previousReel();
            } else if (event === 'ArrowDown') {
                nextReel();
            }
        });

        // Add Reel Modal Functions
        function showAddReelModal() {
            document.getElementById('addReelModal').style.display = 'block';
            document.body.style.overflow = 'hidden';
        }

        function hideAddReelModal() {
            document.getElementById('addReelModal').style.display = 'none';
            document.body.style.overflow = 'auto';
        }

        function uploadReel() {
            const videoFile = document.getElementById('reelVideoFile').files[0];
            const caption = document.getElementById('reelCaption').value;
            
            if (!videoFile) {
                alert('Please select a video file.');
                return;
            }
            
            // Convert video to base64 (for demo purposes)
            const reader = new FileReader();
            reader.onload = function(e) {
                const videoBase64 = e.target.result;
                
                // Add new reel to the beginning of the array
                const newReel = {
                    video: videoBase64,
                    title: 'Your New Reel',
                    caption: caption || 'Check out my new reel!',
                    views: 'Just now'
                };
                
                reels.unshift(newReel);
                currentReelIndex = 0;
                showReel(0);
                
                // Log activity (in real app, this would be sent to server)
                logUserActivity('reel', 'upload', caption);
                
                hideAddReelModal();
                
                // Reset form
                document.getElementById('reelVideoFile').value = '';
                document.getElementById('reelCaption').value = '';
            };
            reader.readAsDataURL(videoFile);
        }

        function logUserActivity(activityType, action, content) {
            // Log to console for demo (in real app, send to server)
            console.log('Activity logged:', {
                type: activityType,
                action: action,
                content: content,
                timestamp: new Date().toISOString(),
                userId: '<%= Session["UserID"] %>'
            });
        }

        // Close modal when clicking outside
        window.onclick = function(event) {
            var modal = document.getElementById('addReelModal');
            if (event.target == modal) {
                hideAddReelModal();
            }
        }
    </script>
</body>
</html>
