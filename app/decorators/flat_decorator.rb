# a view-model to encapsulate view-related logic. 
# replaces most helpers in an OO way.
#
# Accessing Helpers
#   You can access any helper via a proxy
#
#   Normal Usage: helpers.number_to_currency(2)
#   Abbreviated : h.number_to_currency(2)
#   
#   Or, optionally enable "lazy helpers" by calling this method:
#     lazy_helpers
#   Then use the helpers with no proxy:
#     number_to_currency(2)

# Defining an Interface
#   Control access to the wrapped subject's methods using one of the following:
#
#   To allow only the listed methods (whitelist):
#     allows :method1, :method2
#
#   To allow everything except the listed methods (blacklist):
#     denies :method1, :method2

# Presentation Methods
#   Define your own instance methods, even overriding accessors
#   generated by ActiveRecord:
#   
#   def created_at
#     h.content_tag :span, time.strftime("%a %m/%d/%y"), 
#                   :class => 'timestamp'
#
#
class FlatDecorator < ApplicationDecorator

  decorates :flat

  def availability
    s = "from #{I18n.l(model.available_on, :format => :german)}" 
    if (model.available_until)
      _until  = I18n.l(model.available_until, :format => :german)
      _months = available_months
      s << " to %s (%s)" % [_until, _months]
    end
    s
  end
  
  # overwrites the attribute
  def visit_at
    return unless model.visit_at
    s = I18n.l(model.visit_at, :format => :german)
    s << " (%s)" % h.content_tag('i', h.distance_of_time_in_words_to_now(model.visit_at))
  end

  # overwrites the attribute
  def comment
    h.simple_format(h.auto_link(model.comment)) 
  end
  
  def contact
    h.auto_link("#{model.contact_person} #{model.phone}")
  end
  
  def subtitle_with_contact
    if model.subtitle.present? 
      s = model.subtitle
      s << ", Kontakt: #{model.contact_person}" if model.contact_person.present?
    else
      s = model.contact_person
    end
    s 
  end
  
  def to_json
    model.to_json(
      :only => [:id, :latitude, :longitude], 
      :methods => :full_address
    )
  end
  
  def street_with_neighbourhood
    s = model.street.present? ? model.street : "?"
    if model.neighbourhood.present? 
      s << ", #{model.neighbourhood.split("-").first}"
    end
    s 
  end
  
  def start_date_with_duration
    s = I18n.l(available_on, :format => "%d.%m.")
    unless available_months == "unlimited"
      s << "/#{model.available_months}"
    end
    s
  end
  
  def id
    model.id
  end
  
  private
  
    def available_months
      return "unlimited" unless model.available_months
      "#{model.available_months} month#{model.available_months == 1 ? '' : 's'}"
    end
end