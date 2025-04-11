# Ruby Appointment

A web application built with Ruby on Rails for managing appointments. It allows administrators to view, approve, reject, and reschedule appointments, with features planned for multi-company support and public booking.

## Features

### Current Features

*   **Admin Dashboard:** Central hub for managing appointments.
*   **Appointment Management:**
    *   View all appointments.
    *   Approve/Reject appointments via a modal interface.
    *   Reschedule appointments using a datetime picker.
*   **User Authentication:** Built using the Devise gem.
    *   User Sign Up
    *   User Sign In / Sign Out
    *   Password Recovery
*   **Styling:** Uses Tailwind CSS for a modern UI.
*   **Email Notifications:** Automatic confirmations (details TBC).

### Planned Features

*   **Multi-Tenancy:** Isolate data between different companies using the system.
*   **Role-Based Access Control:** Differentiate between Admin and Staff roles within a company.
*   **Public Booking Calendar:** Allow end-users/customers to see availability and book appointments.
*   **Dashboard Analytics:** Visual statistics on appointment activity.
*   **Company Branding:** Allow companies to customize logo and colors.
*   **Calendar Integration:** Export appointments to ICS format for Google/Outlook.
*   **Mobile Optimization:** Ensure a responsive and touch-friendly experience.

## Technology Stack

*   **Backend:** Ruby on Rails (v8.x)
*   **Frontend:**
    *   Tailwind CSS (v3.x)
    *   Importmaps (for JavaScript management)
    *   Stimulus (Optional, standard with Rails 7+)
    *   Turbo (standard with Rails 7+)
*   **Authentication:** Devise
*   **Database:** SQLite (Development), PostgreSQL (Recommended for Production)
*   **Ruby Version:** 3.4.2 (or as specified in `.ruby-version`)

## Prerequisites

*   Ruby (see `.ruby-version` file)
*   Bundler (`gem install bundler`)
*   Node.js and Yarn (for Tailwind CSS compilation)
*   A compatible database (SQLite3 for development, PostgreSQL recommended for production)

## Setup Instructions

1.  **Clone the repository:**
    ```bash
    git clone <your-repository-url>
    cd ruby-appointment
    ```

2.  **Install Ruby dependencies:**
    ```bash
    bundle install
    ```

3.  **Install JavaScript dependencies:**
    ```bash
    yarn install
    ```

4.  **Set up the database:**
    ```bash
    # Creates the database, loads the schema, and seeds (if seeds.rb is populated)
    rails db:setup
    ```
    *Alternatively, run migrations individually:*
    ```bash
    rails db:create
    rails db:migrate
    # rails db:seed # If you have seed data
    ```

5.  **(Optional) Environment Variables:** If the application requires environment variables (e.g., for email sending, API keys), create a `.env` file and populate it based on `.env.example` (if one exists).

## Running the Application

Start the development server using the Procfile (which typically runs Rails and the Tailwind CSS watcher):

```bash
bin/dev
```

Then, open your web browser and navigate to `http://localhost:3000` (or the port specified by Puma).

## Running Tests

*To be added* (Specify how to run your test suite, e.g., `rails test`).

## Contributing

*To be added* (Outline guidelines for contributing if applicable).

## License

*To be added* (Specify the project's license, e.g., MIT).
