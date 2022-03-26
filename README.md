# Backend Coding Challenge

[![Build Status](https://github.com/Thermondo/backend-code-challenge/actions/workflows/main.yml/badge.svg?event=push)](https://github.com/Thermondo/backend-code-challenge/actions)

We appreciate you taking the time to participate and submit a coding challenge. In the next step we would like you to
create/extend a backend REST API for a simple note-taking app. Below you will find a list of tasks and limitations
required for completing the challenge.

### Application:

* Users can add, delete and modify their notes
* Users can see a list of all their notes
* Users can filter their notes via tags
* Users must be logged in, in order to view/add/delete/etc. their notes

### The notes are plain text and should contain:

* Title
* Body
* Tags

### Optional Features 🚀

* [ ] Search contents of notes with keywords
* [ ] Notes can be either public or private
    * Public notes can be viewed without authentication, however they cannot be modified
* [ ] User management API to create new users

### Limitations:

* use Python / Django
* test accordingly

### What if I don't finish?

Try to produce something that is at least minimally functional. Part of the exercise is to see what you prioritize first when you have a limited amount of time. For any unfinished tasks, please do add `TODO` comments to your code with a short explanation. You will be given an opportunity later to go into more detail and explain how you would go about finishing those tasks.


# This Solution - 

## Features
* JWT Token based authentication
* User Management API to create new users
* A default Admin `{'name': 'admin', 'password': '12345'}` is created automatically during build (only for local testing purposes).
* Authenticated Users can add, delete and modify their notes.
* Supports a list-view for notes:
   * Authorized User can view/modify/delete their private and public notes.
   * Unauthenticated Users can only view public notes.
* Users can also view, delete and modify notes by their 'id':
   * Modify and Delete only works if User is authenticated and the resource/note was created by that User.
   * Only public notes can be viewed by unauthenticated Users. No support for modify and delete in this case.
* Users can filter their notes via tags - This is acheived using query params `tag=<name>`. 
   * For example, `BASE_URL/api/notes/?tag=space` will filter nodes containing the tag 'space'.
* Users can also filter or search for notes based on keyword - This is acheived using query params `keyword=<name>`. 
   * For example, `BASE_URL/api/notes/?keyword=space` will filter nodes containing the keyword 'space' anywhere in the body, title or tag.
* Targets in Makefile to ease local development - more details in the Local Development Setup section.

## Local Development Setup
* Use Make to build, run, test and clean the local development environment (assumes a linux-like environment - Tested on ubuntu).
* build-local - This target will install a virtualenv, install all dependencies in requirements.txt and make the initial migrations to the DB. 
   * `make build-local`
* run-local - Run the server for testing locally.
   * `make run-local`
* test-local - Runs pytests on the test suites for JWT token, User and Notes operations.
   * `make test-local`
* clean - Removes virtualenv
   * `make clean`

## Running Locally

### Endpoints
* /api/token/
   * POST
* /api/register/
   * POST
* /api/notes/?tag=<name>&keyword=<name>
   * GET, POST
* /api/note/{id}
   * GET, PUT, DELETE
   
### Create an Admin
* Ideally, you would want to create a SuperUser/Admin for your application. This is already done in `build-local` step.
   * A default Admin `{'name': 'admin', 'password': '12345'}` with these credentials is created for testing.
   
### Create new users:
* Use API endpoint `BASE_URL/api/register/` to create a new user. Where `BASE_URL` could be for example - `http://127.0.0.1:8000/`
   * Body structure is similar to - `{"name": "user1", "password": "123abc#$%"}`. Remember your password obviously! 

### Get a Web Token
* Use API endpoint `BASE_URL/api/token/` to get 'access' and 'refresh' token. 
   * Body - `{"name": "user1", "password": "123abc#$%"}`.

### Create a new note
*  Use API endpoint `BASE_URL/api/notes/` to create a new note. You will need 'access' token from the previous step.
   * Body -  Example `{
    "title": "Test Note",
    "body": "Hello this is my First Note",
    "tags": [{"title": "blog"}, {"title":"thoughts"}]
} `
   * Headers - Authorization: Bearer <ACCESS_TOKEN>

### Get Notes list
* Use API endpoint `BASE_URL/api/notes/` to fetch a list of notes. Optionally pass query params tag, keyword.
* User Authorization header if you want to fetch your private notes.

### Get, Update and Delete a Note
* Use API endpoint `BASE_URL/api/note/{id}`. You will need 'access' token from the previous step.
* Body and Header if required is same as described earlier.


ToDos:
* [ ] Use OpenAPI for documenting the API instead of writing it here in README.
* [ ] A Simple UI to visualise Notes operation.
* [ ] Add Custom error handling page for example, handler404 & handler500.
* [ ] Use a better Database.
