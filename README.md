Findtime Notes
======

### to-do (meta huh?)
- ~~ CSS ~~
  - Make each row collapsible
- ~~ Devise ~~
  - Guest account
- Omniauth
- ~~Parse natural language on index page~~
- Implement tagging
- Recurring Tasks
- Complete Tasks
- Date Picker
- Add Notes
- Sharing tasks

## ISSUE
- nickel won't parse times without a day:
`n = Nickel.parse("walk joe 9pm")`
- nickel crashes on time like
 `fri 20:30 element 19 Albion Street Illians birthday`
## CSS
Make each row collapsible
like [pullman apartments][13]
now done. but perhaps change icon [as shown here][15]
## Tags
Probably not use [acts as taggable][2]. Rolling my own as outlined in [railscasts][4] seems better option.  To do this want to use [nested sets][11] ideally.
## Misc
[update on index view:][1]

## Notes
allow notes to be fully MD compliant: http://railscasts.com/episodes/272-markdown-with-redcarpet - move this doc to internal notes.

## Calendars
Probably will use [this date picker][9]
actually [this looks better][14]
rbates on calendars [here][8]: 

## Recurring Events
[ice cube for recurring events][5] 
also
[this stack overflow][12]

## Devise
Notes on having [login on any page][7] 

Needed [this][6] to allow the user to be redirected to the sign-in page without being logged in
This is not really important as next step is to allow a [Guest User][3]

## Settings
Going to use [settings][10] for things like

- Default period for new task (i.e. today, next hour, tomorrow)
[15]: http://stackoverflow.com/questions/14882404/twitter-bootstrap-accordion-icon-doesnt-change
[14]: http://tarruda.github.io/bootstrap-datetimepicker/
[13]: http://pullmanapartments.com/
[12]: http://stackoverflow.com/questions/5183630/calendar-recurring-repeating-events-best-storage-method
[3]: https://github.com/plataformatec/devise/wiki/How-To:-Create-a-guest-user
[2]: https://github.com/mbleigh/acts-as-taggable-on 
[1]: http://stackoverflow.com/questions/14809189/how-to-add-a-boolean-toogle-to-a-rails-index-view) 
[4]: http://railscasts.com/episodes/382-tagging
[5]: https://github.com/seejohnrun/ice_cube
[6]:
http://stackoverflow.com/questions/6209663/how-to-skip-a-before-filter-for-devises-sessionscontroller
[7]: https://github.com/plataformatec/devise/wiki/How-To%3a-Display-a-custom-sign_in-form-anywhere-in-your-app
[8]: http://railscasts.com/episodes/213-calendars-revised?view=comments
[9]:  http://trentrichardson.com/examples/timepicker/
[10]: https://github.com/renderedtext/rails-settings
[11]: https://github.com/collectiveidea/awesome_nested_set/wiki/Awesome-nested-set-cheat-sheet
