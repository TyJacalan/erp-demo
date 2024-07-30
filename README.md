# SMARTER GOOD ERP

A MVP for a ERP system that includes user, client, and task management, as well as an admin dashboard.

## Main dependencies:

* Devise
* Tailwind CSS
* Shadcn UI
* Rspec
* Pundit
* Ransack
* Pagy
* Noticed
* Oj
* Avo
* Geocoder

## Features

- Task Management System
- Notification System
- Nested forms

## Usage/Examples
1. Install dependencies
```
bundle install && yarn install
```

3. Delete the `config/credentials.yml` and regenerate the credentials
```
EDITOR=nvim rails credentials:edit           #neovim
EDITOR="code --wait" rails crendentials:edit #vscode
```

3. Initialize the database
```
bin/rails db:create && 
bin/rails db:migrate &&
bin/rails db:migrate RAILS_ENV=test
```

4. Seed the database
```
bin/rails db:seed
```
5. Run the application
`bin/rails s`

- Note that there is no user registration by design, you may login using the following credentials (assume you've seeded the database)
```
username: example@example.com
password: password123!
```

