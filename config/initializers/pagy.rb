# frozen_string_literal: true

# Pagy Variables
# See https://ddnexus.github.io/pagy/docs/api/pagy#variables
Pagy::DEFAULT[:items] = 20 # default

# Array extra: Paginate arrays efficiently, avoiding expensive array-wrapping and without overriding
# See https://ddnexus.github.io/pagy/docs/extras/array
require 'pagy/extras/array'

# Calendar extra: Add pagination filtering by calendar time unit (year, quarter, month, week, day)
# See https://ddnexus.github.io/pagy/docs/extras/calendar
require 'pagy/extras/calendar'

# When you are done setting your own default freeze it, so it will not get changed accidentally
Pagy::DEFAULT.freeze
