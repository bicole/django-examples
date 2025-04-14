from django.views.generic import TemplateView, ListView
from django.contrib.auth import views as auth_views

from .models import Page

# Create your views here.
class HomeView(ListView):
    template_name = 'website_admin/index.html'
    content_type = 'text/html'
    model = Page
    context_object_name = 'pages'

class PageView(TemplateView):
    template_name = 'website_admin/page.html'
    content_type = 'text/html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)

        try:
            context['page'] = Page.objects.get(pk=self.kwargs['pk'])
        except (ValueError, Page.DoesNotExist):
            context['page'] = None

        return context