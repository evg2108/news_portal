#= require active_admin/base
#= require select2/dist/js/select2
#= require lib/select2-custom
#= require jquery-datetimepicker/build/jquery.datetimepicker.full

$ ->
  $('.date-time-picker').datetimepicker
    format:'Y-m-d H:i'
    formatTime:'H:i'
    formatDate:'Y-m-d'
    step: 10