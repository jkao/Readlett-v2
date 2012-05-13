module ApiResponseLibrary

  def render_collection_json(json)
    render :json => json, :status => "200", :content_type => "application/json"
  end

  # Renders JSON with Respective Response Codes
  def render_json(json)
    if json[:error].nil?
      render :json => json, :status => "200", :content_type => "application/json"
    else
      render :json => json, :status => "400", :content_type => "application/json"
    end
  end

end
