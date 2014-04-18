class ApplicationController < ActionController::Base
  protect_from_forgery
    rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => "Usted no tiene permisos para realizar esta accion"
  end
end
