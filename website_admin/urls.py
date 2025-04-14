from django.urls import path

from . import views

app_name = "pages"
urlpatterns = [
    # ex: /
    path("", views.HomeView.as_view(), name="index"),
    # ex: page/1/
    path("page/<pk>/", views.PageView.as_view(), name="detail"),
]