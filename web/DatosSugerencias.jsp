<%@page import="java.sql.*" %>
<%@page import="bd.*" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Datos Sugerencias</title>
        <link href="css/estilo.css" rel="stylesheet" type="text/css"/>
        <%!
            String consulta;
            Connection cn;
            PreparedStatement pst;
            ResultSet rs;
            String s_accion;
            String s_idarea;
            String s_nombre;
            String s_ht;
            String s_salario;
          
            
        %>
    </head>
    <body>
        <%
            try{
                ConectaBd bd = new ConectaBd();
                cn = bd.getConnection();
                
                s_accion = request.getParameter("f_accion");
                s_idarea = request.getParameter("f_idarea");
                
                if(s_accion!=null && s_accion.equals("M1")){
                    consulta = "    select descripcion, fecha, idpersona "
                                + " from sugerencia "
                                + " where"
                                + " idsugerencia = " + s_idarea + "; ";
                    //out.print(consulta);
                    pst = cn.prepareStatement(consulta);
                    rs = pst.executeQuery();
                    if (rs.next()) {
        %>
        
        <form name="EditarAreaForm" action="DatosSugerencias.jsp.jsp" method="GET">
            <table border="0" align="center">
                <thead>
                    <tr>
                        <th colspan="2">Editar Sugerencia</th>
                        
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Descripcion: </td>
                        <td><input type="text" name="f_nombre" value="<% out.print(rs.getString(1)); %>" maxlength="30" size="20" /></td>
                    </tr>
                    <tr>
                        <td>Fecha: </td>
                        <td><input type="text" name="f_ht" value="<% out.print(rs.getString(2)); %>" maxlength="10" size="20" /></td>
                    </tr>
                    <tr>
                        <td>Persona: </td>
                        <td><input type="text" name="f_salario" value="<% out.print(rs.getString(3)); %>" maxlength="10" size="4"/></td> 
                    </tr>
                    <tr align="center">
                        <td colspan="2">
                            <input type="submit" value="Editar" name="f_editar" />
                            <input type="hidden" name="f_accion" value="M2" />
                            <input type="hidden" name="f_idarea" value="<% out.print(s_idarea); %>" />
                        </td>
                    </tr>
                </tbody>
            </table>

        </form>
        <%
                }
            }else{
        %>
        <form name="AgregarAreaForm" action="DatosSugerencias.jsp" method="GET">
            <table border="0" align="center">
                <thead>
                    <tr>
                        <th colspan="2">Agregar Sugerencia</th>
                        
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Descripcion: </td>
                        <td><input type="text" name="f_nombre" value="" maxlength="30" size="20" /></td>
                    </tr>
                    <tr>
                        <td>Fecha: </td>
                        <td><input type="text" name="f_ht" value="" maxlength="40" size="20" /></td>
                    </tr>
                    <tr>
                        <td>Persona: </td>
                        <td><input type="text" name="f_salario" value="" maxlength="5" size="2"/></td>
                    </tr>
                    <tr align="center">
                        <td colspan="2">
                            <input type="submit" value="Agregar" name="f_agregar" />
                            <input type="hidden" name="f_accion" value="C" />
                        </td>
                    </tr>
                </tbody>
            </table>
        </form>
        <%
        }
        %>
        
        <table border="1" cellspacing="0" cellpadding="" align = "center" class="general" style="margin: auto; display: table"> 
            <thead>
                <tr>
                    <th colspan="8">Datos Segerencias</th>
                </tr>
                <tr>
                    <th>N°</th>
                    <th>Descripcion</th>
                    <th>Fecha</th>
                    <th>Persona</th>
                    <th colspan="2">Acciones</th>
                </tr>
            </thead>

        <%
            
                
                if (s_accion!=null) {
                    if (s_accion.equals("E")) {
                        consulta =  "   delete from sugerencia "
                                    + " where "
                                    + " idsugerencia = " + s_idarea + "; ";
                        //out.print(consulta);
                        pst = cn.prepareStatement(consulta);
                        pst.executeUpdate();
                            
                    }else if (s_accion.equals("C")) {
                        s_nombre = request.getParameter("f_nombre");
                        s_ht = request.getParameter("f_ht");
                        s_salario = request.getParameter("f_salario");
                        consulta =  "   insert into "
                                    + " sugerencia(descripcion, fecha, idpersona) "
                                    + " values ('"+ s_nombre +"','"+ s_ht +"','"+ s_salario +"')";
                        //out.print(consulta);
                        pst = cn.prepareStatement(consulta);
                        pst.executeUpdate();
                    }else if (s_accion.equals("M2")) {
                        s_nombre = request.getParameter("f_nombre");
                        s_ht = request.getParameter("f_ht");
                        s_salario = request.getParameter("f_salario");
                         consulta = " update  sugerencia  "
                                + "  set  "
                                + "  descripcion = '"+ s_nombre +"',"
                                + "  fecha = '"+ s_ht +"',"
                               + "  idpersona = '"+ s_salario +"' "
                                + "  where "
                                + "  idsugerencia = "+ s_idarea +"; ";
                        //out.print(consulta);
                        pst = cn.prepareStatement(consulta);
                        pst.executeUpdate();
                    }
                }
                consulta= " Select idsugerencia, descripcion, fecha, idpersona "
                        + " from sugerencia ";
                //out.print(consulta);
                pst = cn.prepareStatement(consulta);
                rs = pst.executeQuery();
                int num = 0;
                String ide;
                while (rs.next()) {  
                    ide = rs.getString(1);
                    num++;

                    %>
                    <tr>
                        <td><%out.print(num);%></td>
                        <td><%out.print(rs.getString(2));%></td>
                        <td><%out.print(rs.getString(3));%></td>
                        <td><%out.print(rs.getString(4));%></td>
                        <td><a href="DatosSugerencias.jsp?f_accion=E&f_idarea=<%out.print(ide);%>">Eliminar</a></td>
                        <td><a href="DatosSugerencias.jsp?f_accion=M1&f_idarea=<%out.print(ide);%>">Editar</a></td>

                    </tr>                    
                    <%
                    }
            }catch(Exception e){
                out.print("Error SQL");
            }
        
        %>
        <tbody>
        <tr align="center">
                        <td colspan="6"><a href="Menu.jsp">Volver al Menú</a></td>        
                    </tr>
                </tbody>
       
    </body>
</html>
  