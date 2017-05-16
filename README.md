# I18nRailsHelpers

[![Build Status](https://secure.travis-ci.org/huerlisi/i18n_rails_helpers.png)](http://travis-ci.org/huerlisi/i18n_rails_helpers)

Rails i18n view helpers for things like crud actions, models and and attributes.

- [Install](#install)
- [Examples](#examples)
  - [t_attr](#t_attr)
  - [t_title](#t_title)
  - [t_model](#t_model)
  - [t_action](#t_action)
  - [t_confirm_delete](#t_confirm_delete)
  - [t_select_prompt](#t_select_prompt)
- [License](#license)

## Install

In Rails simply add this to your Gemfile:

```ruby
gem 'i18n_rails_helpers'
```

## Examples

### t_attr

```ruby
t_attr('first_name', Patient) # en: 'First name' de: 'Vorname' - when called from views of any controller
t_attr('first_name')          # en: 'First name' de: 'Vorname' - when called in patients_controller views
t_attr(:first_name)           # en: 'First name' de: 'Vorname' - can also be called with symbols
```

### t_title

```ruby
t_title(:index)   # en: "%{model} index" ,  de: "%{model} Liste"
t_title(:edit)    # en: "Edit %{model}",    de: "%{model} bearbeiten"
t_title(:update)  # en: "Edit %{model}",    de: "%{model} bearbeiten"
t_title(:show)    # en: "Show %{model}",    de: "%{model} anzeigen"
t_title(:new)     # en: "New %{model}",     de: "%{model} erfassen"
t_title(:create)  # en: "New %{model}",     de: "%{model} erfassen"
t_title(:delete)  # en: "Delete %{model}",  de: "%{model} löschen"
t_title(:destroy) # en: "Delete %{model}",  de: "%{model} löschen"
```

### t_model

t_model(model = nil, count: 1)

```ruby
t_model                   # en: 'Account', de: 'Konto'   # if called in account_controller views
t_model(count: 2)         # en: 'Accounts', de: 'Konten' # if called in account_controller views
t_model(Client)           # en: 'Client', de: 'Kunde'
t_model(Client, count: 2) # en: 'Clients', de: 'Kunden'
```

### t_action

```ruby
t_action(:index)    # en: "Index",     de: "Liste"
t_action(:edit)     # en: "Edit",      de: "Bearbeiten"
t_action(:update)   # en: "Edit",      de: "Bearbeiten"
t_action(:show)     # en: "Show",      de: "Anzeigen"
t_action(:new)      # en: "New",       de: "Erfassen"
t_action(:create)   # en: "New",       de: "Erfassen"
t_action(:delete)   # en: "Delete",    de: "Löschen"
t_action(:destroy)  # en: "Delete",    de: "Löschen"
t_action(:cancel)   # en: "Abbrechen", de: "Abbrechen"
t_action(:back)     # en: "Back",      de: "Zurück"
t_action(:previous) # en: "Previous",  de: "Zurück"
t_action(:next)     # en: "Next",      de: "Weiter"
```

### t_confirm_delete

```ruby
t_confirm_delete(@account) # en: 'Really delete account Kasse?' de: 'Konto Kasse wirklich löschen?'
```

### t_select_prompt

```ruby
t_select_prompt(@account) # en: 'Select Account' de: 'Konto auswählen'
```

## License

Released under the MIT license.
