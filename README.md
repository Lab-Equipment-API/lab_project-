#Lab-equipment
1. Descripton 

Lab Equipment API provides a complete backend system for tracking laboratory equipment. It supports categorization of equipment, status tracking (available, in_use, maintenance), and maintenance record keeping. The API returns JSON responses and handles edge cases with appropriate HTTP status codes.

# 2. Setup instructions

Follow these steps to run the project from scratch.

1. Clone the Repository
   `git clone "[<repo-url>](https://github.com/Lab-Equipment-API/lab_project-.git)"`

2. Navigate to the Project Directory
  `cd <project-directory>`
3. Install Dependencies
  `bundle install`
4. Create, Migrate, and Seed the Database
  `bin/rails db:create db:migrate db:seed`
5. Start the Rails Server
  `bin/rails server`
6. Access the Application
Once the server is running, the API will be available at: `http://localhost:3000`

| Task | Owner | Branch | Status |
|------|-------|--------|--------|
| 1 - Data model | fyori| task-1-model | Done |
| 2 - Seeds | martha  | task-2-seeds | Done |
| 3 - Category CRUD | yeabsira| task-3-categories | Done |
| 4 - Equipment CRUD | hikmet | task-4-equipment | Done |
| 5 - MaintenanceRecord CRUD | hanania| task-5-maintenance |Done |
| 6 - Business rules |martha| task-6-rules | Done |
| 7 - Edge cases | hanania | task-7-edge-cases | Done |

