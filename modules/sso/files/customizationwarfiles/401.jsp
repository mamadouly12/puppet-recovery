<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="javax.servlet.*"%>
<%@ page import="javax.servlet.http.*"%>
<%@ page import="javax.servlet.ServletContext"%>
 
<%@taglib uri="/WEB-INF/jato.tld" prefix="jato"%>
<%@taglib uri="/WEB-INF/auth.tld" prefix="auth"%>
 
<%
 
    /*
     *(C) 2010 Jim Klimov, JSC COS&HT
     *param processing (C) http://www.apl.jhu.edu/~hall/java/Servlet-Tutorial/Servlet-Tutorial-Form-Data.html
     */
 
    response.setStatus (response.SC_UNAUTHORIZED);
    response.setHeader ("WWW-Authenticate", "Negotiate");
 
    /*
     * Default ORG and MODULE/SERVICE values, should override whatever
     * was passed to the Login page, if fallback redirect is required
     * TODO: Parametrize via serice/property configs
     */
    String FallbackServiceURI = "/opensso/UI/Login?service=ldapService";
%>
 
<HTML><HEAD><TITLE>HTTP-401: Unauthorized</TITLE>
 
<%
    Enumeration paramNames = request.getParameterNames();

    while(paramNames.hasMoreElements()) {
        String paramName = (String)paramNames.nextElement();
        if (
            paramName.equals("service") ||
            paramName.equals("module") ||
            paramName.equals("org") ||
            paramName.equals("goto")

        ) { ; } else if (paramName.equals("spEntityID")) {
                FallbackServiceURI += "&goto="+request.getParameterValues(paramName)[0];
        }
        else {

            String[] paramValues = request.getParameterValues(paramName);

            for(int i=0; i<paramValues.length; i++) {
                String paramValue = paramValues[i];
                FallbackServiceURI += "&"+paramName;
                if (paramValue.length() != 0) {
                    FallbackServiceURI += "="+paramValue;
                }
            }
        }
    }
%>
 
<meta HTTP-EQUIV="refresh" content="0;url=<%= FallbackServiceURI %>">
 
</HEAD>
<BODY><H1>HTTP-401: Unauthorized</H1>
Proper authorization is required for this area. 
Either your browser does not perform authorization, 
or your authorization has failed.<br>
Your browser will be redirected to 
<a href="<%= FallbackServiceURI %>">default
authorization method</a>.
</BODY></HTML>
