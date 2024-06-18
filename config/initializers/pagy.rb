# frozen_string_literal: true

# Pagy Variables
# See https://ddnexus.github.io/pagy/docs/api/pagy#variables
Pagy::DEFAULT[:items] = 25

# Array extra: Paginate arrays efficiently, avoiding expensive array-wrapping and without overriding
# See https://ddnexus.github.io/pagy/docs/extras/array
require 'pagy/extras/array'

# Calendar extra: Add pagination filtering by calendar time unit (year, quarter, month, week, day)
# See https://ddnexus.github.io/pagy/docs/extras/calendar
require 'pagy/extras/calendar'

# Javascript Optimizations
# See https://ddnexus.github.io/pagy/docs/api/javascript/setup/
Rails.application.config.assets.paths << Pagy.root.join('javascripts')
require 'pagy/extras/pagy'

# When you are done setting your own default freeze it, so it will not get changed accidentally
Pagy::DEFAULT.freeze
