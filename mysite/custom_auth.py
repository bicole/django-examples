from django.contrib.auth import views as auth_views

auth_views.LoginView.template_name = "account/login.html"
auth_views.LogoutView.template_name = "account/logout.html"