_.extend Marionette.Renderer,
  render: (template, data) ->
    return if template is false
    unless template
      error = new Error("Cannot render the template since it's false, null or undefined.")
      error.name = "TemplateNotFoundError" 
      throw error
    templateFunc = undefined
    if typeof template is "function"
      templateFunc = template
    else
      templateFunc = Marionette.TemplateCache.get(template)
    templateFunc data
