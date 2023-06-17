from django.shortcuts import render

# Create your views here.
def menu_items(request):
    return render(request, 'menu/index.html')
