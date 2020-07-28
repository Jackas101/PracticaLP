<%@page import="java.sql.*" %>
<%@page import="bd.*" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Datos Persona</title>
        <%!
            String consulta;
            Connection cn;
            PreparedStatement pst;
            ResultSet rs;
            String s_accion;
            String s_idpersona;
            String s_nombre;
            String s_apellido;
            String s_dni;
            String s_estado;
            
        %>
    </head>
    <body>
        <%
            try{
                ConectaBd bd = new ConectaBd();
                cn = bd.getConnection();
                
                s_accion = request.getParameter("f_accion");
                s_idpersona = request.getParameter("f_idpersona");
                
                if(s_accion!=null && s_accion.equals("M1")){
                    consulta = "    select nombre, apellido, dni, estado  "
                                + " from persona "
                                + " where"
                                + " idpersona = " + s_idpersona + "; ";
                    //out.print(consulta);
                    pst = cn.prepareStatement(consulta);
                    rs = pst.executeQuery();
                    if (rs.next()) {
        %>
        
        <form name="EditarPersonaForm" action="DatosPersona.jsp" method="GET">
            <table border="0" align="center">
                <thead>
                    <tr>
                        <th colspan="2">Editar Persona</th>
                        
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Nombre: </td>
                        <td><input type="text" name="f_nombre" value="<% out.print(rs.getString(1)); %>" maxlength="30" size="20" /></td>
                    </tr>
                    <tr>
                        <td>Apellido: </td>
                        <td><input type="text" name="f_apellido" value="<% out.print(rs.getString(2)); %>" maxlength="40" size="20" /></td>
                    </tr>
                    <tr>
                        <td>DNI: </td>
                        <td><input type="text" name="f_dni" value="<% out.print(rs.getString(3)); %>" maxlength="8" size="8"/></td>
                    </tr>
                    <tr>
                        <td>Estado: </td>
                        <td><input type="text" name="f_estado" value="<% out.print(rs.getString(4)); %>" maxlength="1" size="2"/></td>
                    </tr>
                    <tr align="center">
                        <td colspan="2">
                            <input type="submit" value="Editar" name="f_editar" />
                            <input type="hidden" name="f_accion" value="M2" />
                            <input type="hidden" name="f_idpersona" value="<% out.print(s_idpersona); %>" />
                        </td>
                    </tr>
                </tbody>
            </table>

        </form>
        <%
                }
            }else{
        %>
        <form name="AgregarPersonaForm" action="DatosPersona.jsp" method="GET">
            <table border="0" align="center">
                <thead>
                    <tr>
                        <th colspan="2">Agregar Persona</th>
                        
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Nombre: </td>
                        <td><input type="text" name="f_nombre" value="" maxlength="30" size="20" /></td>
                    </tr>
                    <tr>
                        <td>Apellido: </td>
                        <td><input type="text" name="f_apellido" value="" maxlength="40" size="20" /></td>
                    </tr>
                    <tr>
                        <td>DNI: </td>
                        <td><input type="text" name="f_dni" value="" maxlength="8" size="8"/></td>
                    </tr>
                    <tr>
                        <td>Estado: </td>
                        <td><input type="text" name="f_estado" value="" maxlength="1" size="2"/></td>
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
                    <th colspan="8">Datos Persona</th>
                </tr>
                <tr>
                    <th>N°</th>
                    <th>Nombre</th>
                    <th>Apellido</th>
                    <th>DNI</th>
                    <th>Estado</th>
                    <th colspan="2">Acciones</th>
                </tr>
            </thead>

        <%
            
                
                if (s_accion!=null) {
                    if (s_accion.equals("E")) {
                        consulta =  "   delete from Persona "
                                    + " where "
                                    + " idpersona = " + s_idpersona + "; ";
                        //out.print(consulta);
                        pst = cn.prepareStatement(consulta);
                        pst.executeUpdate();
                            
                    }else if (s_accion.equals("C")) {
                        s_nombre = request.getParameter("f_nombre");
                        s_apellido = request.getParameter("f_apellido");
                        s_dni = request.getParameter("f_dni");
                        s_estado = request.getParameter("f_estado");
                        consulta =  "   insert into "
                                    + " persona(nombre, apellido, dni, estado) "
                                    + " values ('"+ s_nombre +"','"+ s_apellido +"','"+ s_dni +"','"+ s_estado +"')";
                        //out.print(consulta);
                        pst = cn.prepareStatement(consulta);
                        pst.executeUpdate();
                    }else if (s_accion.equals("M2")) {
                        s_nombre = request.getParameter("f_nombre");
                        s_apellido = request.getParameter("f_apellido");
                        s_dni = request.getParameter("f_dni");
                        s_estado = request.getParameter("f_estado");
                        consulta = " update  persona  "
                                + "  set  "
                                + "  nombre = '"+ s_nombre +"',"
                                + "  apellido = '"+ s_apellido +"',"
                                + "  dni = '"+ s_dni +"', "
                                + "  estado = '"+ s_estado +"' "
                                + "  where "
                                + "  idpersona = "+ s_idpersona +"; ";
                        //out.print(consulta);
                        pst = cn.prepareStatement(consulta);
                        pst.executeUpdate();
                    }
                }
                consulta= " Select idpersona, nombre, apellido, dni, estado "
                        + " from persona ";
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
                        <td><%out.print(rs.getString(5));%></td>
                        <td><a href="DatosPersona.jsp?f_accion=E&f_idpersona=<%out.print(ide);%>">Eliminar</a></td>
                        <td><a href="DatosPersona.jsp?f_accion=M1&f_idpersona=<%out.print(ide);%>">Editar</a></td>

                    </tr>                    
                    <%
                    }
            }catch(Exception e){
                out.print("Error SQL");
            }
        
        %>
        </table>
    </body>
</html>
