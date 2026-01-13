<%@ Page Language="C#" AutoEventWireup="true" CodeFile="editprofile.aspx.cs" Inherits="socialmedia1.editprofile" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Edit Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="bg-dark bg-gradient text-light">
    <form id="form1" runat="server">
        <div class="container py-4">
            <div class="row justify-content-center">
                <div class="col-lg-6 col-md-8">
                    <div class="card bg-secondary bg-opacity-25 border-light">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <span class="h5 mb-0">Edit Profile</span>
                            <a href="userprofile.aspx" class="btn btn-sm btn-outline-light">Back to Profile</a>
                        </div>

                        <div class="card-body">
                            <!-- Profile image + basic info row -->
                            <div class="d-flex align-items-center mb-4">
                                <!-- Profile image -->
                                <div class="me-3 text-center">
                                    <img src="https://i.pravatar.cc/150" alt="Profile"
                                         style="width:80px; height:80px; border-radius:50%; object-fit:cover; border:2px solid #fff; display:block; margin:0 auto 8px auto;" />
                                    <!-- File upload to change profile icon (UI only) -->
                                    <asp:FileUpload ID="fuProfileImage" runat="server" CssClass="form-control form-control-sm" />
                                    <small class="text-muted d-block mt-1" style="font-size: 0.75rem;">Choose a new profile picture</small>
                                </div>

                                <!-- Username + name -->
                                <div>
                                    <div class="text-muted small">Username</div>
                                    <asp:TextBox ID="txtUsername" runat="server"
                                                 CssClass="form-control form-control-sm mb-2" />
                                    <div class="text-muted small">Full name</div>
                                    <div class="d-flex gap-2">
                                        <asp:TextBox ID="txtFirstName" runat="server"
                                                     CssClass="form-control form-control-sm"
                                                     Placeholder="First name" />
                                        <asp:TextBox ID="txtLastName" runat="server"
                                                     CssClass="form-control form-control-sm"
                                                     Placeholder="Last name" />
                                    </div>
                                </div>
                            </div>

                            <!-- Email -->
                            <div class="mb-3">
                                <label for="txtEmail" class="form-label">Email</label>
                                <asp:TextBox ID="txtEmail" runat="server"
                                             CssClass="form-control"
                                             TextMode="Email" />
                            </div>

                            <!-- Phone -->
                            <div class="mb-3">
                                <label for="txtPhone" class="form-label">Phone</label>
                                <asp:TextBox ID="txtPhone" runat="server"
                                             CssClass="form-control" />
                            </div>

                            <!-- Bio -->
                            <div class="mb-3">
                                <label for="txtBio" class="form-label">Bio</label>
                                <asp:TextBox ID="txtBio" runat="server"
                                             TextMode="MultiLine" Rows="3"
                                             CssClass="form-control"
                                             Placeholder="Tell something about yourself..." />
                            </div>

                            <!-- Status label (optional) -->
                            <asp:Label ID="lblStatus" runat="server"
                                       CssClass="text-success d-block mb-2" />

                            <!-- Buttons -->
                            <div class="d-flex justify-content-end gap-2">
                                <asp:Button ID="btnCancel" runat="server"
                                            Text="Cancel"
                                            CssClass="btn btn-outline-light"
                                            PostBackUrl="userprofile.aspx" />

                                <asp:Button ID="btnSave" runat="server"
                                            Text="Save Changes"
                                            CssClass="btn btn-primary"
                                            OnClick="btnSave_Click" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>