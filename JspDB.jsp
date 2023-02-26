<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%!
    Connection con;
    PreparedStatement ps1, ps2;
    public void jspInit()
    {
        try
        {
            //loading the driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            //establish the connection
            con = DriverManager.getConnection(
                    "jdbc:mysql://dbtraik.cxvrj3wim5hk.ap-south-1.rds.amazonaws.com:3306/sys",
                    "abhijeet", "abhijeet");
            //create statement object
            ps1 = con.prepareStatement("select count(*) from user where iduser='?' and pass='?'");
            ps2 = con.prepareStatement("select * from user");
        }
        catch(Exception ex)
        {
            ex.printStackTrace();
        }
    }
%>
<%
    String param = request.getParameter("s1");
    if(param =="link")
    {
    	Statement statement;
        statement = con.createStatement();
        ResultSet rs;
        rs = statement.executeQuery("Select * from user");
        out.println("<table>");
        while(rs.next())
        {
            out.println("<tr>");
            out.println("<td>"+rs.getString(1)+"</td>");
            out.println("<td>"+rs.getString(2)+"</td");
            out.println("</tr>");
        }
        out.println("</table>");
        rs.close();
    }
    else
    {
        //write jdbc code for authentication
        String user = request.getParameter("uname");
        String pass = request.getParameter("pwd");
        //set form data as param value
        int cnt = 0;
        
        Statement statement;
        statement = con.createStatement();
        ResultSet rs;
        rs = statement.executeQuery("select count(*) from user where user='"+ user + "' and" + " pass='" + pass + "'");
        
        if (rs.next())
            cnt = rs.getInt(1);
        if(cnt == 0)
            out.println("<b><i><font color=red>Invalid credential</fonr></i></b>");
        else
        {
            out.println("<form><fieldset style= width:25%; >");
            out.println("<b><i><font color=red>valid credential..</fonr></i></b><br>");
            out.println("<b><i><font size=6 color=blue>Welcome to My Page</fonr></i></b>");
            out.println("</fieldset></form>");
        }
    }
%>
<%!
    public void jspDestroy()
    {
        try
        {
            //colse
            con.close();
        }
        catch(Exception ex)
        {
            ex.printStackTrace();
        }
    }
%>
