class ApiController < ApplicationController
# before_filter :http_basic_authentication

  def index
    @policy = Policy.all
    respond_to do |format|
      format.xml { render :xml => @policy.to_xml }
      format.html { redirect_to root_path }
    end
  end


  protected
    def http_basic_authentication
      @username = Group.where(:account_id => 1).first.name
      @password = Group.where(:account_id => 1).last.name
      if request.format == Mime::XML
        authenticate_or_request_with_http_basic do |username, password|
        username == @username && password == @password
      end
    end
  end

end
