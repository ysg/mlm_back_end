class IdentitiesController < ApplicationController
  def new
    @identity = env['omniauth.identity']
    @user = User.new
    Identity::USER_ATTRIBUTES.each do |attr|
      @identity.attributes.merge!(attr => params[attr]) if @identity.present?
    end
    accessible_attributes = User.accessible_attributes.to_a
    accessible_attributes.shift()
    accessible_attributes.each do |attr|
      @user.send(attr+"=",params[attr]) if params[attr].present?
    end
  end
end
