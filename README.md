# I18nRailsHelpers

[![Build Status](https://secure.travis-ci.org/huerlisi/i18n_rails_helpers.png)](http://travis-ci.org/huerlisi/i18n_rails_helpers)

Rails i18n view helpers for things like crud actions, models and and attributes.

- [Install](#install)
- [Examples](#examples)
  - [View Helpers](#view-helpers)
    - [t_attr](#t_attr)
    - [t_title](#t_title)
    - [t_action](#t_action)
    - [t_confirm_delete](#t_confirm_delete)
    - [t_select_prompt](#t_select_prompt)
  - [Controller Helpers](#controller-helpers)
    - [redirect_notice](#redirect_notice)
    - [t_attr](#t_attr-1)
    - [t_title](#t_title-1)
    - [t_action](#t_action-1)
  - [Model helpers](#model-helpers)
    - [enum_attribute_t methods](#enum_attribute_t-methods)
    - [t_enum](#t_enum)
  - [Required translations in locales (`config/locales/zz.yml`)](#required-translations-in-locales-configlocaleszzyml)
- [License](#license)

## Install

In Rails simply add this to your Gemfile:

```ruby
gem 'i18n_rails_helpers'
```

## Examples

### View Helpers

#### t_attr

```ruby
t_attr('first_name', Patient) # en: 'First name' de: 'Vorname' - when called from views of any controller
t_attr('first_name')          # en: 'First name' de: 'Vorname' - when called in patients_controller views
t_attr(:first_name)           # en: 'First name' de: 'Vorname' - can also be called with symbols
```

#### t_title

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

#### t_action

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

#### t_confirm_delete

```ruby
t_confirm_delete(@account) # en: 'Really delete account Kasse?' de: 'Konto Kasse wirklich löschen?'
```

#### t_select_prompt

```ruby
t_select_prompt(@account) # en: 'Select Account' de: 'Konto auswählen'
```

### Controller Helpers

#### redirect_notice

```ruby
def create
  # ...
  redirect_to some_path, redirect_notice           # => 'Klient erstellt.'
  redirect_to some_path, redirect_notice(@client)  # => 'Klient Example Client erstellt.'
end

def update
  # ...
  redirect_to some_path, redirect_notice           # => 'Klient geändert.'
  redirect_to some_path, redirect_notice(@client)  # => 'Klient Example Client geändert.'
end


def destroy
  # ...
  redirect_to some_path, redirect_notice           # => 'Klient gelöscht.'
  redirect_to some_path, redirect_notice(@client)  # => 'Klient Example Client gelöscht.'
end
```

#### t_attr

- [t_attr](#t_attr)

#### t_title

- [t_title](#t_title)

#### t_action

- [t_action](#t_action)

### Model helpers

#### enum_attribute_t methods

Automaticly generated enum attribut translation methods.

*[Required translations](#required-translations-in-locales-configlocaleszzyml)*.

```ruby
# Client model
enum gender: { undefined: 0, female: 1, male: 2, xy: 3 }

# in use
Client.first.gender    # => 'female'
Client.first.gender_t  # de: => 'Frau', en: => 'Woman'
Client.first.genders_t # => { undefined: 'Nicht definiert', female: 'Frau', male: 'Mann' }
```

#### t_enum

```ruby
# Client model
enum gender: { undefined: 0, female: 1, male: 2, xy: 3 }

Client.first.gender # => 'female'
Client.first.t_enum(:gender) # de: => 'Frau', en: => 'Women'
Client.first.t_enum(:gender, :male) # de: => 'Mann', en: => 'Men'
```

### Required translations in locales (`config/locales/zz.yml`)

```yaml
---
de:
  activerecord:
    attributes:
      client:
        genders:
          undefined: Nicht definiert
          female: Frau
          male: Mann
---
en:
  activerecord:
    attributes:
      client:
        genders:
          undefined: Not defined
          female: Women
          male: Man
---
fr:
# ...
```

## License

Released under the MIT license.
