<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        
        <link href="css/estilo.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <form name="f_datos" action="Valida.jsp" method="POST">
            <table align="center"border="1" cellspacing="0" celpagging="0" class="general" >
                <thead>
                    <tr>
                        <th colspan="2">INGRESE USUARIO Y CLAVE</th>
                        
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Usuario:</td>
                        <td><input type="text" name="f_usuario" value="" /></td>
                    </tr>
                    <tr>
                        <td>Contraseña: </td>
                        <td><input type="password" name="f_clave" value="" /></td>
                    </tr>
                    <tr align="center">
                        <td colspan="2"><input type="submit" value="Ingresar" name="f_ingresar" /></td>
                        
                    </tr>
                </tbody>
            </table>

        </form>
    </body>
</html>
