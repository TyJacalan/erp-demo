# frozen_string_literal: true

# For more information regarding these settings check out our docs https://docs.avohq.io
# The values disaplayed here are the default ones. Uncomment and change them to fit your needs.
Avo.configure do |config|
  ## == Routing ==
  config.root_path = '/admin'

  ## == Set the context ==
  config.set_context do
    # Return a context object that gets evaluated in Avo::ApplicationController
  end

  ## == Authentication ==
  config.current_user_method = :current_admin

  ## == Authorization ==
  config.authorization_methods = {
    index: 'index?',
    show: 'show?',
    edit: 'edit?',
    new: 'new?',
    update: 'update?',
    create: 'create?',
    destroy: 'destroy?',
    search: 'search?'
  }
  # config.raise_error_on_missing_policy = false
  config.authorization_client = :pundit

  ## == Localization ==
  # config.locale = 'en-US'

  ## == Resource options ==
  # config.resource_controls_placement = :right
  # config.model_resource_mapping = {}
  # config.default_view_type = :table
  # config.per_page = 24
  # config.per_page_steps = [12, 24, 48, 72]
  # config.via_per_page = 8
  # config.id_links_to_resource = false

  ## == Customization ==
  config.app_name = 'SmarterGood, Inc.'
  config.timezone = 'UTC + 8:00'
  config.currency = 'PHP'
  # config.hide_layout_when_printing = false
  # config.full_width_container = false
  # config.full_width_index_view = false
  # config.search_debounce = 300
  # config.view_component_path = "app/components"
  # config.display_license_request_timeout_error = true
  # config.disabled_features = []
  # config.buttons_on_form_footers = true
  # config.field_wrapper_layout = true
  # config.resource_parent_controller = "Avo::ResourcesController"

  ## == Branding ==
  # config.branding = {
  #   colors: {
  #     background: "248 246 242",
  #     100 => "#CEE7F8",
  #     400 => "#399EE5",
  #     500 => "#0886DE",
  #     600 => "#066BB2",
  #   },
  #   chart_colors: ["#0B8AE2", "#34C683", "#2AB1EE", "#34C6A8"],
  #   logo: "/avo-assets/logo.png",
  #   logomark: "/avo-assets/logomark.png",
  #   placeholder: "/avo-assets/placeholder.svg",
  #   favicon: "/avo-assets/favicon.ico"
  # }

  ## == Breadcrumbs ==
  # config.display_breadcrumbs = true
  # config.set_initial_breadcrumbs do
  #   add_breadcrumb "Home", '/avo'
  # end

  ## == Menus ==
  config.main_menu = lambda {
  }
end
