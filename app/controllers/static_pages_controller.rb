class StaticPagesController < ApplicationController
  layout :resolve_layout
  
  def inprogress; end

  def terms_of_service; end

  def faq; end

  def privacy_policy; end

  private 

  def resolve_layout
    action_name == 'inprogress' ? 'blank' : 'application'
  end
end
