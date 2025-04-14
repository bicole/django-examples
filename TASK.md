# Django Code Sample Project

## Basic requirements:
1. Create a Django project with a single admin account, utilizing a SQLite database (you don’t have to use sqlite, but for portability of this test it is the simplest).
2. Create a Django model called ‘Page’ containing  header, body, and footer fields.
3. Create a model admin class that allows page objects to be created/edited/deleted through the Django Admin.
4. Create a public page utilizing Django’s url config, class-based views, and templates to render the page model to the url based on the model id provided in the url.
5. Detect whether the user is logged in or not and render that information to the page along with the users IP address.
6. Make sure the view correctly accounts for missing or otherwise invalid model ids provided by the url.
7. Create a unit test that ensures the view can fail gracefully for urls where the model id is missing or otherwise invalid.

---

## Bonus points, but not required:
1. Create a custom login page utilizing Javascript to force the user to prove they are not a bot
2. Person arrives on the page, display a prompt: “Are you Human?” with Yes/No buttons.
3. If yes is clicked, animate the username/password fields onto the page to replace the Human prompt.
4. Below user/password fields display “What is your favorite number?” with a range slider.
5. Force the user to scroll to a number other than the default before making the Login button enabled.
6. If the user passes those tests and the login button is clicked, if authentication succeeds, redirect the user to the Django admin.