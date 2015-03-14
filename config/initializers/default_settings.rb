Rails.cache.delete('settings:home_page.general.plugins')
Setting.defaults['home_page.general.plugins'] = ['home_page']
Rails.cache.delete('settings:home_page.general.navigation.items')
Setting.defaults['home_page.general.navigation.items'] = ['users', 'settings', 'authentication']