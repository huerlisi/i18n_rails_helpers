I18nRailsHelpers
================

Rails i18n view helpers for things like crud actions, models and and attributes.


Example
=======

 t_attr('first_name')          => 'Vorname' # when called in patients_controller views
 t_model                       => 'Konto' # when called in patients_controller views
 t_title('delete')             => 'Konto löschen' # when called in accounts_controller views
 t_action('index')             => 'Liste'
 t_confirm_delete(@account)    => 'Konto Kasse wirklich löschen'


Copyright (c) 2010 Simon Hürlimann <simon.huerlimann@cyt.ch>
Copyright (c) 2010 CyT <http://www.cyt.ch>

Released under the MIT license.
