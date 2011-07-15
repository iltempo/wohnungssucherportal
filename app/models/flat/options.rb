module Flat::Options
  STATES = %w(
    new
    contacted
    schedule_visit
    visit_scheduled
    i_rejected
    not_available
  )
  
  # should this be in the model?
  SORT_OPTIONS = [
    ['added on', 'created_at DESC'],
    ['available on', 'available_on ASC'],
    ['cost', 'price/square_meters DESC'],
    ['m²', 'square_meters DESC'],
    ['price', 'price DESC'],
    ['priority', 'priority ASC'],
    ['street', 'street ASC'],
  ]
  
  DEFAULT_PRIORITY = 2
end