# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app
- [x] Use ActiveRecord for storing information in a database
- [x] Include more than one model class (list of model class names e.g. User, Post, Category) - Has Item, User, and Whiskey classes
- [x] Include at least one has_many relationship on your User model (x has_many y, e.g. User has_many Posts) - User has_many Items and has_many Whiskeys through Items
- [x] Include at least one belongs_to relationship on another model (x belongs_to y, e.g. Post belongs_to User) - Item belongs_to User and belongs_to Whiskey
- [x] Include user accounts - uses session hash
- [x] Ensure that users can't modify content created by other users - get '/items/:id/edit' and post '/items/:id' routes validate that Item wishing to edit/deleted belongs to current_user. show.erb file does not allow "edit" link to be displayed if an item does not belong to current_user.
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying - ItemController allows Items to be created, read, updated, destroyed
- [x] Include user input validations - includes #valid_date? helper method and html form requires input in order to submit
- [x] Display validation failures to user with error message (example form URL e.g. /posts/new) - uses rack-flash3 to display validation failures and guide user when creating/updating Item or when logging in/signing up
- [ ] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code

Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message