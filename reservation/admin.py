from django.contrib import admin
from .models import Reservation

# Register your models here.


@admin.register(Reservation)
class ReservationAdmin(admin.ModelAdmin):
    list_display = ('user', 'date', 'time', 'guest_name')
    list_filter = ('date', 'time')
    search_fields = ('user__username', 'user__email')


admin.site.site_header = 'Restaurant Administration'
admin.site.site_title = 'Restaurant Admin'