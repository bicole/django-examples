from django.db import models

# Create your models here.
class Page(models.Model):
    header = models.TextField(blank=True, null=True)
    body = models.TextField(blank=True, null=True)
    footer = models.TextField(blank=True, null=True)
    supports_html = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)