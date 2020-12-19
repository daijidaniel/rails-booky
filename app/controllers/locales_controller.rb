class LocalesController < ApplicationController
  def english
    cookies[:locale] = :en
    I18n.locale = :en
  end

  def polish
    cookies[:locale] = :pl
    I18n.locale = :pl
  end
end


