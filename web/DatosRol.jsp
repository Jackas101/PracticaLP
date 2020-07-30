<%@page import="java.sql.*" %>
<%@page import="bd.*" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Datos Rol</title>
        <link href="style.css" rel="stylesheet" type="text/css"/>
        <link href="css/estilo.css" rel="stylesheet" type="text/css"/>
        <%!
            String consulta;
            Connection cn;
            PreparedStatement pst;
            ResultSet rs;
            String s_accion;
            String s_idrol;
            String s_nombre;
            String s_idarea;
            String s_estado;
          
            
        %>
    </head>
    <body>
        <%
            try{
                ConectaBd bd = new ConectaBd();
                cn = bd.getConnection();
                
                s_accion = request.getParameter("f_accion");
                s_idrol = request.getParameter("f_idrol");
                
                if(s_accion!=null && s_accion.equals("M1")){
                    consulta = "    select nombre, idarea, estado "
                                + " from rol "
                                + " where"
                                + " idrol = " + s_idrol + "; ";
                    //out.print(consulta);
                    pst = cn.prepareStatement(consulta);
                    rs = pst.executeQuery();
                    if (rs.next()) {
        %>
        
        <form name="EditarRolForm" action="DatosRol.jsp" method="GET">
            <table border="0" align="center" >
                <thead>
                    <tr>
                        <th colspan="2">Editar Rol</th>
                        
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Nombre: </td>
                        <td><input type="text" name="f_nombre" value="<% out.print(rs.getString(1)); %>" maxlength="30" size="20" /></td>
                    </tr>
                    <tr>
                        <td>Área: </td>
                        <td><input type="text" name="f_idarea" value="<% out.print(rs.getString(2)); %>" maxlength="10" size="20" /></td>
                    </tr>
                    <tr>
                        <td>Estado: </td>
                        <td><input type="text" name="f_estado" value="<% out.print(rs.getString(3)); %>" maxlength="10" size="4"/></td> 
                    </tr>
                    <tr align="center">
                        <td colspan="2">
                            <input type="submit" value="Editar" name="f_editar" />
                            <input type="hidden" name="f_accion" value="M2" />
                            <input type="hidden" name="f_idrol" value="<% out.print(s_idarea); %>" />
                        </td>
                    </tr>
                </tbody>
            </table>

        </form>
        <%
                }
            }else{
        %>
        <form name="AgregarRolForm" action="DatosRol.jsp" method="GET">
            <table border="0" align="center" class="general">
                <thead>
                    <tr>
                        <th colspan="2" >Agregar Rol</th>
                        
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Nombre: </td>
                        <td><input type="text" name="f_nombre" value="" maxlength="30" size="20" /></td>
                    </tr>
                    <tr>
                        <td>Área: </td>
                        <td><input type="text" name="f_idarea" value="" maxlength="40" size="20" /></td>
                    </tr>
                    <tr>
                        <td>Estado: </td>
                        <td><input type="text" name="f_estado" value="" maxlength="5" size="2"/></td>
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
                    <th colspan="8">Datos Rol</th>
                </tr>
                <tr>
                    <th>N°</th>
                    <th>Nombre</th>
                    <th>Área</th>
                    <th>Estado</th>
                    <th colspan="2">Acciones</th>
                </tr>
            </thead>

        <%
            
                
                if (s_accion!=null) {
                    if (s_accion.equals("E")) {
                        consulta =  "   delete from Rol "
                                    + " where "
                                    + " idrol = " + s_idrol + "; ";
                        //out.print(consulta);
                        pst = cn.prepareStatement(consulta);
                        pst.executeUpdate();
                            
                    }else if (s_accion.equals("C")) {
                        s_nombre = request.getParameter("f_nombre");
                        s_idarea = request.getParameter("f_idarea");
                        s_estado = request.getParameter("f_estado");
                        consulta =  "   insert into "
                                    + " area(nombre, idarea, estado) "
                                    + " values ('"+ s_nombre +"','"+ s_idarea +"','"+ s_estado +"')";
                        //out.print(consulta);
                        pst = cn.prepareStatement(consulta);
                        pst.executeUpdate();
                    }else if (s_accion.equals("M2")) {
                        s_nombre = request.getParameter("f_nombre");
                        s_idarea = request.getParameter("f_idarea");
                        s_estado = request.getParameter("f_estado");
                         consulta = " update  rol  "
                                + "  set  "
                                + "  nombre = '"+ s_nombre +"',"
                                + "  idarea = '"+ s_idarea +"',"
                               + "  estado = '"+ s_estado +"' "
                                + "  where "
                                + "  idrol = "+ s_idrol +"; ";
                        //out.print(consulta);
                        pst = cn.prepareStatement(consulta);
                        pst.executeUpdate();
                    }
                }
                consulta= " Select idrol, nombre, idarea, estado "
                        + " from rol ";
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
                       <td><a href="DatosRol.jsp?f_accion=E&f_idrol=<%out.print(ide);%>"><span class="icon-bin"></span></a></td>
                        <td><a href="DatosRol.jsp?f_accion=M1&f_idrol=<%out.print(ide);%>"><span class="icon-loop"></span></a></td>

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
