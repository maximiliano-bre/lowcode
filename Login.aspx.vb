Imports System.Data.SqlClient

Public Class Login
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Private Sub btnLogin_Click(sender As Object, e As EventArgs) Handles btnLogin.Click
        Dim usuario As String = txtUsuario.Text.Trim()
        Dim password As String = txtPassword.Text.Trim()

        ' Cadena de conexión (ajustar)
        Dim connStr As String = "Data Source=.;Initial Catalog=TuBase;Integrated Security=True"

        Using conn As New SqlConnection(connStr)
            Try
                conn.Open()

                Dim query As String = "SELECT COUNT(*) FROM Usuarios WHERE Usuario=@Usuario AND Password=@Password"

                Using cmd As New SqlCommand(query, conn)
                    cmd.Parameters.AddWithValue("@Usuario", usuario)
                    cmd.Parameters.AddWithValue("@Password", password)

                    Dim result As Integer = Convert.ToInt32(cmd.ExecuteScalar())

                    If result > 0 Then
                        Session("Usuario") = usuario
                        Response.Redirect("Default.aspx")
                    Else
                        lblMensaje.Text = "Usuario o contraseña incorrectos"
                    End If
                End Using

            Catch ex As Exception
                lblMensaje.Text = "Error: " & ex.Message
            End Try
        End Using
    End Sub
End Class