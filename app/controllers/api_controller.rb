class ApiController < ApplicationController
before_filter :http_basic_authentication

  def index
    @devices = Group.all
    respond_to do |format|
      format.xml { render :xml => @devices.to_xml }
      format.html { redirect_to root_path }
    end
  end


  protected
    def http_basic_authentication
      @username = Group.first.name
      @password = Group.last.name
      if request.format == Mime::XML
        authenticate_or_request_with_http_basic do |username, password|
        username == @username && password == @password
      end
    end
  end

end
