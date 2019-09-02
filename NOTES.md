# Additional notes

- No dependencies or extra libraries where added. Only the view and controller for pokemon where changed and an extra configuration was added.

- The parameters from the pokemon request passed from controller to view in local variables `@name`, `@weight`, `@height`, `@moves` and `@abilities`. Likewise, the computed url's to fetch the pokemon images are stored in `@front_url` and `@back_url`.

- An extra url was added to the application configuration in order to have a default image when a there is a problem accessing the pokemon api.

- The list attributes of the pokemon, _moves_ and _abilities_ are sorted and then formatted into a comma-separated list.
