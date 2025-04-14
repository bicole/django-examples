from django.urls import reverse
from django.test import TestCase

from .models import Page

def create_page(header=None, body=None, footer=None):
    """
    Create a page with the given header, body, and footer.
    """
    return Page.objects.create(header=header, body=body, footer=footer)

# Create your tests here.
class PageViewTests(TestCase):
    def test_no_pages(self):
        response = self.client.get(reverse("pages:index"))
        self.assertEqual(response.status_code, 200)
        self.assertContains(response, "No pages found.")

    def test_one_page(self):
        create_page(header="Test Header", body="Test Body", footer="Test Footer")
        response = self.client.get(reverse("pages:index"))
        self.assertEqual(response.status_code, 200)
        self.assertContains(response, "Test Header")
        self.assertContains(response, "Test Body")
        self.assertContains(response, "Test Footer")
        self.assertNotContains(response, "No pages found.")

    def test_multiple_pages(self):
        p1 = create_page(header="Test Header 1", body="Test Body 1", footer="Test Footer 1")
        p2 = create_page(header="Test Header 2", body="Test Body 2", footer="Test Footer 2")
        response = self.client.get(reverse("pages:index"))
        self.assertEqual(response.status_code, 200)
        self.assertTrue(all([ page in response.context["pages"] for page in [p1, p2]]))
        self.assertContains(response, "Test Header 1")
        self.assertContains(response, "Test Body 1")
        self.assertContains(response, "Test Footer 1")
        self.assertContains(response, "Test Header 2")
        self.assertContains(response, "Test Body 2")
        self.assertContains(response, "Test Footer 2")

    def test_unknown_page_id(self):
        response = self.client.get(reverse("pages:detail", args=(999,)))
        self.assertEqual(response.status_code, 200)
        self.assertTrue(b"Page '999' not found!" in response.content)

    def test_invalid_page_id(self):
        response = self.client.get(reverse("pages:detail", args=("invalid",)))
        self.assertEqual(response.status_code, 200)
        self.assertTrue(b"Page 'invalid' not found!" in response.content)
