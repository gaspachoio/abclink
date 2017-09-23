class PagesController < InlineFormsController
  layout 'application'
  set_tab :page

  before_action :authenticate_user!, :except => [:slug]

  def slug
    @page = Page.find_by!(slug: params[:slug])
  end
end
