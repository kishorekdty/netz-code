DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql', #'mysql', 'sqlite3' or 'oracle'.
        'NAME': 'online_examination',                      # Or path to database file if using sqlite3.
        # The following settings are not used with sqlite3:
        'USER': 'root',
        'PASSWORD': 'root',
        'HOST': '',                      # Empty for localhost through domain sockets or '127.0.0.1' for localhost through TCP.
        'PORT': '',                      # Set to empty string for default.
    }
}
