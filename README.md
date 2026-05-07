# The Ocean Katz

Landing page for Clara Katz, freediving & yoga coach in the Sinai (Red Sea).
Built with Ruby on Rails. Includes a contact form that emails the coach directly via Gmail SMTP.

## Tech stack

- Ruby 3.4.7
- Rails 8.1
- Propshaft (asset pipeline)
- Puma (web server)
- Action Mailer + Gmail SMTP
- Plain HTML/CSS/JS on the front (no framework)

## Requirements

- Ruby 3.4.7 (use `rbenv`, `asdf`, or your manager of choice)
- Bundler
- A Gmail account with 2-Step Verification enabled and an App Password

## Getting started

### 1. Clone & install dependencies

```bash
git clone git@github.com:<your-user>/TheOceanKatz.git
cd TheOceanKatz
bundle install
```

### 2. Configure environment variables

Create a `.env` file at the project root (it is gitignored):

```env
GMAIL_USER=youraddress@gmail.com
GMAIL_APP_PASSWORD=xxxxxxxxxxxxxxxx
CONTACT_TO=destination@gmail.com
```

- `GMAIL_USER` — the Gmail account used to send messages (the "From" address).
- `GMAIL_APP_PASSWORD` — a 16-character App Password generated at <https://myaccount.google.com/apppasswords>. The regular Gmail password will not work; 2FA must be enabled first.
- `CONTACT_TO` — the address that receives form submissions.

### 3. Run the server

```bash
bin/rails server
```

The site is then available at <http://localhost:3000>.

## Contact form

The contact form (`/#contact`) sends a POST request to `/contact`, handled by `ContactController#create`. The controller validates the inputs, then calls `ContactMailer.contact_email(...)` to deliver the message via SMTP.

Frontend behavior:
- Submission is intercepted in JavaScript and sent as JSON via `fetch`, so the page does not reload.
- A success or error message is displayed directly under the Send button.
- The CSRF token from `<%= csrf_meta_tags %>` is included in the request.

## Project structure

```
app/
  controllers/
    contact_controller.rb     # Handles form submission
    home_controller.rb        # Renders the landing page
  mailers/
    application_mailer.rb     # Default From address
    contact_mailer.rb         # Builds the contact email
  views/
    home/index.html.erb       # The full landing page (single template)
    contact_mailer/           # Mailer templates
config/
  environments/
    development.rb            # SMTP config for development
    production.rb             # SMTP config for production
  routes.rb                   # POST /contact and root route
```

## Tests

```bash
bin/rails test
```

## Code style

The project uses `rubocop-rails-omakase`:

```bash
bin/rubocop          # check
bin/rubocop -a       # auto-fix what can be fixed
```

## Deployment

The project is configured for Kamal deployment (see `config/deploy.yml` if applicable). Production environment variables (`GMAIL_USER`, `GMAIL_APP_PASSWORD`, `CONTACT_TO`) must be set in the deployment platform's settings.

For Railway, Heroku, Render, or similar platforms: add the same three variables in the project's environment settings, and uncomment the SMTP block in `config/environments/production.rb` (or copy the development SMTP config).

## Security notes

- Never commit `.env` — it is already in `.gitignore`.
- The Gmail App Password is sensitive: rotate it if it ever leaks (delete it in the Google Account settings and generate a new one).
- The contact form has no anti-spam protection yet. Consider adding a honeypot field or reCAPTCHA before going live.

## License

Private project. All rights reserved.
