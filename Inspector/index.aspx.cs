﻿using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;
using System.Web.Configuration;
using System.Web.Security;
using System.Web.UI.WebControls;
using Inspector.Classes;
using Inspector.Persist;

public partial class Index : System.Web.UI.Page
{
    protected void Page_Init(object sender, EventArgs e)
    {
        if (Page.User.Identity.IsAuthenticated == true)
        {
            FormsAuthentication.SignOut();
            Session.Clear();
            Session.Abandon();
            HttpCookie cookie = new HttpCookie(FormsAuthentication.FormsCookieName, "");
            cookie.Expires = DateTime.Now.AddYears(-1);
            Response.Cookies.Add(cookie);
            SessionStateSection sessionStateSection = (SessionStateSection)WebConfigurationManager.GetSection("system.web/sessionState");
            HttpCookie cookie2 = new HttpCookie(sessionStateSection.CookieName, "");
            cookie2.Expires = DateTime.Now.AddYears(-1);
            Response.Cookies.Add(cookie2);
            Response.Redirect(Request.RawUrl);
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    protected void Login1_Authenticate(object sender, AuthenticateEventArgs e)
    {
        string auth = this.ValidarUsuario(Login1.UserName, Login1.Password);

        if (auth == "OK")
        {
            FormsAuthentication.RedirectFromLoginPage(Login1.UserName, Login1.RememberMeSet);
        }
        else
        {
            Label lbl = (Label)Login1.FindControl("msg");
            lbl.Text = auth;
        }

    }

    protected string ValidarUsuario(string usuario, string senha)
    {
        string retorno = null;
        UsuarioDB db = new UsuarioDB();

        if (db.IsAlphaNumeric(usuario))
        {
            string connection = ConfigurationManager.ConnectionStrings["InspectorDB"].ConnectionString;
            SqlConnection _context = new SqlConnection(connection);
            Usuario obj = null;
            string sql = "SELECT * FROM [dbo].[Usuario] WHERE Username = @usuario";
            SqlCommand cmd = new SqlCommand(sql, _context);
            SqlParameter user = new SqlParameter();
            user.ParameterName = "@usuario"; user.Value = usuario.Trim(); cmd.Parameters.Add(user);

            try
            {
                _context.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    obj = new Usuario();
                    obj.Senha = Convert.ToString(reader["Senha"]);
                    obj.Nivel = Convert.ToChar(reader["Nivel"]);
                    obj.IsBlock = Convert.ToBoolean(reader["IsBlock"]);

                    if (db.HashCompare(obj.Senha, senha))
                    {
                        if (!obj.IsBlock)
                        {
                            Session["Nivel"] = reader["Nivel"];
                            string sn;
                            if (Convert.ToString(reader["Nome"]).IndexOf(" ") == -1)
                            {
                                sn = "";
                            }
                            else
                            {
                                sn = Convert.ToString(reader["Nome"]).Substring(Convert.ToString(reader["Nome"]).IndexOf(" ") + 1, 1);
                            }
                            Session["Ini"] = Convert.ToString(reader["Nome"]).Substring(0, 1) + sn;
                            retorno = "OK";
                        }
                        else
                        {
                            retorno = "Usuário bloqueado.";
                        }
                    }
                    else
                    {
                        retorno = "Senha incorreta.";
                    }
                }
                else{
                    retorno = "Este usuário não existe.";
                }
                reader.Close();
            }
            catch
            {
                retorno = "Erro de conexão com o banco de dados. Tente novamente mais tarde.";
            }
            finally
            {
                _context.Close();
            }
        }
        else
        {
            retorno = "Formato de entrada inválido.";
        }
        return retorno;
    }
}
