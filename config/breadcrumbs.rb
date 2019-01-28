crumb :root do
  link "Home", root_path
end

crumb :users do
  link I18n.t('views.users.plural')
end

crumb :master_activities do
  link I18n.t('views.master_activities.plural')
end

crumb :activity_profiles do
  link I18n.t('views.activity_profiles.plural')
end

crumb :clients do
  link I18n.t('views.clients.plural'), clients_path
end

crumb :client do |client|
  link I18n.t('activerecord.models.client')
  parent :clients
end
