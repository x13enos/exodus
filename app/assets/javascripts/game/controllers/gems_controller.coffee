myapp.controllers.Gems = Marionette.Object.extend

  select: (gem) ->
    if env == 'development'
      console.log 'gem_select'
    myapp.application.Gems_Select_Module.perform(gem)

