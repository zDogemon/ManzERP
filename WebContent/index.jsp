<%@page import="org.hibernate.Query"%>
<%@page import="model.SingletonCurrentUser"%>
<%@page import="java.util.List"%>
<%@page import="model.ConnectionDB"%>
<%@page import="org.hibernate.Session"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@page import="model.Usuario"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<html>
<head>
<title>In�cio - ManzERP</title>
<link rel="stylesheet" type="text/css" href="css/bulma.min.css">
</head>
<body>
	<%
		SessionFactory factory = null;
		Session sess = null;
		List results = null;

		factory = ConnectionDB.getSessionFactory();

		Usuario user = null;
		if (request.getParameter("login") != null && request.getParameter("senha") != null) {
			sess = factory.openSession();
			Query query = sess.createQuery("from Usuario where login = :login and senha = :senha");

			query.setParameter("login", request.getParameter("login"));
			query.setParameter("senha", request.getParameter("senha"));
			results = query.list();
			if (results.isEmpty()) {
				response.sendRedirect("login.jsp");
			}
			user = (Usuario) results.get(0);
			System.out.print(user.getNome());
			SingletonCurrentUser.setCurrentUser(user);
			sess.clear();
		} else if (SingletonCurrentUser.getCurrentUser() != null) {
			user = SingletonCurrentUser.getCurrentUser();
		} else {
			response.sendRedirect("login.jsp");
		}
	%>
	<nav class="navbar is-link" role="navigation"
		aria-label="dropdown navigation">
		<div class="navbar-start">
			<a href="index.jsp" class="navbar-item"> <img src="img/logo.png"
				width="50">
			</a>
			<%
				if (user.getTipo() == 3) {
			%><a class="navbar-item" href="create-user.jsp"> Criar usu�rio </a>
			<%
				}
			%>
			<%
				if (user.getTipo() == 1 || user.getTipo() == 3) {
			%>
			<a class="navbar-item" href="create-call.jsp"> Criar chamado </a>
			<%
				}
			%>
			<%
				if (user.getTipo() == 2 || user.getTipo() == 3) {
			%><a class="navbar-item" href="list-call.jsp"> Chamados </a> <a
				class="navbar-item" href="user-list.jsp"> Usu�rios </a>
			<%
				}
			%>
		</div>
		<div class="navbar-end">
			<div class="navbar-item has-dropdown is-hoverable">
				<a class="navbar-link"> <img src="img/user.png">
				</a>
				<div class="navbar-dropdown">
					<a class="navbar-link is-primary"> <%=user.getNome()%>
					</a> <a href="logoff.jsp" class="navbar-item"> Logoff </a>
				</div>
			</div>
		</div>
	</nav>
	<div class="container" style="margin-top: 80px">
		<div class="columns is-mobile is-centered">
			<div class="column is-half">
				<p style="text-align: center">
					<img src="img/weg-logo.jpg" alt="Logo da WEG" style="width: 50%">
				</p>
				<h1 class="title is-1" style="text-align: center; margin-top: 25px">ManzERP</h1>
				<p style="text-align: center; font-size: 18px">Bem-vindo ao
					ManzERP, o ERP de chamados desenvolvido para facilitar o
					gerenciamento de chamados entre os colaboradores da WEG.</p>
				<p style="margin-top: 50px; text-align: center; font-size: 18px">Escolha
					uma das op��es na barra de navega��o para usar o sistema.</p>
			</div>
		</div>
	</div>
</body>
</html>