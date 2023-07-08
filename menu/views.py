from django.shortcuts import render
from .models import MenuItem



def menu_items(request):
    menu_items = MenuItem.objects.all()
    return render(request, 'menu/index.html', {'menu_items': menu_items})

