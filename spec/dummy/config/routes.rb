Rails.application.routes.draw do
  mount KdsCategoryService::Engine => "/kds_category_service"
end
