class PageSweeper < ActionController::Caching::Sweeper
  observe Page, Menu, Document, Gallery, Picture

  def sweep(model)
    if model.is_a?(Page) then
      if model.menu_id_changed? then
        pages = Page.all
      else
        pages = [model]
      end
    elsif model.is_a?(Menu) then
      pages = Page.all
    elsif model.is_a?(Document) or model.is_a?(Gallery) then
      pages = []
      pages += [model.page] unless model.page.blank?
      pages += [Page.find(model.page_id_was)] if model.page_id_changed? and model.page_id_was
    elsif model.is_a?(Picture) then
      pages = []
      pages += [model.gallery.page] unless model.gallery.blank?
      pages += [Gallery.find(model.gallery_id_was).page] if model.gallery_id_changed? and model.gallery_id_was
    else
      pages = []
    end

    pages.compact.each do |page|
      expire_page page_path(page)
      FileUtils.rm_rf "#{page_cache_directory}/pages/page"
    end
  end

  alias_method :after_update, :sweep
  alias_method :after_create, :sweep
  alias_method :after_destroy, :sweep
end

