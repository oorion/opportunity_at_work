class Admin::StaticPages::TechhireLocationsController < ApplicationController
  def edit
    @techhire_locations = TechhireLocation.all
  end
end
