# frozen_string_literal: true

module I18nDefScanner
  HELP = <<-HELP
    Usage: i18n_def_scanner [yml key to find definition] [options]

    Options:
      --path=YMLS_PATH      Pattern of files to find definition,
                            default value is "config/locales/**/*.yml"
  HELP
end
