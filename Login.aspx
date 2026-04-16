<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Login.aspx.vb" Inherits="Antigravity.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <style>
        body {
            background-color: #f5f5f5;
        }
        .login-container {
            margin-top: 100px;
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <div class="container login-container">
            <div class="row justify-content-center">
                <div class="col-md-4">

                    <div class="card shadow">
                        <div class="card-header text-center">
                            <h4>Login</h4>
                        </div>

                        <div class="card-body">

                            <div class="mb-3">
                                <label>Usuario</label>
                                <asp:TextBox ID="txtUsuario" runat="server" CssClass="form-control" />
                            </div>

                            <div class="mb-3">
                                <label>Contraseña</label>
                                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" />
                            </div>

                            <asp:Label ID="lblMensaje" runat="server" CssClass="text-danger"></asp:Label>

                            <div class="d-grid mt-3">
                                <asp:Button ID="btnLogin" runat="server" Text="Ingresar" CssClass="btn btn-primary" OnClick="btnLogin_Click" />
                            </div>

                        </div>
                    </div>

                </div>
            </div>
        </div>
    </form>

    <script>
        $(document).ready(function () {
            $('#<%= btnLogin.ClientID %>').click(function () {
                if ($('#<%= txtUsuario.ClientID %>').val() === '' ||
                    $('#<%= txtPassword.ClientID %>').val() === '') {

                    alert('Complete usuario y contraseña');
                    return false;
                }
            });
        });
    </script>
</body>
</html>
