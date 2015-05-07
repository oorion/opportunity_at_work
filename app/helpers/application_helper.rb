module ApplicationHelper
  def state_helper
    alphastates = State.all.map(&:abbr)
    return alphastates.insert(0, ["Please select..."])
  end

  def city_helper(state_abbr)
    state = State.find_by(abbr: state_abbr)
    cities = state.usa_cities.pluck(:name)
    return cities.insert(0, ["Please select..."])
  end
end
